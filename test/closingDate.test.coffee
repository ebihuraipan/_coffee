import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest'
import { mount } from '@vue/test-utils'
import ClosingDate from '../src/components/ClosingDate.vue'
import {
	SUNDAY, MONDAY, TUESDAY, WEDNESDAY,
	THURSDAY, FRIDAY, SATURDAY,
	OPEN, CLOSE, IRREGULAR, NOT_IRREGULAR
} from '../src/utils/constants.coffee'


# yasumi を渡してマウントし、setup返却APIを取り出すヘルパ
setupApi = (yasumi = {}) ->
	wrapper = mount(ClosingDate, { props: { yasumi } })
	wrapper.vm


afterEach ->
	vi.useRealTimers()


describe 'ClosingDate', ->

	describe '定休なし (yasumi = {})  / 今日: 2026-05-04(月)', ->
		vm = null
		beforeEach ->
			vi.useFakeTimers()
			vi.setSystemTime(new Date('2026-05-04T00:00:00'))
			vm = setupApi()
		it 'buildCloseText は空文字', ->
			expect(vm.buildCloseText()).toBe ""
		it '今日(月)はOPEN', ->
			expect(vm.isOpen(vm.get_today())).toBe OPEN
		it '明日(火)はOPEN', ->
			expect(vm.isOpen(vm.get_tomorrow())).toBe OPEN
		it 'isIrregular は NOT_IRREGULAR', ->
			expect(vm.isIrregular()).toBe NOT_IRREGULAR

	describe '月曜定休 (yasumi.week = [MONDAY]) / 今日: 2026-05-04(月)', ->
		vm = null
		beforeEach ->
			vi.useFakeTimers()
			vi.setSystemTime(new Date('2026-05-04T00:00:00'))
			vm = setupApi({ week: [ MONDAY ] })
		it 'buildCloseText は「月曜日」', ->
			expect(vm.buildCloseText()).toBe "月曜日"
		it '今日(月)はCLOSE', ->
			expect(vm.isOpen(vm.get_today())).toBe CLOSE
		it '明日(火)はOPEN', ->
			expect(vm.isOpen(vm.get_tomorrow())).toBe OPEN
		it 'setLamp(今日) は🔴', ->
			expect(vm.setLamp(vm.isOpen(vm.get_today()))).toBe "🔴"
		it 'setLamp(明日) は🟢', ->
			expect(vm.setLamp(vm.isOpen(vm.get_tomorrow()))).toBe "🟢"
		it 'isIrregular は NOT_IRREGULAR', ->
			expect(vm.isIrregular()).toBe NOT_IRREGULAR

	describe '月曜＋火曜定休 / 今日: 2026-05-05(火)', ->
		vm = null
		beforeEach ->
			vi.useFakeTimers()
			vi.setSystemTime(new Date('2026-05-05T00:00:00'))
			vm = setupApi({ week: [ MONDAY, TUESDAY ] })
		it 'buildCloseText は「月曜日、火曜日」', ->
			expect(vm.buildCloseText()).toBe "月曜日、火曜日"
		it '今日(火)はCLOSE', ->
			expect(vm.isOpen(vm.get_today())).toBe CLOSE
		it '明日(水)はOPEN', ->
			expect(vm.isOpen(vm.get_tomorrow())).toBe OPEN

	describe '第2月曜定休 / 今日: 2026-05-04(月・第2週)', ->
		vm = null
		beforeEach ->
			vi.useFakeTimers()
			vi.setSystemTime(new Date('2026-05-04T00:00:00'))
			vm = setupApi({
				nthMonth: [ { weekCount: 2, week: MONDAY } ]
			})
		it 'buildCloseText は「第2月曜日」', ->
			expect(vm.buildCloseText()).toBe "第2月曜日"
		it '今日(第2月)はCLOSE', ->
			expect(vm.isOpen(vm.get_today())).toBe CLOSE
		it '明日(火)はOPEN', ->
			expect(vm.isOpen(vm.get_tomorrow())).toBe OPEN

	describe '第2月曜定休 / 今日: 2026-05-11(月・第3週) → 通常営業日', ->
		vm = null
		beforeEach ->
			vi.useFakeTimers()
			vi.setSystemTime(new Date('2026-05-11T00:00:00'))
			vm = setupApi({
				nthMonth: [ { weekCount: 2, week: MONDAY } ]
			})
		it '今日(第3月)はOPEN', ->
			expect(vm.isOpen(vm.get_today())).toBe OPEN

	describe '不定休フラグのみ / 今日: 2026-05-04(月)', ->
		vm = null
		beforeEach ->
			vi.useFakeTimers()
			vi.setSystemTime(new Date('2026-05-04T00:00:00'))
			vm = setupApi({ irregular: true })
		it 'buildCloseText は「不定休」', ->
			expect(vm.buildCloseText()).toBe "不定休"
		it 'isIrregular は IRREGULAR', ->
			expect(vm.isIrregular()).toBe IRREGULAR
		it 'setLamp(IRREGULAR) は🟡', ->
			expect(vm.setLamp(vm.isIrregular())).toBe "🟡"
		it '今日(月)はOPEN (定休曜日指定なし)', ->
			expect(vm.isOpen(vm.get_today())).toBe OPEN

	describe '不定休 + 水曜定休 / 今日: 2026-05-06(水)', ->
		vm = null
		beforeEach ->
			vi.useFakeTimers()
			vi.setSystemTime(new Date('2026-05-06T00:00:00'))
			vm = setupApi({
				irregular: true
				week: [ WEDNESDAY ]
			})
		it 'buildCloseText は「不定休、水曜日」', ->
			expect(vm.buildCloseText()).toBe "不定休、水曜日"
		it '今日(水)はCLOSE', ->
			expect(vm.isOpen(vm.get_today())).toBe CLOSE
		it '明日(木)はOPEN', ->
			expect(vm.isOpen(vm.get_tomorrow())).toBe OPEN
		it 'isIrregular は IRREGULAR', ->
			expect(vm.isIrregular()).toBe IRREGULAR

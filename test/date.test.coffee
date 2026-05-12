import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest'
import { get_week, get_week_of_month } from '../src/utils/date.coffee'
import {
	SUNDAY, MONDAY, TUESDAY, WEDNESDAY,
	THURSDAY, FRIDAY, SATURDAY
} from '../src/utils/constants.coffee'





beforeEach ->
	
afterEach ->
	vi.useRealTimers()


describe '日付関数', ->
	it '水曜日を返す', ->
		vi.useFakeTimers(new Date('2026-04-29'))
		expect(get_week('2026-04-27')).toBe MONDAY
	it '金曜日を返す', ->
		vi.useFakeTimers(new Date('2026-05-01'))
		expect(get_week('2026-05-01')).toBe FRIDAY

	it '第1週: 5/2(土)', ->
		expect(get_week_of_month('2026-05-02')).toBe 1
	it '第2週: 5/3(日)', ->
		expect(get_week_of_month('2026-05-03')).toBe 2
	it '第2週: 5/4(月)', ->
		expect(get_week_of_month('2026-05-04')).toBe 2
	it '第3週: 5/10(日)', ->
		expect(get_week_of_month('2026-05-10')).toBe 3
	it '第3週: 5/11(月)', ->
		expect(get_week_of_month('2026-05-11')).toBe 3
	it '第3週: 5/16(土)', ->
		expect(get_week_of_month('2026-05-16')).toBe 3




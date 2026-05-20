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
	it '2026-04-27で水曜日を返す', ->
		# vi.useFakeTimers(new Date('2026-04-29'))
		expect(get_week('2026-04-27')).toBe MONDAY
	it '2026-05-01で金曜日を返す', ->
		# vi.useFakeTimers(new Date('2026-05-01'))
		expect(get_week('2026-05-01')).toBe FRIDAY

	it '2026-05-02は第1週(土)', ->
		expect(get_week_of_month('2026-05-02')).toBe 1
	it '2026-05-03は第2週(日)', ->
		expect(get_week_of_month('2026-05-03')).toBe 2
	it '2026-05-04は第2週(月)', ->
		expect(get_week_of_month('2026-05-04')).toBe 2
	it '2026-05-10は第3週(日)', ->
		expect(get_week_of_month('2026-05-10')).toBe 3
	it '2026-05-11は第3週(月)', ->
		expect(get_week_of_month('2026-05-11')).toBe 3
	it '2026-05-16は第3週(土)', ->
		expect(get_week_of_month('2026-05-16')).toBe 3




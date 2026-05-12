import dayjs from 'dayjs'
import { WEEK_KEYS } from './constants.coffee'

# "yyyy-mm-dd" を受け取って曜日の英語略称を返す
export get_week = (date) ->
	dayjs(date).day()

# "yyyy-mm-dd" を受け取って月の第何週かを返す（1〜5）
# 月初の曜日をオフセットとして加算し、日曜始まりのカレンダー週で計算
# 例: 2026/05/03(日) → 月初5月1日が金曜(=5) → (3+5)/7 切り上げ → 第2週
export get_week_of_month = (date) ->
	d = dayjs(date)
	firstDayOffset = d.startOf('month').day()
	Math.ceil (d.date() + firstDayOffset) / 7

export get_today = ->
	return dayjs().format("YYYY-MM-DD")

export get_tomorrow = ->
	return dayjs().add(1, 'day').format("YYYY-MM-DD")

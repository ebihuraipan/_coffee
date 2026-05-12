<script lang="coffee">
import { ref } from 'vue'
import {
	IRREGULAR,
	NOT_IRREGULAR,
	OPEN,
	CLOSE,
	WEEK_JA
} from '../utils/constants.coffee'
import {
	get_week,
	get_week_of_month,
	get_today,
	get_tomorrow
} from '../utils/date.coffee'

export default
	name: 'TategakiDayFlag'
	props:
		yasumi:
			type: Object
			default: -> {}
	setup: (props) ->
		# 開店中か
		isOpen = ( date ) ->
			if props.yasumi.week
				_week = get_week( date )
				if props.yasumi.week.includes( _week )
					return CLOSE
			if props.yasumi.nthMonth
				for line in props.yasumi.nthMonth
					isWeekCount = line.weekCount == get_week_of_month(date)
					isWeek = line.week == get_week(date)
					if isWeekCount && isWeek
						return CLOSE
			return OPEN
		setLamp = ( isOpen ) ->
			if isOpen == OPEN
				"🟢"
			else if isOpen == IRREGULAR
				"🟡"
			else if isOpen == CLOSE
				"🔴"
		isIrregular = () ->
			if props.yasumi.irregular
				return IRREGULAR
			return NOT_IRREGULAR
		# 開店閉店テキスト
		buildIsOpenText = ( _isOpen ) ->
			if _isOpen == OPEN
				"開店日"
			else if _isOpen == IRREGULAR
				"不定休"
			else if _isOpen == CLOSE
				"店休日"
		buildCloseText = ( isOpen ) ->
			_closeText = ""
			if props.yasumi.irregular
				_closeText += "不定休、"
			if props.yasumi.week
				for line in props.yasumi.week
					_closeText += WEEK_JA[ line ] + "曜日、"
			if props.yasumi.nthMonth
				for line in props.yasumi.nthMonth
					_closeText += "第" + line.weekCount + "" + WEEK_JA[ line.week ] + "曜日、"
			_closeText = _closeText.substring( 0, _closeText.length - 1 )
			return _closeText
		{
			isOpen,
			setLamp,
			isIrregular,
			get_today, get_tomorrow,
			buildIsOpenText,
			buildCloseText,
			IRREGULAR
		}
</script>

<template>
	<span class="fs20">
		{{ buildCloseText() }}
	</span>
	<br>
	<div class="mt20">
		<span>
			{{ setLamp( isOpen( get_today() ) ) }}
			今日
			{{ buildIsOpenText( isOpen( get_today() ) ) }}
		</span>
		<br>
		<span>
			{{ setLamp( isOpen( get_tomorrow() ) ) }}
			明日
			{{ buildIsOpenText( isOpen( get_tomorrow() ) ) }}
		</span>
		<br>
		<span v-show="isIrregular()">
			{{ setLamp( IRREGULAR ) }}
			不定休あり
		</span>
	</div>
</template>

<style scoped>
.item {
	min-height: 50vh;
	border: 1px solid currentColor;
	padding: 0.4em 0.6em;
	white-space: nowrap;
	display: inline-block;
	vertical-align: top;
	user-select: none;
	-webkit-user-select: none;
}
.hurigana{
	position:relative;
	font-size:12px;
}
</style>

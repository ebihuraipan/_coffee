<script lang="coffee">
import { ref } from 'vue'

export default
	name: 'DialogWarning'
	props:
		isShow:
			type: Boolean
			default: false
	setup: (props) ->
		# 表示非表示
		visible = ref props.isShow
		clickLine = ->
			visible.value = !visible.value
		{
			visible,
			clickLine
		}
</script>

<template>
	<div id="warning" @click="clickLine()" class="waku p10">
		<div>
			＊注意書き＊
		</div>
		<div v-if="visible" class="font_normal">
			<ul>
				<li>
					あくまで【珈琲が美味しいお店】であって【一般的に素敵なお店】ではありません。
					個性が強すぎ、メニューが珈琲しかない、など
					万人受けしないお店もあります
				</li>
				<li>
					数年前に行ってる所もあるので最新情報を確認してください。
					カフェのサイクルはとても早く、
					閉店してるかもしれません…
				</li>
			</ul>
		</div>
	</div>
</template>

<style scoped>

#warning {
	color: brown;
}

ul {
	white-space: normal;
}

</style>

<script lang="coffee">
import { ref, onMounted, nextTick, computed } from 'vue'
import miseData from '../data/miseData.json'
import TategakiLine from './TategakiLine.vue'
import TategakiWarning from './TategakiWarning.vue'
import DWarning from './dialog/Warning.vue'
import DTechnology from './dialog/Technology.vue'
import { GROUP_ORDER } from '../utils/constants.coffee'

export default
	name: 'TategakiView'
	components: { TategakiLine, DWarning, DTechnology }
	setup: ->
		scrollRef = ref null
		onMounted ->
			nextTick ->
				# 描画が終わってから scroll 位置をセットする
				requestAnimationFrame ->
					el = scrollRef.value
					el.scrollLeft = el.scrollWidth - el.clientWidth if el
		sortedMise = computed ->
			[...miseData]
				.filter (d) -> d.isShow
				.sort (a, b) ->
					ai = GROUP_ORDER.indexOf a.jusho_group
					bi = GROUP_ORDER.indexOf b.jusho_group
					(if ai < 0 then 999 else ai) - (if bi < 0 then 999 else bi)
		{ scrollRef, sortedMise }
</script>

<template>
<div id="tategaki_scroll">
	<b class="font_kouzan fs50">
		福岡喫茶めぐり
	</b>

	<!-- <DTechnology /> -->
	<br><br>
	<div>
		<div class="mt30 h80">
			<DWarning />
			<DTechnology />
			<!-- <TategakiWarning :isShow="false" /> -->
		</div>
	</div>
	<br>
	<template v-for="( mdata, i ) of sortedMise" :key="i">
		<template v-if="mdata.isShow">
			<div style="padding:10px;">
				<TategakiLine :mdata="mdata" :isShow="false" />
			</div>
		</template>
	</template>
</div>
</template>

<style scoped>
#tategaki_scroll {
	width: 100%;
	height: 100vh;
	padding: 0;
	touch-action: pan-x;
	-webkit-overflow-scrolling: touch;
	
	/* 縦書きスクロール */
	overflow-x: scroll;
	overflow-y: hidden;
	writing-mode: vertical-rl;
}
</style>

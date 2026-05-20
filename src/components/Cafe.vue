<script lang="coffee">
import { ref } from 'vue'
import ClosingDate from './ClosingDate.vue'

export default
	name: 'Cafe'
	components: { ClosingDate }
	props:
		mdata:
			type: Object
			default: -> {}
		isShow:
			type: Boolean
			default: false
	setup: (props) ->
		visible = ref props.isShow
		copied = ref false
		clickLine = ->
			visible.value = !visible.value
		copyMise = ->
			navigator.clipboard.writeText props.mdata.mise
			copied.value = true
			setTimeout (-> copied.value = false), 1500
		copyJusho = ->
			navigator.clipboard.writeText props.mdata.jusho
			copied.value = true
			setTimeout (-> copied.value = false), 1500
		{
			visible,
			copied,
			clickLine,
			copyMise,
			copyJusho
		}
</script>

<template>
	<div class="line">
		<div style="background-color: rgba(235, 102, 30, 0.1);">
			<div @click="clickLine()" class="row fire yubi">
				<div  class="col">
					<div class="hurigana">
						{{ mdata.yomigana }}
					</div>
					<div :class="{ fire: visible }">
						<span class="fs30 font_kouzan">
							{{ mdata.mise }}
						</span>
					</div>
				</div>
				<div class="col center1 center2">
					<span class="fs20 font_kouzan">
						…{{ mdata.jusho_group }}
					</span>
				</div>
			</div>
		</div>
		
		<Transition name="slide">
			<div v-show="visible" class="col mt10 p10">
				<!-- 住所 -->
				<div class="col p10">
					<div>
						<span class="mt10">住所</span>
					</div>
					<div class="row mt30 center1">
						<a :href="`https://maps.google.com/?q=${encodeURIComponent(mdata.jusho)}`" target="_blank" rel="noopener">
							{{ mdata.jusho }}
						</a>
					</div>
				</div>
				<!-- 店休日 -->
				<div class="col p10">
					<div>
						<span class="mt10">店休日</span>
					</div>
					<div class="mt30">
						<ClosingDate :yasumi="mdata.yasumi" />
					</div>
				</div>

				<!-- コピー -->
				<div class="col p10">
					<div>
						<span class="mt10">コピー</span>
					</div>
					<div class="p10">
						<div class="fire waku mt30" @click.stop="copyMise()">
							店名コピー
						</div>
						<div class="fire waku mt30" @click.stop="copyJusho()">
							住所コピー
						</div>
					</div>
				</div>
				
				<!-- 備考 -->
				<div class="col p10">
					<div>
						<span class="mt10">備考</span>
					</div>
					<div class="mt30">
						<pre class="font_normal">{{ mdata.bikou }}</pre>
					</div>
				</div>
			</div>
		</Transition>
	</div>

	<Teleport to="body">
		<Transition name="toast">
			<div v-if="copied" class="toast-popup">コピーしました</div>
		</Transition>
	</Teleport>
</template>

<style scoped>
.line{
	height: 90vh;
	margin-top: 5vh;	
	background-color: rgba(235, 102, 30, 0.1);
	/* mask-image: linear-gradient(to bottom, black 50%, transparent 100%); */
	/* -webkit-mask-image: linear-gradient(to bottom, black 50%, transparent 100%); */
}

.hurigana{
	position:relative;
	font-size:15px;
	font-family: serif;
}
.fire {
    filter: drop-shadow(0 0 2px rgb(246, 119, 76)) drop-shadow(0 0 20px rgba(235, 102, 30, 0.6));
}

:global(.toast-popup) {
    position: fixed;
    top: 20px;
    left: 20px;
    writing-mode: vertical-rl;
    background: rgba(235, 102, 30, 0.88);
    color: white;
    padding: 12px 8px;
    border-radius: 6px;
    font-size: 18px;
    z-index: 9999;
    pointer-events: none;
    filter: drop-shadow(0 0 6px rgba(235, 102, 30, 0.6));
}
:global(.toast-enter-active),
:global(.toast-leave-active) {
    transition: opacity 0.3s ease, transform 0.3s ease;
}
:global(.toast-enter-from),
:global(.toast-leave-to) {
    opacity: 0;
    transform: translateY(-8px);
}

.slide-enter-active,
.slide-leave-active {
    transition: transform 0.35s ease, opacity 0.35s ease;
}
.slide-enter-from,
.slide-leave-to {
    transform: translateX(30px);
    opacity: 0;
}


</style>

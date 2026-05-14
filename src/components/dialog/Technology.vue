<script lang="coffee">
import { ref } from 'vue'

export default
	name: 'DialogTechnology'
	setup: ->
		dialogRef = ref null
		openDialog = -> dialogRef.value?.showModal()
		closeDialog = -> dialogRef.value?.close()
		{ dialogRef, openDialog, closeDialog }
</script>

<template>
	<div id="technology" @click="openDialog" class="waku p10 mt30">
		＊技術仕様＊
	</div>
	<dialog id="technology" ref="dialogRef" >
		<div>＊技術仕様＊</div>
		<br>
		<div @click="closeDialog" class="waku p10 mt30">
			閉じる
		</div>
		<div>
			<ul>
				<li>フレームワーク・ライブラリ</li>
				<ul>
					<li>JSフレームワーク…Vuejs</li>
					<li>言語…coffeeScript</li>
					<li>日時処理…dayjs</li>
				</ul>

				<li>Web技術</li>
				<ul>
					<li>PWA（Progressive Web App）</li>
				</ul>

				<li>縦書き</li>
				<ul>
					<li>CSSのみ</li>
					<li>
						<code>writing-mode: vertical-rl;</code>
					</li>
				</ul>
				
				<li>フォント</li>
				<ul>
					<li>衡山毛筆フォント</li>
				</ul>

				<li>フォントサブセット化</li>
				<ul>
					<li>必要文字のみでフォント軽量化</li>
					<li>python -> pipx -> fonttools, brotli</li>
					<li>.otf -> .woff2</li>
				</ul>
			</ul>
		</div>
		
	</dialog>
</template>

<style scoped>

#technology {
	color: rgb(51, 107, 5);
}

ul {
	white-space: normal;
}

</style>

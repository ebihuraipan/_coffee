<script lang="coffee">
import { ref } from 'vue'

export default
	name: 'TategakiWarning'
	setup: ->
		dialogRef = ref null
		openDialog = -> dialogRef.value?.showModal()
		closeDialog = -> dialogRef.value?.close()
		{ dialogRef, openDialog, closeDialog }
</script>

<template>
	<div id="warning" @click="openDialog" class="waku p10">
		＊技術仕様＊
	</div>
	<dialog id="warning" ref="dialogRef">
		<div>＊技術仕様＊</div>
		<br>
		<div @click="closeDialog" class="waku p10 mt30">
			閉じる
		</div>
		<div>
			<ul>
				<li>
					あくまで【珈琲が美味しいお店】であって<br>
					【一般的に素敵なお店】ではありません。<br>
					個性が強すぎ、メニューが珈琲しかない、など<br>
					万人受けしないお店もあります<br>
				</li>
				<li>
					常に数年前に行ってる所もあるので<br>
					最新情報を確認してください。<br>
					カフェのサイクルはとても早く、<br>
					閉店してるかもしれません…<br>
				</li>
			</ul>
		</div>
		
		
	</dialog>
</template>

<style scoped>

#warning {
	color: brown;
}

ul {
	white-space: normal;
}

</style>

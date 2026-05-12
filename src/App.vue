<script lang="coffee">
import { ref } from 'vue'
import TategakiView from './components/TategakiView.vue'

export default
	components: { TategakiView }
</script>

<template>
	<div id="sotowaku">
		<TategakiView />
	</div>
</template>

<style scoped>
#sotowaku {
	width: 100%;
	height: 100%;
	min-width: 0;
	margin: 0;
	box-sizing: border-box;
}
</style>

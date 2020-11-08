<template>
  <div id="app">
    <keep-alive :include="cacheViews">
      <router-view v-if="isRouterAlice"/>
    </keep-alive>
    <player></player>
  </div>
</template>

<script>
import Player from './components/Player/player'
export default {
  components: { Player },
  provide () {
    return {
      reload: this.reload
    }
  },
  data () {
    return {
      isRouterAlice: true,
      cacheViews: ['Main'] // include 只有名称匹配的组件会被缓存 exclude 任何名称匹配的组件都不会被缓存
    }
  },
  methods: {
    reload () {
      this.isRouterAlice = false
      this.$nextTick(() => {
        this.isRouterAlice = true
      })
    }
  }
}
</script>

<style lang="less">
  .app {
    width: 100vw;
    height: 100vh;
  }
</style>

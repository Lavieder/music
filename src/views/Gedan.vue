<template>
  <transition name="slide">
    <div class="songlist">
      <go-back-header :title="title"></go-back-header>
      <gedan-list :list="gedanList" @selectItem="selectGedan"/>
      <router-view></router-view>
    </div>
  </transition>
</template>

<script>
import goBackHeader from '../components/Secondary/goBackHeader'
import GedanList from '../components/Secondary/Gedan/GedanList'
import { mapMutations } from 'vuex'
export default {
  components: { goBackHeader, GedanList },
  data () {
    return {
      title: '歌单推荐',
      gedanList: []
    }
  },
  mounted () {
    this.getGeDan()
  },
  methods: {
    getGeDan () {
      this.axios.get('/api/gedan/gdlist').then((res) => {
        this.gedanList = res.data
      })
    },
    ...mapMutations({
      setGedan: 'SET_GEDAN'
    }),
    selectGedan (gedan) {
      this.$router.push({
        path: `/gedan/${gedan.gdid}`
      })
      this.setGedan(gedan)
    }
  }
}
</script>

<style lang="less">
  .slide-enter,
  .slide-leave-to {
    opacity: 0;
    transform: translate3d(0,100%,0);
  }
  .slide-enter-active,
  .slide-leave-active {
    transition: all 0.2s;
  }
</style>

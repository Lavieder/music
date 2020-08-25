<template>
  <transition name="slide">
    <div class="rankboard" >
      <go-back-header :title="title"></go-back-header>
      <div class="rankcont">
        <tuijian-bod :tuijianList="tuijianList"></tuijian-bod>
        <peak-bod :peakList="peakList"></peak-bod>
        <other-bod :otherList="otherList"></other-bod>
      </div>
      <router-view></router-view>
    </div>
  </transition>
</template>

<script>
import goBackHeader from '../components/Secondary/goBackHeader'
import tuijianBod from '../components/Secondary/RankBoard/tuijianBod'
import peakBod from '../components/Secondary/RankBoard/peakBod'
import otherBod from '../components/Secondary/RankBoard/otherBod'
export default {
  components: { goBackHeader, tuijianBod, peakBod, otherBod },
  data () {
    return {
      title: '排行榜',
      tuijianList: [],
      peakList: [],
      otherList: []
    }
  },
  mounted () {
    this.getRank()
  },
  methods: {
    getRank () {
      this.axios.get('/api/rank/rklist').then((res) => {
        if (res.data) {
          this.tuijianList = res.data.tuijian
          this.peakList = res.data.peak
          this.otherList = res.data.other
        } else {
          return 0
        }
      })
    }
  }
}
</script>

<style lang="less">
  .rankboard {
    .rankcont {
      font-family: '微软雅黑';
      background: rgba(247, 247, 247);
    }
  }
</style>

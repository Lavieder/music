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
      otherList: [],
      soarSong: [],
      newSong: [],
      initSong: [],
      hotSong: []
    }
  },
  mounted () {
    this.getRankSong()
    setTimeout(() => {
      this.getRank()
    }, 100)
  },
  methods: {
    getRank () {
      this.axios.get('/api/rank/rklist').then((res) => {
        if (res.data) {
          this.tuijianList = res.data.tuijian
          this.peakList = this.concatRankSong(res.data.peak)
          this.otherList = res.data.other
        } else {
          return 0
        }
      })
    },
    getRankSong () {
      this.axios.get('/api/rank/rksong').then((res) => {
        if (res.data) {
          this.soarSong = res.data.soarSong
          this.newSong = res.data.newSong
          this.initSong = res.data.initSong
          this.hotSong = res.data.hotSong
        } else {
          return 0
        }
      })
    },
    concatRankSong (list) {
      const peakList = []
      if (list) {
        list.map((item, index) => {
          if (item.rbid === 1) {
            item.songs = this.soarSong
          }
          if (item.rbid === 2) {
            item.songs = this.newSong
          }
          if (item.rbid === 3) {
            item.songs = this.initSong
          }
          if (item.rbid === 4) {
            item.songs = this.hotSong
          }
          peakList.push(item)
        })
        // console.log(peakList)
        return peakList
      }
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

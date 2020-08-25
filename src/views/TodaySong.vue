<template>
  <transition name="slide">
    <div class="todaysong">
      <go-back-header :title="title"></go-back-header>
      <today-song-list :tdSlist="tdSlist" @selectSong="selectSong"></today-song-list>
    </div>
  </transition>
</template>

<script>
import goBackHeader from '../components/Secondary/goBackHeader'
import TodaySongList from '../components/Secondary/TodaySong/TodaySongList'
import { mapActions } from 'vuex'
export default {
  components: { TodaySongList, goBackHeader },
  data () {
    return {
      zhankai: true,
      title: '今日推荐',
      tdSlist: []
    }
  },
  mounted () {
    this.getSongList()
  },
  methods: {
    getSongList () {
      this.axios.get('/api/song/today').then((res) => {
        this.tdSlist = res.data
      })
    },
    selectSong (song, index) {
      this.selectPlay({
        list: this.tdSlist,
        index
      })
    },
    ...mapActions([
      'selectPlay'
    ])
  }

}
</script>

<style lang="less">
  .todaysong,
  .songlist,
  .rankboard {
    .gobackheader {
      box-shadow: 0 3px 25px rgba(0,0,0,.25);
      .van-nav-bar {
        background-color: rgba(87, 87, 87);
        fill: currentColor;
        color: #ffffff;
        .title {
          color: #ffffff;
        }
      }
    }
  }
</style>

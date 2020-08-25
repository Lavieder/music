<template>
  <transition name="slide" appear>
    <div class="rankdetail">
      <go-back-header :title="rank.rbTitle"></go-back-header>
      <rank-detail-data :rankDetail="rankDetail" :rkBgImage="rkBgImage" @selectItem="selectItem"></rank-detail-data>
    </div>
  </transition>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import goBackHeader from '../../goBackHeader'
import RankDetailData from '../RankDetail/rankDetailData/rankDetailData'
export default {
  components: { goBackHeader, RankDetailData },
  data () {
    return {
      rankDetail: [],
      songs: []
    }
  },
  computed: {
    ...mapGetters([
      'rank'
    ]),
    rkBgImage () {
      if (this.songs.length) {
        return this.songs[0].coverUrl
      }
      return ''
    }
  },
  mounted () {
    this.getRankDetail()
  },
  methods: {
    getRankDetail () {
      this.axios.post('/api/rank/rkdetail', this.rank).then((res) => {
        if (res.data) {
          this.rankDetail = res.data
          this.songs = res.data[0].song
        } else {
          return 0
        }
      })
    },
    selectItem (song, index) {
      this.selectPlay({
        list: this.songs,
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
  .rankdetail {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 101;
    background: #fff;
    .gobackheader {
      box-shadow: 0 0 0 transparent !important;
      .van-nav-bar {
        background: transparent;
        svg {
          fill: currentColor;
          color: #fff!important;
        }
        .title {
          color: #fff!important;
        }
      }
    }
  }
</style>

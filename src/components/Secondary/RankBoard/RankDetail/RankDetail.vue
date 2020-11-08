<template>
  <transition name="slide" appear>
    <div class="rankdetail">
      <go-back-header :title="rank.rbTitle"></go-back-header>
      <rank-detail-data :rank-detail="rankDetail" :rkBgImage="rkBgImage" @selectItem="selectItem"></rank-detail-data>
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
      if (this.rankDetail.length) {
        return this.rankDetail[0].coverUrl
      }
      return ''
    }
  },
  mounted () {
    this.getRankDetail()
  },
  methods: {
    getRankDetail () {
      if (!this.rank.rbid) {
        this.$router.back()
        return
      }
      this.axios.post('/api/rank/rkdetail', this.rank).then((res) => {
        if (res.data) {
          this.rankDetail = this.concatRank(res.data)
          if (this.rankDetail[0].song.length !== 0) {
            this.rankDetail = this.rankDetail[0].song
            this.songs = this.rankDetail
          } else {
            return ''
          }
        } else {
          return ''
        }
      })
    },
    // 拼接榜单标题
    concatRank (data) {
      const newRank = []
      const rank = { lbid: this.rank.rbid, lbName: this.rank.rbTitle, song: '' }
      if (data[0].lbid) {
        return data
      }
      if (data[0].lbid === undefined) {
        rank.song = data
      }
      newRank.push(rank)
      return newRank
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

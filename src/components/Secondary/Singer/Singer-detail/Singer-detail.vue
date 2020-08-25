<template>
  <transition name="slide" appear>
    <div class="singerdetail" v-if="show">
      <go-back-header></go-back-header>
      <sg-detail-data :singerDetail="singerDetail" :singerDetailAlbum="singerDetailAlbum"></sg-detail-data>
    </div>
  </transition>
</template>

<script>
import goBackHeader from '../../goBackHeader'
import sgDetailData from '../Singer-detail/sgDetailData/sgDetailData'
import { mapGetters } from 'vuex'
export default {
  components: { goBackHeader, sgDetailData },
  data () {
    return {
      show: true,
      singerDetail: [],
      singerDetailAlbum: []
    }
  },
  created () {
    this.getSingerInfo()
  },
  computed: {
    ...mapGetters([
      'singer'
    ])
  },
  methods: {
    getSingerInfo () {
      if (!this.singer.sgid) {
        this.$router.push({
          path: '/singer'
        })
        return
      }
      this.axios.post('/api/sgdetail/detail', this.singer).then((res) => {
        if (res.data) {
          this.singerDetail = res.data.detail
          this.singerDetailAlbum = res.data.album
        } else {
          return 0
        }
      }).catch((err) => {
        this.$toast(err)
      })
    }
  }
}
</script>

<style lang="less">
  .singerdetail {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 100;
    background: #fff;
    overflow: scroll;
    .van-nav-bar {
      background-color: transparent;
      svg {
        fill: currentColor;
        color: #ffffff;
      }
    }
  }

  .slide-enter,
  .slide-leave-to {
    opacity: 0;
    transform: translate3d(100%,0,0);
  }
  .slide-enter-active,
  .slide-leave-active {
    transition: all 0.2s;
  }
</style>

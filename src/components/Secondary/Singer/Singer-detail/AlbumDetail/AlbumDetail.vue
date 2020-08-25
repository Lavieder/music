<template>
  <transition name="slide" appear>
    <div class="albumdetail" v-if="show">
      <go-back-header :title="title"></go-back-header>
      <al-detail-data :albumDetail="albumDetail" @selectSong="selectSong"></al-detail-data>
    </div>
  </transition>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import goBackHeader from '../../../goBackHeader'
import alDetailData from '../AlbumDetail/alDetailData/alDetailData'
export default {
  components: { goBackHeader, alDetailData },
  data () {
    return {
      show: true,
      title: '专辑',
      albumDetail: {}
    }
  },
  computed: {
    ...mapGetters([
      'album'
    ])
  },
  mounted () {
    this.getAlbumDetail()
  },
  methods: {
    getAlbumDetail () {
      this.axios.post('/api/album/aldetail', this.album).then((res) => {
        if (res.data) {
          this.albumDetail = res.data.albumDetail[0]
        } else {
          return '该专辑没有歌曲'
        }
      })
    },
    selectSong (song, index) {
      this.selectPlay({
        list: this.albumDetail,
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
  .albumdetail {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: #fff;
    z-index: 2;
    .gobackheader {
      .van-nav-bar {
        background-color: transparent;
        svg {
          fill: currentColor;
          color: #fff;
        }
        .title {
          color: #fff;
        }
      }
    }
  }

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

<template>
  <transition name="slide">
    <div class="recently-play">
      <go-back-header :title="title"></go-back-header>
      <gd-detail-data></gd-detail-data>
      <loading></loading>
    </div>
  </transition>
</template>

<script>
import goBackHeader from '../../../Secondary/goBackHeader'
import gdDetailData from '../../../Secondary/Gedan/GedanDetail/gdDetailData/gdDetailData'
import Loading from '../../../Loading/Loading'
export default {
  components: { goBackHeader, gdDetailData, Loading },
  data () {
    return {
      title: '最近播放'
    }
  },
  mounted () {
    this.getPadding()
  },
  methods: {
    getPadding () {
    }
  }
}
</script>

<style lang="less">
  .recently-play {
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

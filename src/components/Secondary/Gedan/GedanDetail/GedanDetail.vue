<template>
  <transition name="slide" appear>
    <div class="gedandetail" v-if="show">
      <go-back-header :title="title"></go-back-header>
      <gd-detail-data :gedan-data="gedanData"></gd-detail-data>
      <loading></loading>
    </div>
  </transition>
</template>

<script>
import goBackHeader from '../../goBackHeader'
import gdDetailData from '../GedanDetail/gdDetailData/gdDetailData'
import Loading from '../../../Loading/Loading'
import { mapGetters } from 'vuex'
export default {
  components: { goBackHeader, gdDetailData, Loading },
  data () {
    return {
      show: true,
      title: '歌单',
      gedanData: []
    }
  },
  computed: {
    ...mapGetters([
      'gedan'
    ])
  },
  mounted () {
    this.getGedanData()
  },
  methods: {
    getGedanData () {
      if (!this.gedan.gdid) {
        this.$router.push({
          path: '/gedan'
        })
        return
      }
      this.axios.post('/api/gedan/gddetail', this.gedan).then((res) => {
        if (res.data) {
          this.gedanData = res.data
        } else {
          return '没有歌曲'
        }
      })
    }
  }
}
</script>

<style lang="less">
  .gedandetail {
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

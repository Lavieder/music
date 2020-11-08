<template>
  <div class="favorite">
    <go-back-header :title="title"></go-back-header>
    <gd-detail-data :gedan-data="MyLikeSongs" :facover-img="FacoverImg" :message="message" @delMyLikeSong="delMyLikeSong"></gd-detail-data>
    <loading v-if="loading"></loading>
  </div>
</template>

<script>
import { mapGetters, mapState, mapMutations } from 'vuex'
import goBackHeader from '../../../Secondary/goBackHeader'
import gdDetailData from '../../../Secondary/Gedan/GedanDetail/gdDetailData/gdDetailData'
import Loading from '../../../Loading/Loading'
export default {
  components: { gdDetailData, goBackHeader, Loading },
  data () {
    return {
      title: '我喜欢的音乐',
      MyLikeSongs: [],
      loginShow: false,
      message: {
        success: '',
        fail: ''
      }
    }
  },
  computed: {
    ...mapGetters([
      'loginInfo'
    ]),
    ...mapState([
      'loading'
    ]),
    FacoverImg () {
      if (this.MyLikeSongs.length) {
        return this.MyLikeSongs[0].song[0].coverUrl
      }
      return ''
    }
  },
  created () {
    this.getMyLikeSongs()
  },
  methods: {
    getMyLikeSongs () {
      if (!this.loginInfo) {
        return
      }
      this.axios.post('/api/user/myfs', { uid: this.loginInfo.uid }).then((res) => {
        if (res.data) {
          this.MyLikeSongs = res.data
          console.log(this.MyLikeSongs)
          this.setFavoriteList(this.MyLikeSongs[0].song)
        } else {
          return 0
        }
      })
    },
    delMyLikeSong (sids) {
      this.axios.post('/api/user/delfs', { uid: this.loginInfo.uid, sids: sids }).then((res) => {
        if (res.data) {
          this.getMyLikeSongs()
        } else {
          return ''
        }
      })
    },
    ...mapMutations({
      setFavoriteList: 'SET_FAVORITE_LIST'
    })
  }
}
</script>

<style lang="less">
  .favorite {
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

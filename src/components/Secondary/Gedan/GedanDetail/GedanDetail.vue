<template>
  <transition name="slide" appear>
    <div class="gedandetail" v-if="show">
      <go-back-header :title="title" ref="backHeader"></go-back-header>
      <gd-detail-data :gedan-data="gedanData" :curr="curr" :facover-img="FacoverImg" :isMycreate="isMycreate"
        :message="message" @collectGedan="collectGedan" @delMyLikeSong="delMyLikeSong" ref="gddetaildata"
        @delSuccess="delSuccess"></gd-detail-data>
      <div class="please-login" ref="pleaseLogin">{{ msg }}</div>
      <loading></loading>
    </div>
  </transition>
</template>

<script>
import goBackHeader from '../../goBackHeader'
import gdDetailData from '../GedanDetail/gdDetailData/gdDetailData'
import Loading from '../../../Loading/Loading'
import { mapGetters, mapMutations } from 'vuex'
export default {
  components: { goBackHeader, gdDetailData, Loading },
  data () {
    return {
      show: true,
      title: '歌单',
      curr: '',
      gedanData: [],
      msg: '',
      message: {
        success: '',
        fail: ''
      },
      isMycreate: false
    }
  },
  computed: {
    ...mapGetters([
      'gedan',
      'loginInfo',
      'createGedanList',
      'playHistory'
    ]),
    FacoverImg () {
      if (this.$route.path === '/user/like' && this.gedanData.length) {
        return this.gedanData[0].song[0].coverUrl
      }
      return ''
    }
  },
  mounted () {
    this.getGedanData()
    this.getCurr()
    this.getIsMyCreate()
  },
  methods: {
    delSuccess () {
      this.gedanData = JSON.parse(localStorage.getItem('playHistory'))
    },
    getGedanData () {
      if (this.$route.path === '/user/like') {
        if (!this.loginInfo.uid) {
          return
        }
        this.axios.post('/api/user/myfs', { uid: this.loginInfo.uid }).then((res) => {
          if (res.data) {
            this.gedanData = res.data
            this.setFavoriteList(res.data[0].song)
          } else {
            return 0
          }
        })
      } else if (this.$route.path === '/user/recently') {
        this.title = '最近播放'
        const headerHeight = this.$refs.backHeader.$el.offsetHeight
        this.$refs.backHeader.$el.style.background = 'rgb(252,65,86)'
        this.$refs.gddetaildata.$children[0].$el.children[0].style.paddingTop = headerHeight + 'px'
        this.gedanData = this.playHistory
      } else {
        if (!this.gedan.gdid) {
          this.$router.back()
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
    },
    // 收藏歌单
    collectGedan (gdid, isCollect) {
      if (!this.loginInfo.uid) {
        this.msg = '你还未登录'
      } else {
        this.axios.post('/api/user/ctgd', { gdid: gdid, uid: this.loginInfo.uid, isCollect: !isCollect }).then((res) => {
          if (res.data[0] === true) {
            this.msg = '收藏成功'
            this.setCollectList(res.data[1][0].gedan)
          } else if (res.data[0] === 'reYes') {
            this.msg = '取消收藏成功'
            this.setCollectList(res.data[1][0].gedan)
          } else {
            this.msg = '取消收藏失败'
          }
        })
      }
      this.showMsg()
    },
    showMsg () {
      this.$refs.pleaseLogin.style.opacity = 1
      this.$refs.pleaseLogin.style.zIndex = 1
      this.$refs.pleaseLogin.style.transitionDuration = '500ms'
      setTimeout(() => {
        this.$refs.pleaseLogin.style.opacity = 0
        this.$refs.pleaseLogin.style.zIndex = -1
      }, 1500)
    },
    // 删除喜欢的音乐
    delMyLikeSong (sids) {
      this.axios.post('/api/user/delfs', { uid: this.loginInfo.uid, sids: sids }).then((res) => {
        if (res.data) {
          this.getGedanData()
        } else {
          return ''
        }
      })
    },
    getCurr () {
      if (this.$route.path === '/user/like') {
        this.curr = 'like'
      } else if (this.$route.path === '/user/recently') {
        this.curr = 'recently'
      } else {
        this.curr = 'gedan'
      }
    },
    // 判断是否是我创建的音乐
    getIsMyCreate () {
      if (!this.loginInfo.uid) {
        return
      }
      const gdidList = this.createGedanList.map((item) => {
        return item.gdid
      })
      const index = gdidList.indexOf(this.gedan.gdid)
      if (index > -1) {
        this.isMycreate = true
      }
    },
    ...mapMutations({
      setFavoriteList: 'SET_FAVORITE_LIST',
      setCollectList: 'SET_COLLECT_LIST'
    })
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
    .please-login {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%,-50%);
      background-color: rgba(0,0,0,0.6);
      padding: 12px;
      box-sizing: border-box;
      border-radius: 15px;
      color: #ffffff;
      z-index: -1;
      opacity: 0;
      font-size: 0.85em;
      transition: all .5s;
    }
  }

</style>

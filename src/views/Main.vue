<template>
  <transition>
    <div class="main">
      <div class="nav" ref="nav">
        <div class="nav-left">
          <img :src="getFace" ref="myface" @click="toLogin()">
        </div>
        <div class="nav-title">
          <span :class="active == 0 ? 'act' : 'tab'" @click="tabNav('my')" ref="mytitle">我的</span>
          <span :class="active == 1 ? 'act' : 'tab'" @click="tabNav('rec')" ref="rectitle">发现</span>
        </div>
        <div class="nav-right">
          <van-icon name="search" size="23" color="#000000" @click="search"></van-icon>
        </div>
      </div>
      <div class="content" ref="content">
        <div v-if="active == 1" ref="rec">
          <keep-alive>
            <Recommend></Recommend>
          </keep-alive>
        </div>
        <div v-if="active == 0" ref="my">
          <my :userCreateGedan="userCreateGedan" :userCollectGedan="userCollectGedan" :message="message" @selectItem="selectItem" @delGedan="delGedan"  @createMyGedan="createMyGedan"></my>
        </div>
      </div>
      <router-view></router-view>
    </div>
  </transition>
</template>

<script>
import Recommend from '../components/Main/Recommend/Recommend'
import My from '../components/Main/My/My'
import { mapGetters, mapMutations } from 'vuex'
export default {
  components: { Recommend, My },
  data () {
    return {
      active: 1,
      userCreateGedan: [],
      userCollectGedan: [],
      message: {
        success: '',
        fail: ''
      }
    }
  },
  computed: {
    ...mapGetters([
      'loginInfo',
      'playing'
    ]),
    getFace () {
      return this.loginInfo.uid ? '/storage/' + this.loginInfo.faceUrl : '/storage/face/default.jpg'
    }
  },
  mounted () {
    this.tabNav()
    this.getUserGedan()
    this.getMyLikeSongs()
  },
  methods: {
    toLogin () {
      if (this.loginInfo.uid) {
        this.$router.push({
          path: '/user/detail'
        })
      } else {
        this.$router.push({
          path: '/login'
        })
      }
    },
    search () {
      this.$router.push({
        path: '/search'
      })
    },
    tabNav (str) {
      if (str === 'my') {
        this.active = 0
        this.$refs.content.style.transform = 'translate3d(0,0,0)'
        this.$refs.nav.style.background = 'rgba(255,255,255, 0)'
        this.$refs.mytitle.style.color = '#fff'
        this.$refs.rectitle.style.color = 'rgba(255,255,255, 0.5)'
        this.$refs.myface.style.opacity = '0'
        setTimeout(() => {
          this.$refs.myface.style.display = 'none'
        }, 400)
        this.$refs.myface.style.transitionDuration = '400ms'
        this.$refs.content.style.transitionDuration = '400ms'
      } else {
        this.active = 1
        this.$refs.content.style.transform = 'translate3d(0,0,0)'
        this.$refs.myface.style.display = 'block'
        this.$refs.myface.style.opacity = '0'
        this.$refs.mytitle.style.color = 'rgba(0,0,0, 0.5)'
        this.$refs.rectitle.style.color = 'rgba(0,0,0)'
        this.$refs.nav.style.background = 'rgba(255,255,255,1)'
        setTimeout(() => {
          this.$refs.myface.style.opacity = '1'
          this.$refs.myface.style.transitionDuration = '400ms'
          this.$refs.content.style.transitionDuration = '400ms'
        }, 0)
      }
    },
    getUserGedan () {
      if (this.loginInfo.uid) {
        this.axios.post('/api/user/ugd', { uid: this.loginInfo.uid }).then((res) => {
          if (res.data) {
            this.userCreateGedan = res.data.createGd[0].gedan
            this.userCollectGedan = res.data.collectGd[0].gedan
            this.setCreateList(this.userCreateGedan)
            this.setCollectList(this.userCollectGedan)
          } else {
            return 0
          }
        })
      }
    },
    // 创建歌单
    createMyGedan (inputTxt) {
      this.axios.post('/api/user/cmgd', { gdTitle: inputTxt, uid: this.loginInfo.uid }).then((res) => {
        if (res.data === 1) {
          this.message.success = '创建成功'
          this.getUserGedan()
        } else {
          this.message.fail = '创建失败'
        }
      })
    },
    // 删除歌单
    delGedan (gdlist, source) {
      this.axios.post('/api/user/delgd', { gdid: gdlist, uid: this.loginInfo.uid, source: source }).then((res) => {
        if (res.data !== '0') {
          this.message.success = '删除成功'
          this.getUserGedan()
        } else {
          this.message.fail = '删除失败'
        }
      })
    },
    // 获取喜欢的音乐
    getMyLikeSongs () {
      if (!this.loginInfo.uid) {
        return
      }
      this.axios.post('/api/user/myfs', { uid: this.loginInfo.uid }).then((res) => {
        if (res.data) {
          this.MyLikeSongs = res.data
          this.setFavoriteList(this.MyLikeSongs[0].song)
        } else {
          return 0
        }
      })
    },
    selectItem (item) {
      this.$router.push({
        path: `/mgd/${item.gdid}`
      })
      this.setGedan(item)
    },
    ...mapMutations({
      setGedan: 'SET_GEDAN',
      setFavoriteList: 'SET_FAVORITE_LIST',
      setCollectList: 'SET_COLLECT_LIST',
      setCreateList: 'SET_CREATE_LIST'
    })
  }
}
</script>

<style lang="less">
  .main {
    .nav {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 3vw;
      box-sizing: border-box;
      height: 50px;
      width: 100vw;
      position: fixed;
      z-index: 1;
      background: rgba(255,255,255,0);
      .nav-left {
        line-height: 13px;
        z-index: 1;
        width: 2.5rem;
        height: 2.5rem;
        img {
          width: 100%;
          height: 100%;
          border-radius: 50%;
        }
      }
      .nav-title {
        width: 30vw;
        display: flex;
        justify-content: space-around;
        font-size: 0.96em;
        .tab {
          color: rgba(0, 0, 0, 0.5);
          transition: all 0.2s linear;
        }
        .act {
          color: rgba(0,0,0,1);
          transition: all 0.15s linear;
        }
      }
      .nav-right {
        width: 48px;
        height: 41px;
        text-align: right;
        line-height: 53px;
        z-index: 1;
      }
    }
    .content {
      transform: translate3d(0, 0, 0);
      display: flex;
      flex-direction: row-reverse;
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
  }
</style>

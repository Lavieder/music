<template>
  <div class="main">
    <div class="nav" ref="nav">
      <div class="nav-left">
        <img :src="getFace" ref="myface" @click="loginInfo.length ? '' : toLogin()">
      </div>
      <div class="nav-title">
        <span :class="active == 0 ? 'act' : 'tab'" @click="tabNav('my')" ref="mytitle">我的</span>
        <span :class="active == 1 ? 'act' : 'tab'" @click="tabNav('rec')" ref="rectitle">发现</span>
      </div>
      <div class="nav-right">
        <van-icon name="search" size="23" color="#000000" @click="search"></van-icon>
      </div>
    </div>
    <div class="content">
      <div v-show="active == 1" ref="rec">
        <keep-alive>
          <Recommend></Recommend>
        </keep-alive>
      </div>
      <div v-show="active == 0" ref="my">
        <my :userGedan="userGedan" @selectItem="selectItem" @createMyGedan="createMyGedan"></my>
      </div>
    </div>
    <router-view></router-view>
  </div>
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
      userGedan: []
    }
  },
  computed: {
    ...mapGetters([
      'loginInfo'
    ]),
    getFace () {
      return this.loginInfo.length ? '/storage/' + this.loginInfo[0].faceUrl : '/storage/face/default.jpg'
    }
  },
  mounted () {
    this.tabNav()
    this.getUserGedan()
  },
  methods: {
    toLogin () {
      this.$router.push({
        path: '/login'
      })
    },
    search () {
      this.$router.push({
        path: '/search'
      })
    },
    tabNav (str) {
      if (str === 'my') {
        this.active = 0
        this.$refs.nav.style.background = 'transparent'
        this.$refs.mytitle.style.color = '#fff'
        this.$refs.rectitle.style.color = 'rgba(255,255,255, 0.5)'
        this.$refs.myface.style.opacity = '0'
        setTimeout(() => {
          this.$refs.myface.style.display = 'none'
        }, 400)
        this.$refs.myface.style.transitionDuration = '400ms'
      } else {
        this.active = 1
        this.$refs.myface.style.display = 'block'
        this.$refs.myface.style.opacity = '0'
        this.$refs.mytitle.style.color = 'rgba(0,0,0, 0.5)'
        this.$refs.rectitle.style.color = 'rgba(0,0,0)'
        this.$refs.nav.style.background = 'rgb(255,255,255)'
        setTimeout(() => {
          this.$refs.myface.style.opacity = '1'
          this.$refs.myface.style.transitionDuration = '400ms'
        }, 0)
      }
    },
    getUserGedan () {
      if (this.loginInfo.length) {
        this.axios.post('/api/user/ugd', this.loginInfo[0]).then((res) => {
          if (res.data) {
            this.userGedan = res.data[0].gedan
          } else {
            return 0
          }
        })
      }
    },
    createMyGedan (inputTxt) {
      console.log(inputTxt)
      this.axios.post('/api/user/cmgd', { gdTitle: inputTxt }).then((res) => {
        console.log(res)
      })
    },
    selectItem (item) {
      this.$router.push({
        path: `/my/${item.gdid}`
      })
      this.setGedan(item)
    },
    ...mapMutations({
      setGedan: 'SET_GEDAN'
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
      background: rgb(255,255,255);
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
  }
</style>

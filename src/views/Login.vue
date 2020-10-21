<template>
  <div class="login">
    <go-back-header></go-back-header>
    <div class="main">
      <van-image :src="loginBg" lazy-load></van-image>
      <van-form>
        <van-field
          v-model="formData.uName"  placeholder="编号 / 用户名"
          label-class="label-justify" :rules="[{ required: true }]"
        >
          <template #left-icon>
            <i class="iconfont">&#xe60e;</i>
          </template>
        </van-field>
        <van-field
          v-model="formData.pwd" :type="pwdType" label-class="label-justify" placeholder="密码"
          :rules="[{ required: true }]" :right-icon="rIcon" @click-right-icon="showPwd"
        >
          <template #left-icon>
            <i class="iconfont">&#xe605;</i>
          </template>
        </van-field>
        <van-button type="info" block round @click="checkLogin">
          <pre>登   录</pre>
        </van-button>
      </van-form>
    </div>
  </div>
</template>

<script>
import Vue from 'vue'
import { Toast } from 'vant'
import { mapMutations, mapActions } from 'vuex'
import goBackHeader from '../components/Secondary/goBackHeader'
Vue.use(Toast)
export default {
  components: { goBackHeader },
  data () {
    return {
      loginBg: require('../assets/images/loginBg.jpg'),
      formData: {
        uName: '',
        pwd: ''
      },
      pwdType: 'password',
      rIcon: 'closed-eye',
      userInfo: []
    }
  },
  methods: {
    showPwd () {
      if (this.pwdType === 'password') {
        this.pwdType = 'text'
        this.rIcon = 'eye-o'
      } else {
        this.pwdType = 'password'
        this.rIcon = 'closed-eye'
      }
    },

    checkLogin () {
      this.axios.post('/api/login', this.formData).then((res) => {
        if (res.data.isOk === '1') {
          this.userInfo = res.data.user
          // localStorage.uName = res.data.user[0].uName
          // localStorage.token = res.data.tk
          this.setLoginInfo(res.data.user)
          this.Login(res.data)
          // this.setUName(res.data.user[0].uName)
          // this.setToken(res.data.tk)
          this.$router.push('/')
        } else {
          console.log(res)
          Toast.fail('密码或账号错误')
        }
      }).catch((err) => {
        console.log(err)
        Toast.fail('登录异常！')
      })
    },
    ...mapMutations({
      setLoginInfo: 'SET_LOGININFO'
      // setUName: 'SET_UNAME',
      // setToken: 'SET_TOKEN'
    }),
    ...mapActions([
      'Login'
    ])
  }
}
</script>

<style lang="less">
  .login {
    width: 100vw;
    height: 100vh;
    background-color: #f6f6f6;
    position: relative;
    z-index: 185;
    .gobackheader {
      .van-nav-bar {
        background-color: transparent;
      }
    }
    .main {
      padding-top: 4rem;
      .van-image {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 0;
        .van-image__img {
          width: 40%;
          height:40%;
        }
      }
      .van-form {
        margin-top: 2rem;
        width: 100vw;
        .van-cell {
          padding: 10px 25px;
          font-size: 1rem;
          background-color: transparent;
        }
        .label-justify{
          text-align-last: justify;
          width: 70px !important;
        }
        .van-field__left-icon {
          margin-right: 0.8rem;
          color: #58595b;
        }
        .van-cell__value {
          border-bottom: 1px solid #000000;
          input::placeholder {
            font-size: 1rem;
          }
          .van-field__control {
            font-size: 1.2rem;
          }
        }
        .van-button--block {
          width: 90vw;
          margin: 1rem auto;
          background-color: #48c3d3;
          border: 0;
        }
      }
    }
  }
</style>

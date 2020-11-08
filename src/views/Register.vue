<template>
  <div class="register">
    <go-back-header></go-back-header>
    <div class="main">
      <van-image :src="loginBg" lazy-load></van-image>
      <van-form>
        <van-field v-model="formData.uName" placeholder="编号 / 用户名"
          label-class="label-justify" :rules="[{ required: true }]"
        >
          <template #left-icon>
            <i class="iconfont">&#xe60e;</i>
          </template>
        </van-field>
        <van-field v-model="formData.pwd" :type="pwdType" label-class="label-justify" placeholder="密码"
          :rules="[{ required: true }]" :right-icon="rIcon" @click-right-icon="showPwd"
        >
          <template #left-icon>
            <i class="iconfont">&#xe605;</i>
          </template>
        </van-field>
        <van-field v-model="formData.okPwd" :type="pwdOkType" label-class="label-justify" placeholder="确认密码"
          :rules="[{ required: true }]" :right-icon="rOkIcon" @click-right-icon="showOkPwd"
        >
          <template #left-icon>
            <i class="iconfont">&#xe605;</i>
          </template>
        </van-field>
        <van-button type="info" block round @click="handleRegister">
          <pre>注   册</pre>
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
      loginBg: require('../assets/images/loginBg.png'),
      formData: {
        uName: '',
        pwd: '',
        okPwd: ''
      },
      pwdType: 'password',
      pwdOkType: 'password',
      rIcon: 'closed-eye',
      rOkIcon: 'closed-eye',
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
    showOkPwd () {
      if (this.pwdOkType === 'password') {
        this.pwdOkType = 'text'
        this.rOkIcon = 'eye-o'
      } else {
        this.pwdOkType = 'password'
        this.rOkIcon = 'closed-eye'
      }
    },

    handleRegister () {
      if (this.formData.pwd !== this.formData.okPwd) {
        Toast.fail('2次密码不一样')
        return false
      }
      this.axios.post('/api/reg', this.formData).then((res) => {
        if (res.data === 1) {
          Toast.fail('注册成功，请登录')
          this.$router.push('/login')
        } else if (res.data === 2) {
          Toast.fail('已有此用户, 请登录')
        } else {
          Toast.fail('注册失败，请重新注册')
        }
      }).catch((err) => {
        console.log(err)
        Toast.fail('注册异常！')
      })
    },
    ...mapMutations({
      setLoginInfo: 'SET_LOGININFO'
    }),
    ...mapActions([
      'Login'
    ])
  }
}
</script>
<style lang="less">
  .register {
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
      padding-top: 3rem;
      .van-image {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 0;
        .van-image__img {
          height: 130px;
          width: 130px;
        }
      }
      .van-form {
        margin-top: 2rem;
        width: 100vw;
        .van-cell {
          padding: 5px 25px;
          font-size: 1rem;
          line-height: 40px;
          background-color: transparent;
        }
        .label-justify{
          text-align-last: justify;
          width: 70px !important;
        }
        .van-field__left-icon {
          margin: 0;
          border-bottom: 1px solid #000000;
          color: #58595b;
        }
        .van-cell__value {
          padding-left: 15px;
          border-bottom: 1px solid #000000;
          input::placeholder {
            font-size: 0.95rem;
          }
          .van-field__control {
            font-size: 1.2rem;
          }
        }
        .van-button--block {
          width: 90vw;
          margin: 1rem auto 0;
          background-color: #48c3d3;
          border: 0;
        }
      }
    }
  }
</style>

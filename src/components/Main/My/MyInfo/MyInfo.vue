<template>
  <transition name="slide_left" appear>
    <div class="myinfo">
      <go-back-header :title="title"></go-back-header>
      <van-form v-if="loginInfo.length">
        <van-field :value="loginInfo[0].uName" label="用户名" input-align="right" clickable readonly/>
        <van-field name="uploader" class="upload" label="头像" input-align="right" clickable>
          <template #input>
            <van-uploader>
              <img :src="'/storage/'+loginInfo[0].faceUrl">
            </van-uploader>
          </template>
        </van-field>
        <van-field class="nickName" v-model="getNickName" label="昵称" input-align="right" clickable/>
        <van-field class="sex" v-model="getSex" label="性别" input-align="right" clickable/>
        <van-field name="datetimePicker" v-model="getBirth" label="生日" input-align="right" clickable @click="showPick = true"/>
        <van-field name="area" v-model="getArea" label="地区" input-align="right" clickable @click="showArea = true"/>
        <van-field ref="textarea" v-model="getIntro" class="textarea" type="textarea" placeholder="还没有签名" autosize rows="1" label="个性签名" :input-align="textdire" clickable/>
        <div class="button">
          <van-button type="info" round @click="exitUser()">退出</van-button>
          <van-button type="primary" round @click="updateUserInfo()">保存</van-button>
        </div>
      </van-form>
      <van-popup v-model="showPick" position="bottom">
        <van-datetime-picker type="date" :min-date="minDate" @cancel="showPick = false" :formatter="formatter"/>
      </van-popup>
      <van-popup v-model="showArea" position="bottom">
        <van-area :area-list="areaList" value="110101" @cancel="showArea = false" />
      </van-popup>
    </div>
  </transition>
</template>

<script>
import goBackHeader from '../../../Secondary/goBackHeader'
import { mapGetters, mapMutations } from 'vuex'
import { areaList } from '../../../../JS/Area'
export default {
  components: { goBackHeader },
  data () {
    return {
      title: '我的绝密档案',
      text: '',
      showPick: false,
      showArea: false,
      minDate: new Date(1970, 1, 1),
      areaList,
      textdire: 'right',
      upDI: {
        face: '',
        nickName: '',
        sex: '',
        birth: '',
        area: '',
        intro: ''
      }
    }
  },
  mounted () {
    this.txtdire()
  },
  computed: {
    ...mapGetters([
      'loginInfo'
    ]),
    getNickName: {
      get: function () {
        return this.loginInfo[0].nickName
      },
      set: function (val) {
        this.upDI.nickName = val
      }
    },
    getSex: {
      get: function () {
        return this.loginInfo[0].sex
      },
      set: function (val) {
        this.upDI.sex = val
      }
    },
    getBirth: {
      get: function () {
        return this.loginInfo[0].birth
      },
      set: function (val) {
        this.upDI.birth = val
      }
    },
    getArea: {
      get: function () {
        return this.loginInfo[0].area
      },
      set: function (val) {
        this.upDI.area = val
      }
    },
    getIntro: {
      get: function () {
        return this.loginInfo[0].intro
      },
      set: function (val) {
        this.upDI.intro = val
      }
    }
  },
  methods: {
    ...mapMutations({
      setLoginInfo: 'SET_LOGININFO'
    }),
    formatter (type, val) {
      if (type === 'year') {
        return `${val}年`
      } else if (type === 'month') {
        return `${val}月`
      } else if (type === 'day') {
        return `${val}日`
      }
      return val
    },
    txtdire () {
      if (!this.loginInfo[0]) {
        this.$router.back()
        return
      }
      const signLeg = this.$refs.textarea.value.length
      if (signLeg > 30) {
        this.textdire = 'left'
      } else {
        this.textdire = 'right'
      }
    },
    exitUser () {
      if (this.loginInfo.length) {
        this.$store.commit('SET_UNAME', '')
        this.$store.commit('SET_TOKEN', '')
        this.setLoginInfo('')
      }
      this.$router.back()
    },
    updateUserInfo () {
      this.axios.post('/api/user/upui', { upUI: this.upUI, uName: this.loginInfo[0].uName }).then((res) => {
        console.log(res)
      })
    }
  }

}
</script>

<style lang="less">
  .myinfo {
    width: 100%;
    height: 100vh;
    position: absolute;
    top: 0;
    right: 0;
    left: 0;
    bottom: 0;
    background: #f1f1f1;
    .van-form {
      padding: 55px 0;
      box-sizing: border-box;
      .van-field {
        padding: 0 1rem;
        box-sizing: border-box;
        height: 56px;
        font: 400 0.95em/56px '微软雅黑';
        .van-field__label,
        .van-field__value {
          border-bottom: 1px solid #d5d5d5;
          .van-field__body {
            height: 100%;
            .van-uploader {
              .van-uploader__input-wrapper {
                display: flex;
                img {
                  width: 2.5rem;
                  height: 2.5rem;
                  border-radius: 50%;
                }
              }
            }
          }
        }
      }
      .upload {
        .van-field__value,
        .van-uploader,
        .van-uploader__input-wrapper {
          position: initial;
        }
      }
      .nickName {
        .van-field__label,
        .van-field__value {
          border: 0;
        }
      }
      .sex {
        margin-top: 9px;
      }
      .textarea {
        height: auto;
        .van-field__label {
          display: flex;
          align-items: center;
          border: 0;
        }
        .van-field__value {
          border: 0;
          .van-field__body {
            textarea {
              display: block;
              line-height: initial;
              font: 400 0.84em/1.5 '微软雅黑';
              color: #6b6b6b;
              margin: 0.5rem 0;
            }
          }
        }
      }
      .button {
        padding: 1rem;
        box-sizing: border-box;
        display: flex;
        justify-content: space-between;
        .van-button {
          width: 48%;
        }
      }
    }
  }
  .slide_left-enter,
  .slide_left-leave-to {
    opacity: 0;
    transform: translate3d(100%,0,0);
  }
  .slide_left-enter-active,
  .slide_left-leave-active {
    transition: all 0.2s;
  }
</style>

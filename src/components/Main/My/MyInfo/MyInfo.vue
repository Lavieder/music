<template>
  <transition name="slide_left" appear>
    <div class="myinfo">
      <go-back-header :title="title" ref="backHeader"></go-back-header>
      <form v-if="loginInfo" @submit="checkForm">
        <van-field :value="loginInfo.uName" label="用户名" input-align="right" clickable readonly/>
        <div class="uploader" ref="uploader" @touchstart="handleUp()" @touchend="handleEnd()">
          <div class="upbox">
            <div class="uplaoel">头像</div>
            <div class="upinput">
              <input class="file-input" accept="image/*" type="file" @change="changeFace">
              <div  class="bgface" :style="{'background-image': 'url(/storage/'+getFace+')'}"  @click.stop="handleFullFace()">

              </div>
            </div>
          </div>
        </div>
          <van-overlay :show="faceFull" @click="closeFullFace()" duration="0.2">
            <div class="face-wrapper">
              <div class="face-block" >
                <img :src="/storage/ + getFace" alt="头像" @click.stop="closeFullFace()">
              </div>
            </div>
          </van-overlay>

        <van-field class="nickName" v-model="getNickName" label="昵称" input-align="right"  @click="nickNameDialog = true" clickable/>
          <van-dialog v-model="nickNameDialog" title="修改昵称" show-cancel-button confirm-button-color="#f41919"
              :show-confirm-button="showButton" @confirm="changeNickname(inputTxt)" @cancel="nickNameDialog = false"
          >
            <input type="text" class="inputTxt" v-model="inputTxt" maxlength="xianzhiNum">
            <span :class="inputTxt ? 'xianzhi' : 'xianzhi xianzhi2'" ref="xianzhi">{{ xianzhiNum }}</span>
            <span class="shanc" v-show="inputTxt" @click="clearTxt">
              <i class="iconfont icon-shanchu"></i>
            </span>
          </van-dialog>

        <van-field class="sex" v-model="getSex" label="性别" input-align="right" @click="sexPick = true" clickable/>
        <van-popup v-model="sexPick" position="bottom">
          <van-picker show-toolbar :columns="columns" @confirm="onSexConfirm" @cancel="sexPick = false"  title="性别"/>
        </van-popup>

        <van-field name="datetimePicker" v-model="getBirth" label="生日" input-align="right" clickable @click="birthPick = true"/>
          <van-popup v-model="birthPick" position="bottom">
            <van-datetime-picker type="date" :min-date="minDate" title="您的生日"
              @cancel="birthPick = false" @confirm="onBirthConfirm" :formatter="formatter" />
          </van-popup>

        <van-field name="area" v-model="getArea" label="地区" input-align="right" clickable @click="areaPick = true"/>
          <van-popup v-model="areaPick" position="bottom">
            <van-area :area-list="areaList" value="110101" @cancel="areaPick = false" @confirm="onAreaConfirm"  title="您的地区"/>
          </van-popup>

        <van-field ref="textarea" v-model="getIntro" class="textarea" type="textarea" placeholder="还没有签名" autosize rows="1" label="个性签名" :input-align="textdire" clickable/>
        <div class="button">
          <van-button type="info" round @click="exitUser()">退出</van-button>
          <van-button type="primary" round @click="updateUserInfo()">保存</van-button>
        </div>
      </form>
    </div>
  </transition>
</template>

<script>
import goBackHeader from '../../../Secondary/goBackHeader'
import { mapGetters, mapMutations } from 'vuex'
import { areaList } from '../../../../JS/Area'
export default {
  inject: ['reload'],
  components: { goBackHeader },
  data () {
    return {
      title: '我的绝密档案',
      text: '',
      nickNameDialog: false,
      inputTxt: '',
      xianzhiNum: 20,
      showButton: true,
      faceFull: false,
      sexPick: false,
      columns: ['男', '女'],
      birthPick: false,
      areaPick: false,
      minDate: new Date(1970, 1, 1),
      areaList,
      textdire: 'right',
      newInfo: {
        nickName: '',
        sex: '',
        birth: '',
        area: '',
        intro: ''
      },
      faceInfo: {},
      photo: null
    }
  },
  mounted () {
    this.txtdire()
  },
  computed: {
    ...mapGetters([
      'loginInfo'
    ]),
    getFace: {
      get () {
        return this.loginInfo.faceUrl
      },
      set (val) {
        this.newInfo.faceUrl = val
      }
    },
    getNickName: {
      get: function () {
        return this.loginInfo.nickName
      },
      set: function (val) {
        this.newInfo.nickName = val
      }
    },
    getSex: {
      get: function () {
        return this.loginInfo.sex
      },
      set: function (val) {
        this.newInfo.sex = val
      }
    },
    getBirth: {
      get: function () {
        return this.loginInfo.birth
      },
      set: function (val) {
        this.newInfo.birth = val
      }
    },
    getArea: {
      get: function () {
        return this.loginInfo.area
      },
      set: function (val) {
        this.newInfo.area = val
      }
    },
    getIntro: {
      get: function () {
        return this.loginInfo.intro
      },
      set: function (val) {
        this.newInfo.intro = val
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
    // 格式化日期
    formatDate (val) {
      const d = new Date(val)
      const year = d.getFullYear()
      const month = d.getMonth() < 9 ? '0' + (d.getMonth(0 + 1)) : '' + (d.getMonth() + 1)
      const day = d.getDate() < 10 ? '0' + (d.getDate()) : '' + d.getDate()
      return (year + '-' + month + '-' + day)
    },
    txtdire () {
      if (!this.loginInfo) {
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
    handleUp () {
      this.$refs.uploader.style.backgroundColor = '#f2f3f5'
    },
    handleEnd () {
      this.$refs.uploader.style.backgroundColor = '#ffffff'
    },
    // 修改头像
    changeFace (event) {
      var file = event.target.files[0]
      var data = new FormData()
      data.append('file', file)
      data.append('uName', this.loginInfo.uName)
      this.axios({
        url: '/api/user/upface',
        method: 'post',
        data,
        flag: 'face',
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      }).then((res) => {
        if (res.data) {
          this.clearLocal(res.data)
        }
      }).catch((err) => {
        console.log(err)
      })
    },
    // 头像全屏展示
    handleFullFace () {
      this.faceFull = true
      this.$refs.backHeader.$el.children[0].style.backgroundColor = 'transparent'
    },
    // 关闭全屏显示
    closeFullFace () {
      this.faceFull = false
      this.$refs.backHeader.$el.children[0].style.backgroundColor = '#ffffff'
      this.$refs.backHeader.$el.children[0].style.transition = '100ms'
    },
    // 修改昵称
    changeNickname (inputTxt) {
      this.getNickName = inputTxt
      if (this.nickNameDialog) {
        this.updateUserInfo()
      } else {
        return false
      }
    },
    clearTxt () {
      this.inputTxt = ''
    },
    // 阻止form默认提交事件
    checkForm (event) {
      event.preventDefault()
    },
    // 修改性别
    onSexConfirm (value) {
      this.getSex = value
      this.sexPick = false
      this.updateUserInfo()
    },
    // 修改生日
    onBirthConfirm (value) {
      this.getBirth = this.formatDate(value)
      this.birthPick = false
      this.updateUserInfo()
    },
    // 修改地区
    onAreaConfirm (value) {
      let val = ''
      for (const item of value) {
        val = val + ' ' + item.name
      }
      const city = val.replace(/(^\s*)|(\s*$)/g, '')
      this.getArea = city
      this.areaPick = false
      this.updateUserInfo()
    },
    // 修改介绍
    exitUser () {
      if (this.loginInfo) {
        localStorage.removeItem('user')
        localStorage.removeItem('token')
        this.setLoginInfo('')
      }
      this.$router.back()
    },
    updateUserInfo () {
      this.newInfo.uName = this.loginInfo.uName
      this.axios.post('/api/user/upui', this.newInfo).then((res) => {
        if (res.data) {
          this.clearLocal(res.data)
        } else {
          return 0
        }
      })
    },
    clearLocal (data) {
      localStorage.removeItem('user')
      localStorage.removeItem('token')
      this.setLoginInfo(data.user)
      localStorage.setItem('user', JSON.stringify(data.user))
      localStorage.token = data.tk
      this.reload()
    }
  },
  watch: {
    inputTxt () {
      if (!this.inputTxt) {
        this.xianzhiNum = 20
      }
      this.xianzhiNum = 20 - this.inputTxt.length
      if (this.inputTxt.length > 20) {
        this.showButton = false
        this.inputTxt = this.inputTxt.substring(0, 20)
      } else {
        this.showButton = true
      }
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
    form {
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
          }
        }
      }
      .uploader {
        padding: 0 15px;
        background: #ffffff;
        position: relative;
        box-sizing: border-box;
        .upbox {
          width: 100%;
          height: 100%;
          padding: 3px 0;
          display: flex;
          justify-content: space-between;
          align-items: center;
          border-bottom: 1px solid #d5d5d5;
        }
        .file-input {
          position: absolute;
          top: 0;
          left: 0;
          width: 83%;
          height: 100%;
          opacity: 0;
        }
        .bgface {
          width: 50px;
          height: 50px;
          border-radius: 50%;
          background-position: center;
          background-repeat: no-repeat;
          background-size: cover;
        }
      }
      .upload {
        .van-field__value,
        .van-uploader,
        .van-uploader__input-wrapper {
          position: initial;
        }
      }
      .face-wrapper {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100%;
      }

      .face-block {
        width: 100%;
        img {
          width: 100%;
        }
      }
      .nickName {
        .van-field__label,
        .van-field__value {
          border: 0;
        }
      }
      .van-dialog {
        top: 50%;
        .van-dialog__header {
          font-size: 0.95em;
        }
        .van-dialog__content {
          position: relative;
          width: 90%;
          margin: 0 auto;
          border-bottom: 1px solid #525252;
          .inputTxt {
            height: 2rem;
            display: block;
            width: 83%;
            outline: 0;
            border: 0;
          }
          .xianzhi {
            position: absolute;
            bottom: 0.6rem;
            right: 1.8rem;
            font-size: 0.92em;
            color: #474747;
          }
          .xianzhi2 {
            right: 1.3rem;
          }
          .shanc {
            position: absolute;
            bottom: 0.2rem;
            right: 0;
            .iconfont {
              font-size: 1.7em;
            }
          }
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

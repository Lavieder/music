<template>
  <div class="my" ref="my">
    <div class="nick_info" :style="{ backgroundImage: 'url('+getFaceCover+')' }">
      <div class="face_nick">
        <img :src="getFace" alt="my" @click="toLogin()">
        <div class="toMyInfo" @click="toLogin()">
          <span class="nick">{{ loginInfo.length ? loginInfo[0].nickName : '未登录' }}</span>
          <i class="iconfont icon-xiangyou"></i>
        </div>
        <div class="guanz_fens" v-if="loginInfo.length">
          <span class="name">关注 <span class="num"> 3 </span></span> |
          <span class="name">粉丝 <span class="num"> 5 </span></span>
        </div>
      </div>
    </div>
    <div class="my_music">
      <div class="my_ms">
        <div class="title">我的音乐</div>
        <div class="ms_cont">
          <div class="m_box"><span>我喜欢的音乐</span></div>
          <div class="m_box"><span>最近播放</span></div>
          <div class="m_box"><span>我的评论</span></div>
        </div>
      </div>
    </div>
    <div class="my_gedan" ref="mygedan">
      <div class="my_gd">
        <div class="title">
          <div class="gdt">
            <span class="gdtl">
              <span v-for="(t, i) of title" :key="i" :class="getClass(i)" @click="gedanSwitch(i)">{{ t }}
                <span class="num" v-if="i === 0">{{ userGedan.length }}</span>
                <span class="num" v-if="i === 1">1</span>
              </span>
            </span>
            <span class="gdtr" @click="piLiang" v-if="userGedan.length">
              <span class="quanxuan" v-if="piliang" @click.stop="allChecked()">
                <span>{{ this.allSelect ? '取消' : '全选' }}</span>
              </span>
              <span v-if="piliang"><i class="iconfont icon-shanc shanc" @click.stop="delGedan()"></i></span>
              <span :class="piliang ? '' : 'plzk'"><i class="iconfont icon-piliang"></i></span>
            </span>
          </div>
        </div>
        <div class="gdlist">
          <div class="wdgd" v-show="wdgd === act">
            <div>
              <div class="gditem van-cell--clickable" v-for="(item, i) of userGedan" :key="i" @click="select(item)">
                  <img :src="'/storage/'+item.gdCover">
                  <div class="text_num">
                    <div>{{ item.gdTitle }}</div>
                    <div class="num">{{ item.song.length }}首</div>
                </div>
                <div class="piliang" v-if="piliang">
                  <input type="checkbox" :value="item.gdid" @click.stop="onlyChecked(item.gdid, $event)" ref="checkbox">
                </div>
              </div>
            </div>
            <div class="gditem van-cell--clickable" v-if="loginInfo.length" ref="gditem" @click="show = true">
              <div class="gdCover">
              </div>
              <div class="text_num">
                <div>创建歌单</div>
              </div>
            </div>
            <div class="gditem wei" v-if="!loginInfo.length">
              <span>快来登录啊！</span>
            </div>
            <van-dialog v-model="show" title="新建歌单" show-cancel-button confirm-button-color="#f41919"
                :show-confirm-button="showButton"
                @confirm="createMyGedan(inputTxt)"
            >
              <input type="text" class="inputTxt" v-model="inputTxt" maxlength="xianzhiNum">
              <span :class="inputTxt ? 'xianzhi' : 'xianzhi xianzhi2'" ref="xianzhi">{{ xianzhiNum }}</span>
              <span class="shanc" v-show="inputTxt" @click="clearTxt">
                <i class="iconfont icon-shanchu"></i>
              </span>
            </van-dialog>
          </div>
          <div class="scgd" v-show="scgd === act">
            <div class="gditem van-cell--clickable" ref="gditem" v-if="loginInfo.length">
              <img src='/storage/gedanCover/6.jpg' alt="">
              <div class="text_num">
                <div>这是一个真的歌单123</div>
                <div class="num">5首</div>
              </div>
              <div class="piliang" v-if="piliang">
                <input type="checkbox" v-model="allSelect">
              </div>
            </div>
            <div class="gditem wei" v-if="!loginInfo.length">
              <span>快来登录啊！</span>
            </div>
          </div>
          <div :class="delNotice" class="del-notice" ref="delNotice">
            <span v-if="message">{{ message.success !== ' ' ? message.success : message.fail }}</span>
            <span v-if="message.success == '' && message.fail == ''">{{ checkedList.length == 0 ? '未选择歌单' : '' }}</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { playListMixin } from '../../../JS/mixin'
export default {
  mixins: [playListMixin],
  props: {
    userGedan: {
      type: Array,
      default: () => []
    },
    message: {
      type: Object,
      default: () => {}
    }
  },
  data () {
    return {
      act: 0,
      wdgd: 0,
      scgd: 1,
      showButton: true,
      show: false,
      inputTxt: '',
      xianzhiNum: 20,
      title: ['我的歌单', '收藏歌单'],
      piliang: false,
      offsetTop: 0,
      allSelect: false,
      checkedList: [],
      delShow: false
    }
  },
  mounted () {
    // console.log(this.$parent.active)
    if (this.$parent.active === 0) {
      window.addEventListener('scroll', () => {
        this.watchScroll()
      }, true)
    } else {
      return ''
    }
  },
  computed: {
    ...mapGetters([
      'loginInfo',
      'currentUser'
    ]),
    getFace () {
      return this.loginInfo.length ? '/storage/' + this.loginInfo[0].faceUrl : '/storage/face/default.jpg'
    },
    getFaceCover () {
      return this.loginInfo.length ? '/storage/' + this.loginInfo[0].faceUrl : ''
    },
    piliangDel () {
      return this.piliang ? 'iconfont icon-shanc shanc' : 'iconfont icon-piliang'
    },
    delNotice () {
      return this.message.success !== '' ? this.showMessage() : ''
    }
  },
  methods: {
    // 页面滚动监听导航
    watchScroll () {
      this.offsetTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop
      const parentNav = this.$parent.$refs
      const percent = this.offsetTop / 108
      if (parentNav.nav) {
        parentNav.nav.style.background = `rgba(255,255,255, ${percent})`
      } else {
        return
      }
      if (this.$parent.active === 0 && parentNav.mytitle && parentNav.rectitle) {
        if (this.offsetTop > 60) {
          parentNav.mytitle.style.color = 'rgba(0,0,0)'
          parentNav.rectitle.style.color = 'rgba(0,0,0, 0.5)'
        } else {
          parentNav.mytitle.style.color = '#fff'
          parentNav.rectitle.style.color = 'rgba(255,255,255, 0.5)'
        }
      } else if (this.$parent.active === 1 && parentNav.mytitle && parentNav.rectitle) {
        parentNav.nav.style.background = 'rgba(255,255,255, 1)'
      }
      if (this.offsetTop > 108 && parentNav.nav) {
        parentNav.nav.style.background = 'rgba(255,255,255, 1)'
      }
    },
    toLogin () {
      if (this.loginInfo.length) {
        this.$router.push({
          path: '/user/detail'
        })
      } else {
        this.$router.push({
          path: '/login'
        })
      }
    },
    // 批量删除
    piLiang () {
      this.piliang = !this.piliang
    },
    // 单击复选框
    onlyChecked (gdid, e) {
      // this.allSelect = !this.allSelect
      if (e.target.checked) {
        this.checkedList.push(gdid)
      } else {
        const gdidIndex = this.checkedList.indexOf(gdid)
        this.checkedList.splice(gdidIndex, 1)
      }
      if (this.checkedList.length === this.userGedan.length) {
        this.allSelect = true
      } else {
        this.allSelect = false
      }
      console.log(this.checkedList)
      console.log(this.checkedList.length)
      console.log(this.userGedan.length)
    },
    // 全选
    allChecked () {
      this.allSelect = !this.allSelect
      const _this = this
      this.$refs.checkbox.forEach(function (ele) {
        ele.checked = !ele.checked
        if (ele.checked) {
          _this.checkedList.push(parseInt(ele.value))
        } else {
          const gdidIndex = _this.checkedList.indexOf(parseInt(ele.value))
          _this.checkedList.splice(gdidIndex, 1)
        }
      })
      console.log(this.checkedList)
    },
    // 点击删除按钮，向后端发送对应的歌单gdid
    delGedan () {
      if (this.checkedList.length === 0) {
        this.showMessage()
      } else {
        this.$emit('delGedan', this.checkedList)
      }
    },
    // 显示成功/失败提示文字
    showMessage () {
      this.$refs.delNotice.style.opacity = 1
      this.$refs.delNotice.style.zIndex = 1
      this.$refs.delNotice.style.transitionDuration = '500ms'
      setTimeout(() => {
        this.$refs.delNotice.style.opacity = 0
        this.$refs.delNotice.style.zIndex = -1
      }, 1500)
    },
    getClass (i) {
      return this.act === i ? 'act' : 'def'
    },
    gedanSwitch (i) {
      this.act = i
    },
    clearTxt () {
      this.inputTxt = ''
    },
    select (item) {
      this.$emit('selectItem', item)
    },
    // 创建歌单
    createMyGedan (inputTxt) {
      this.$emit('createMyGedan', inputTxt)
    },
    handlePlayList (playList) {
      const paddingBottom = playList.length > 0 ? '55px' : ''
      this.$refs.mygedan.style.paddingBottom = paddingBottom
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
  .my {
    width: 100vw;
    font-size: 0.9em;
    position: relative;
    .nick_info::before {
      content: '';
      height: 100%;
      width: 100%;
      position: absolute;
      top: 0;
      right: 0;
      left: 0;
      bottom: 0;
      background: rgba(0,0,0,0.42);
    }
    .nick_info {
      width: 100%;
      padding: 3.3rem 1rem 1rem;
      box-sizing: border-box;
      position: relative;
      color: #fff;
      background-repeat: no-repeat;
      background-position: center;
      background-size: 100% auto;
      .face_nick {
        width: 100%;
        height: 5.5rem;
        position: relative;
        font-size: 0.9rem;
        img {
          width: 3.8rem;
          height: 3.8rem;
          border-radius: 50%;
          position: absolute;
          top: 1.3rem;
          left: 0rem;
        }
        .nick {
          position: absolute;
          top: 2rem;
          left: 4.5rem;
          color: #ffffff;
        }
        .icon-xiangyou {
          position: absolute;
          top: 2rem;
          right: 0rem;
          color: #ffffff;
        }
        .guanz_fens {
          text-align: left;
          position: absolute;
          top: 3.5rem;
          left: 4rem;
          .name {
            margin: 0 0.5rem;
          }
          .num {
            color: #fff;
          }
        }
      }
    }
    .title {
      height: 2rem;
      text-align: left;
      line-height: 2rem;
    }
    .num {
      color: #5c5c5c;
      font-size: 0.8rem;
    }
    .my_music {
      height: 11rem;
      font-size: 0.9rem;
      .my_ms {
        padding: 0 1rem;
        box-sizing: border-box;
        .ms_cont {
          width: 100%;
          display: flex;
          justify-content: space-between;
          .m_box {
            height: 8rem;
            width: 31.8%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #ccc;
            border-radius: 5px;
          }
        }
      }
    }
    .my_gedan {
      .my_gd {
        .title {
          padding: 0 1rem;
        }
        .act {
          color: #000000 !important;
          font-size: 1em;
          transition: all 0.15s linear;
        }
        .def {
          transition: all 0.15s linear;
        }
        .gdt {
          width: 100%;
          display: inline-flex;
          justify-content: space-between;
          .gdtl {
            color: #838383;
            .num {
              font-size: 0.7em;
              margin: 0 1rem 0 0.2rem;
            }
          }
          .gdtr {
            .shanc {
              font-size: 20px;
              margin: 0 15px;
            }
            .plzk {
              color: #a7a7a7;
              vertical-align: top;
            }
            .quanxuan {
              vertical-align: top;
              font-size: 16px;
            }
            .icon-piliang {
              vertical-align: top;
            }
          }
        }
        .gdlist {
          position: relative;
          .wdgd {
            position: relative;
          }
          .wei {
            font-size: 1.05em;
            height: 3rem;
            border: 1px solid #7f7f7f;
            justify-content: center;
            padding: 0!important;
            margin: 1rem;
            box-sizing: border-box;
          }
          .gditem {
            display: flex;
            align-items: center;
            border-radius: 5px;
            padding: 0.5rem 1rem;
            img {
              display: inline-block;
              height: 3.3rem;
              border-radius: 5px;
            }
            .gdCover {
              width: 3.3rem;
              height: 3.3rem;
              background: #ebebeb;
              position: relative;
              border-radius: 5px;
            }
            .gdCover::before,
            .gdCover::after {
              content: '';
              width: 3px;
              height: 50%;
              border-radius: 5px;
              background: #727272;
              position: absolute;
              top: 50%;
              left: 50%;
              transform: translate(-50%,-50%);
            }
            .gdCover::before {
              width: 50%;
              height: 3px;
            }
            .text_num {
              margin-left: 0.5rem;
              .num {
                text-align: left;
                font-size: 0.7em;
                color: #858585;
              }
            }
            .piliang {
              flex: 1;
              text-align: right;
              input {
                width: 20px;
                height: 20px;
                margin: 0;
                vertical-align: middle;
                position: relative;
                z-index: 200;
              }
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
          .del-notice {
            position: absolute;
            top: 2.5rem;
            left: 50%;
            transform: translateX(-50%);
            background-color: rgba(0,0,0,0.6);
            padding: 12px;
            box-sizing: border-box;
            border-radius: 15px;
            color: #ffffff;
            z-index: -1;
            opacity: 0;
            transition: all .5s;
          }
          .del-show {
            z-index: 1;
            opacity: 1;
          }
        }
      }
    }
  }
</style>

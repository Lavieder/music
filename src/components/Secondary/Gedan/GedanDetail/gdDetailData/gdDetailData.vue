<template>
  <scroll class="gddetaildata" :data="gedanData">
    <div ref="gddetaildata" @touchmove="curr !== 'recently' ? gedanMove() : ''">
      <div v-show="curr !== 'recently'">
        <div class="cover_operate" :class="curr == 'like' ? 'like-cover' : ''" v-if="gedanData[0]" ref="coverOperate" >
          <div class="cover">
            <div class="coverImg">
              <img  v-if="curr == 'gedan'" v-lazy="'/storage/'+gedanData[0].gdCover" :alt="gedanData[0].gdTitle">
              <img  v-if="curr == 'like'" v-lazy="'/storage/'+FacoverImg" :alt="FacoverImg">
            </div>
            <div class="info">
              <div class="album_singer">
                <div class="album_name">{{ curr == 'gedan' ? gedanData[0].gdTitle : '我喜欢的音乐' }}</div>
                <div class="singer_name textyichu" v-if="curr == 'gedan'">创建者：{{ gedanData[0].user[0].nickName === null ? gedanData[0].user[0].uName : gedanData[0].user[0].nickName }}</div>
                <div class="singer_name textyichu" v-if="curr == 'like'">
                  <router-link :to="{ path: '/user/detail' }">
                    <span class="like" v-lazy:backgroundImage="'/storage/'+gedanData[0].faceUrl"></span>
                    <span class="lk-name">
                      {{ gedanData[0].nickName }}
                      <i class="iconfont icon-xiangyou alIntro"></i>
                    </span>
                  </router-link>
                </div>
              </div>
              <div class="intro textyichu" v-if="curr == 'gedan'">简介：{{ gedanData[0].gdIntro }}
                <i class="iconfont icon-xiangyou alIntro"></i>
              </div>
            </div>
          </div>
          <div class="operate" v-if="curr == 'gedan'">
            <div class="icon collect" @click="collectGedan()" v-if="curr == 'gedan' && !isMycreate">
              <i :class="getMyCollectIcon(gedanData[0])"></i>
              <span>545</span>
            </div>
            <div class="icon collect" v-else>
              <span>已创建</span>
            </div>
            <div class="icon comment">
              <i class="iconfont icon-xiaoxi"></i>
              <span>365</span>
            </div>
            <div class="icon share">
              <i class="iconfont icon-fenxiang"></i>
              <span>分享</span>
            </div>
          </div>
        </div>
      </div>
      <div class="song" ref='list' v-if="curr !== 'recently'">
        <div class="icon_span play_all">
          <div class="left" v-if="gedanData[0]">
            <i class="iconfont icon-zanting"></i>
            <span class="all">播放全部</span><span class="count">(共{{ gedanData[0].song.length }}首)</span>
          </div>
          <div class="right" @click="piLiang" v-if="curr == 'like'">
            <span class="quanxuan" v-if="piliang" @click.stop="allChecked()">
              <span>{{ this.allSelect ? '取消' : '全选' }}</span>
            </span>
            <span v-if="piliang"><i class="iconfont icon-shanc shanc" @click="delMySong"></i></span>
            <span><i  :class="piliang ? 'iconfont icon-piliang' : 'iconfont icon-piliang plzk-icon'"></i></span>
          </div>
        </div>
        <van-cell-group  v-if="gedanData[0]">
          <van-cell center clickable v-for="(song, i) of gedanData[0].song" :key="i" @click="select(song,i)">
            <template #icon>
              <span class="index">{{ i + 1 }}</span>
            </template>
            <template #title>
              <span class="sname textyichu">{{ song.sName }}<span class="subName"> {{ song.subName }} </span></span>
            </template>
            <template #label>
              <div class="icon_span">
                <i class="iconfont icon-sq"></i>
                <span>{{ song.singer.sgName.match(/[\u4e00-\u9fa5,a-zA-Z,\w\s\w,a-zA-z\.+]+/)[0] }} - {{ song.album.alName }}</span>
              </div>
            </template>
            <template>
              <i :class="playing && (song.sid === currentSong.sid) ? 'iconfont icon-laba' : 'iconfont icon-bofang3-copy'"></i>
              <div class="piliang" v-if="piliang">
                <input type="checkbox" :value="song.sid" v-model="checkedList" @click.stop="onlyChecked(song.sid, $event)" ref="checkbox">
              </div>
            </template>
          </van-cell>
        </van-cell-group>
        <div v-if="curr == 'like'" :class="delNotice" class="del-notice" ref="delNotice">
          <span v-if="message">{{ message.success !== ' ' ? message.success : message.fail }}</span>
          <span v-if="message.success == '' && message.fail == ''">{{ checkedList.length == 0 ? '未选择歌单' : '' }}</span>
        </div>
      </div>
      <div class="song" ref='list' v-else>
        <div class="icon_span play_all">
          <div class="left" v-if="gedanData">
            <i class="iconfont icon-zanting"></i>
            <span class="all">播放全部</span><span class="count">(共{{ gedanData.length }}首)</span>
          </div>
          <div class="right" @click="piLiang">
            <span class="quanxuan" v-if="piliang" @click.stop="allChecked()">
              <span>{{ this.allSelect ? '取消' : '全选' }}</span>
            </span>
            <span v-if="piliang"><i class="iconfont icon-shanc shanc" @click="delMySong"></i></span>
            <span><i  :class="piliang ? 'iconfont icon-piliang' : 'iconfont icon-piliang plzk-icon'"></i></span>
          </div>
        </div>
        <van-cell-group  v-if="gedanData">
          <van-cell center clickable v-for="(song, i) of gedanData" :key="i" @click="select(song,i)">
            <template #icon>
              <span class="index">{{ i + 1 }}</span>
            </template>
            <template #title>
              <span class="sname textyichu">{{ song.sName }}<span class="subName"> {{ song.subName }} </span></span>
            </template>
            <template #label>
              <div class="icon_span">
                <i class="iconfont icon-sq"></i>
                <span>{{ song.singer.sgName.match(/[\u4e00-\u9fa5,a-zA-Z,\w\s\w,a-zA-z\.+]+/)[0] }} - {{ song.album.alName }}</span>
              </div>
            </template>
            <template>
              <i :class="playing && (song.sid === currentSong.sid) ? 'iconfont icon-laba' : 'iconfont icon-bofang3-copy'"></i>
              <div class="piliang" v-if="piliang">
                <input type="checkbox" :value="song.sid" v-model="checkedList" @click.stop="onlyChecked(song.sid, $event)" ref="checkbox">
              </div>
            </template>
          </van-cell>
        </van-cell-group>
        <div v-if="curr == 'like'" :class="delNotice" class="del-notice" ref="delNotice">
          <span v-if="message">{{ message.success !== ' ' ? message.success : message.fail }}</span>
          <span v-if="message.success == '' && message.fail == ''">{{ checkedList.length == 0 ? '未选择歌单' : '' }}</span>
        </div>
      </div>
    </div>
  </scroll>
</template>

<script>
import Scroll from '../../../../scroll/scroll'
import { mapGetters, mapActions } from 'vuex'
import { playListMixin } from '../../../../../JS/mixin'
export default {
  components: { Scroll },
  data () {
    return {
      piliang: false,
      allSelect: false,
      checkedList: [],
      isCollect: false
    }
  },
  mixins: [playListMixin],
  props: {
    gedanData: {
      type: Array,
      default: () => []
    },
    curr: {
      type: String,
      default: ''
    },
    FacoverImg: {
      type: String,
      default: ''
    },
    message: {
      type: Object,
      default: () => {}
    },
    isMycreate: {
      type: Boolean,
      default: false
    }
  },
  computed: {
    delNotice () {
      return this.message.success !== '' ? this.showMessage() : ''
    },
    ...mapGetters([
      'playing',
      'currentSong',
      'collectGedanList'
    ])
  },
  methods: {
    // 批量删除
    piLiang () {
      this.piliang = !this.piliang
    },
    // 监听导航
    gedanMove () {
      if (this.gedanData) {
        const coverOperateHeight = this.$refs.coverOperate.offsetHeight
        const scrollHeight = this.$refs.gddetaildata.getBoundingClientRect().top
        const backHeader = this.$parent.$el.children[0].offsetHeight
        const percent = Math.abs(scrollHeight / (coverOperateHeight - backHeader))
        if (scrollHeight <= 0) {
          this.$parent.$el.children[0].style.background = `rgba(252,65,86,${percent})`
        }
      } else {
        return ''
      }
    },
    // 单击复选框
    onlyChecked (sid, e) {
      if (e.target.checked) {
        this.checkedList.push(sid)
      } else {
        const sidIndex = this.checkedList.indexOf(sid)
        this.checkedList.splice(sidIndex, 1)
      }
      if (this.curr !== 'recently') {
        if (this.checkedList.length === this.gedanData[0].song.length) {
          this.allSelect = true
        } else {
          this.allSelect = false
        }
      } else {
        if (this.checkedList.length === this.gedanData.length) {
          this.allSelect = true
        } else {
          this.allSelect = false
        }
      }
    },
    // 全选
    allChecked () {
      const _this = this
      _this.allSelect = !_this.allSelect
      _this.$refs.checkbox.forEach(function (ele) {
        if (_this.allSelect) {
          ele.checked = true
        } else {
          ele.checked = false
        }
        const gdidIndex = _this.checkedList.indexOf(parseInt(ele.value))
        if (ele.checked) {
          if (gdidIndex !== -1) {
            return
          }
          _this.checkedList.push(parseInt(ele.value))
        } else {
          _this.checkedList.splice(gdidIndex, 1)
        }
      })
    },
    // 点击删除按钮，向后端发送对应的歌曲sid
    delMySong () {
      if (!this.checkedList.length) {
        this.showMessage()
      } else {
        if (this.curr !== 'recently') {
          if (this.curr === 'like') {
            this.$emit('delMyLikeSong', this.checkedList)
          } else {
            this.showMessage()
          }
        } else {
          this.recentlyPlay({
            song: '',
            type: 'remove',
            checkedList: this.checkedList
          })
          this.$emit('delSuccess')
        }
      }
    },
    // 显示成功/失败提示文字
    showMessage () {
      if (this.message.success === '删除成功' || this.message.fail === '删除失败') {
        this.piliang = false
      }
      this.$refs.delNotice.style.opacity = 1
      this.$refs.delNotice.style.zIndex = 1
      this.$refs.delNotice.style.transitionDuration = '500ms'
      setTimeout(() => {
        this.$refs.delNotice.style.opacity = 0
        this.$refs.delNotice.style.zIndex = -1
      }, 1500)
    },
    // 判断歌曲是否是我喜欢的
    isMyCollect (gedan) {
      const index = this.collectGedanList.findIndex((item) => {
        return item.gdid === gedan.gdid
      })
      return index > -1
    },
    getMyCollectIcon (gedan) {
      if (this.isMyCollect(gedan)) {
        this.isCollect = true
        return 'iconfont icon-xihuan_on'
      } else {
        this.isCollect = false
        return 'iconfont icon-xihuan_off'
      }
    },
    ...mapActions([
      'selectPlay',
      'recentlyPlay'
    ]),
    select (song, index) {
      if (this.curr === 'recently') {
        this.selectPlay({
          list: this.gedanData,
          index
        })
      } else {
        this.selectPlay({
          list: this.gedanData[0].song,
          index
        })
      }
    },
    // 收藏歌单
    collectGedan () {
      this.$emit('collectGedan', this.gedanData[0].gdid, this.isCollect)
    },
    handlePlayList (playList) {
      if (playList.length > 0) {
        setTimeout(() => {
          const paddingBottom = playList.length > 0 ? '55px' : ''
          this.$refs.list.style.paddingBottom = paddingBottom
        }, 200)
      }
    }
  }
}
</script>

<style lang="less">
  .gddetaildata {
    width: 100%;
    height: 100%;
    .cover_operate {
      padding: 1rem 1rem 0 1rem;
      box-sizing: border-box;
      background: linear-gradient(to bottom right, #e4a0a4, #b91e27);
      color: #fff;
      .cover {
        height: 20vh;
        display: flex;
        align-items: center;
        margin: 1.7rem 0 0 1rem;
        .coverImg {
          position: relative;
          box-shadow: 0 7px 13px rgba(0,0,0,.21);
          border-radius: 18px;
          img {
            display: block;
            height: 7.3rem;
            width: 7.3rem;
            border-radius: 18px;
          }
        }
        .coverImg::before {
          content: '';
          height: 100%;
          width: 100%;
          background: #545454;
          position: absolute;
          left: 0.85rem;
          border-radius: 50%;
          z-index: -1;
        }
        .info {
          height: 8rem;
          width: 100%;
          display: flex;
          flex-direction: column;
          justify-content: space-between;
          margin-left: 1.5rem;
          .album_singer {
            position: relative;
          }
          .singer_name {
            width: 11rem;
            margin-top: 7px;
            font-size: 0.9em!important;
            color: rgba(255, 255, 255, 0.8);
            .sgname {
              top: 3px;
              right: 0;
            }
            a {
              color: #ffffff;
            }
            .like {
              display: inline-block;
              background-repeat: no-repeat;
              background-position: center;
              background-size: cover;
              width: 30px;
              height: 30px;
              border-radius: 50%;
              vertical-align: middle;
            }
            .lk-name {
              font-size: 0.95rem;
              vertical-align: middle;
              margin-left: 5px;
              .icon-xiangyou {
                bottom: 6px;
                right: 0;
              }
            }
          }
          .intro {
            width: 11.5rem;
            font-size: 0.9em;
            color: rgba(255,255,255,0.8);
            .alIntro {
              right: 0;
            }
          }
          .icon-xiangyou {
            position: absolute;
          }
        }
      }
      .operate {
        height: 3.8rem;
        display: flex;
        justify-content: space-between;
        .iconfont {
          font-size: 1.5em;
          margin-right: 5px;
        }
        .icon {
          display: flex;
          align-items: center;
        }
      }
    }
    .song {
      position: relative;
      .icon_span {
        display: flex;
        .iconfont {
          margin-right: 5px;
          font-size: 1.7em;
          color: #fc4156;
        }
      }
      .play_all {
        align-items: center;
        justify-content: space-between;
        padding: 0.7rem 1rem;
        box-sizing: border-box;
        .icon-zanting {
          font-size: 1.5em;
          color: #2eac40;
        }
        .left {
          display: flex;
          align-items: center;
          .all {
            margin-left: 3px;
            font-size: 0.94em;
          }
          .count {
            margin-left: 5px;
            font-size: 0.8em;
          }
        }
        .right {
          .shanc {
            font-size: 22px;
            margin: 0 15px;
          }
          span {
            vertical-align: top;
            .icon-piliang {
              vertical-align: top;
              font-size: 1.3rem;
            }
            .plzk-icon {
              color: #a7a7a7;
            }
          }
          .quanxuan {
            vertical-align: top;
            font-size: 16px;
          }
        }
      }
      .van-cell-group {
        padding: 0;
        width: auto;
        .van-cell {
          margin: 0;
          padding: 8px 15px;
          border-radius: 0;
          .index {
            width: 30px;
            margin-left: 7px;
          }
          .van-cell__title {
            flex: 18rem;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: clip;
            .subName {
              font-size: 0.75em;
              color: #6e6e6e;
            }
          }
          .van-cell__value {
            flex: 4.3rem;
            height: 2.2rem;
            line-height: 2.2rem;
            color: #ee0a24;
            .iconfont {
              font-size: 1.75rem;
            }
            .piliang {
              flex: 1;
              text-align: right;
              input {
                width: 20px;
                height: 20px;
                margin: 0;
                vertical-align: middle;
              }
            }
          }
        }
      }
      .del-notice {
        position: absolute;
        top: 2.6rem;
        left: 50%;
        transform: translateX(-50%);
        font-size: 14px;
        background-color: rgba(0,0,0,0.6);
        padding: 12px;
        box-sizing: border-box;
        border-radius: 15px;
        color: #ffffff;
        z-index: -1;
        opacity: 0;
        transition: all .5s;
      }
    }
    // 文字溢出
    .textyichu {
      overflow: hidden;
      white-space: nowrap;
      text-overflow: ellipsis;
    }
    .like-cover {
      padding-bottom: 1.5rem;
    }
  }
</style>

<template>
  <div class="play-list" v-if="showFlag" @click="hide">
    <transition name="list-fade" appear>
      <div class="list-wrapper" @click.stop>
        <div class="list-header">
          <span class="playMode" :class="iconMode" @click="changeMode">
            <span>{{ playText }}</span>
          </span>
          <span class="iconfont icon-shanc" @click="clearSongList"></span>
        </div>
        <scroll :data="sequenceList" class="list-main" ref="listMain">
          <van-cell-group>
            <transition-group name="list-del" ref="list" tag="div">
              <div class="list-song" ref="listItem" center v-for="(song, i) of sequenceList" :key="i" @click="selectSong(song,i)">
                <van-cell>
                  <template #icon>
                    <i :class="getLaba(song)"></i>
                  </template>
                  <template #title>
                    <span class="sname textyichu">{{song.sName}}</span>
                  </template>
                  <template>
                    <i class="iconfont icon-shanchu" @click.stop="deleteSong(song)"></i>
                  </template>
                </van-cell>
              </div>
            </transition-group>
          </van-cell-group>
        </scroll>
        <div class="list-close" @click="hide">关闭</div>
      </div>
    </transition>
  </div>
</template>

<script>
import { mapGetters, mapMutations, mapActions } from 'vuex'
import Scroll from '../../scroll/scroll'
import { playMode } from '../../../JS/playMode'
export default {
  components: { Scroll },
  data () {
    return {
      showFlag: false
    }
  },
  computed: {
    iconMode () {
      return this.mode === playMode.sequence ? 'iconfont icon-liebiaobofang' : this.mode === playMode.loop ? 'iconfont icon-danquxunhuan' : 'iconfont icon-suijibofang'
    },
    playText () {
      return this.mode === playMode.sequence ? '列表播放' : this.mode === playMode.loop ? '循环播放' : '随机播放'
    },
    ...mapGetters([
      'sequenceList',
      'playList',
      'currentSong',
      'mode'
    ])
  },
  methods: {
    show () {
      this.showFlag = true
      setTimeout(() => {
        this.$refs.listMain.refresh()
        this.$refs.listMain.scrollToElement(this.currentSong)
      }, 20)
    },
    hide () {
      this.showFlag = false
    },
    getLaba (song) {
      if (this.currentSong.sid === song.sid) {
        return 'iconfont icon-laba'
      }
    },
    selectSong (song, index) {
      if (this.mode === playMode.random) {
        index = this.playList.findIndex((item) => {
          return song.sid === item.sid
        })
      }
      this.setCurrentIndex(index)
      this.setPlayState(true)
    },
    // 播放的歌曲显示在第一位
    scrollToFirst (current) {
      const index = this.sequenceList.findIndex((song) => {
        return current.sid === song.sid
      })
      this.$refs.listMain.scrollToElement(this.$refs.listItem[index], 300)
    },
    // 删除歌曲
    deleteSong (song) {
      this.deleteSong(song)
      if (!this.playList.length) {
        this.hide()
      }
    },
    // 全部删除
    clearSongList () {
      this.deleteSongList()
      this.hide()
    },
    // 播放模式切换
    changeMode () {
      const mode = (this.mode + 1) % 3
      this.setPlayMode(mode)
      let list = null
      // 随机播放
      if (mode === playMode.random) {
        list = this.sequenceList.slice().sort(() => {
          return 0.5 - Math.random()
        })
      } else {
        list = this.sequenceList
      }
      this.resetCurrentIndex(list)
      this.setPlayList(list)
    },
    // 切换模式时，当前歌曲不变
    resetCurrentIndex (list) {
      const index = list.findIndex((item) => {
        return item.sid === this.currentSong.sid
      })
      this.setCurrentIndex(index)
    },
    ...mapMutations({
      setCurrentIndex: 'SET_CURRENT_INDEX',
      setPlayState: 'SET_PLAYING_STATE',
      setPlayMode: 'SET_PLAY_MODE',
      setPlayList: 'SET_PLAY_LIST'
    }),
    ...mapActions([
      'deleteSong',
      'deleteSongList'
    ])
  },
  watch: {
    currentSong (newSong, oldSong) {
      if (!this.showFlag || newSong.sid === oldSong.sid) {
        return
      }
      setTimeout(() => {
        this.scrollToFirst(newSong)
      }, 20)
    }
  }
}
</script>
<style lang="less">
  .play-list {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    z-index: 182;
    background-color: rgba(0,0,0,.3);
    color: #ffffff;
    .list-wrapper {
      position: absolute;
      left: 0;
      bottom: 0;
      width: 100%;
      background-color: #333;
      .list-header {
        padding: 15px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        .playMode {
          font-size: 30px;
          display: flex;
          align-items: center;
          span {
            margin-left: 10px;
            font-size: 16px;
          }
        }
      }
      .list-main {
        max-height: 250px;
        overflow: hidden;
        .list-song {
          height: 50px;
          padding: 0 20px;
          font-size: 15px;
          background-color: #333;
          .van-cell {
            padding: 0;
            background-color: transparent;
            color: #ffffff;
            line-height: 50px;
          }
          .icon-laba {
            color: #ffd4d8;
            font-size: 1.3em;
          }
        }
        .sname {
          margin-left: 7px;
          display: inline-block;
          width: 18rem;
          vertical-align: middle;
        }
      }
      .list-close {
        padding: 15px 20px;
        text-align: center;
          background-color: #2d2f2f;
      }
    }
    .textyichu {
      overflow: hidden;
      white-space: nowrap;
      text-overflow: ellipsis;
      position: relative;
    }
    .list-fade-enter-active,
    .list-fade-leave-active {
      transition: all 0.3s;
    }
    .list-fade-enter,
    .list-fade-leave-to {
      opacity: 0;
      transform: translate3d(0, 100%, 0);
    }
    .list-del-enter-active,
    .list-del-leave-active {
      transition: all 1s;
    }
    .list-del-enter,
    .list-del-leave-to {
      height: 0;
    }
  }
</style>

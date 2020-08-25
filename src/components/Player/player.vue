<template>
  <div class="player" v-show="playList.length>0">
    <transition name="normal">
      <div class="normal-player" v-show="fullScreen">
        <div class="top">
          <div class="back" @click="back">
            <i class="iconfont icon-fanhui"></i>
          </div>
          <h1 class="title">{{ currentSong.sName }}</h1>
          <h2 class="subtitle" v-if="currentSong.singer">{{ currentSong.singer.sgName }}</h2>
        </div>
        <div class="background">
          <img width="100%" height="100%" :src="'/storage/'+ currentSong.coverUrl">
        </div>

        <div class="middle"
             @touchstart="middleTouchStart"
             @touchmove="middleTouchMove"
             @touchend="middleTouchEnd"
        >
          <div class="middle-l" ref="middleL">
            <div class="cd-box">
              <div :class="cdRotate">
                <img class="img" :src="'/storage/'+ currentSong.coverUrl">
              </div>
            </div>
          </div>
          <scroll class="middle-r" ref="lyricsList" :data="currentLyrics && currentLyrics.lines">
            <div class="lyrics-wrapper">
              <div v-if="currentLyrics">
                <p ref="lyricsLine" class="text" :class="{ 'current': currentLineNum === index }"
                  v-for="(line, index) in currentLyrics.lines" :key="index">{{ line.txt }}</p>
              </div>
              <div v-else>
                <p ref="lyricsLine" class="text current">此歌曲为没有填词的纯音乐，请您欣赏</p>
              </div>
            </div>
          </scroll>
        </div>

        <div class="bottom">
          <div class="progress-box">
            <span class="time time-l">{{formatTime(currentTime)}}</span>
            <div class="progress-bar-box">
              <progress-bar :percent="percent" @percentChange="onProgressChange"></progress-bar>
            </div>
            <span class="time time-r">{{ formatTime(currentSong.duration) }}</span>
          </div>
          <div class="operators">
            <div class="icon i-left">
              <i :class="iconMode" @click="changeMode"></i>
            </div>
            <div class="icon i-left" :class="disableClass">
              <i class="iconfont icon-shangyishou" @click="prev"></i>
            </div>
            <div class="icon i-center" :class="disableClass">
              <i :class="playIcon" @click="togglePlay"></i>
            </div>
            <div class="icon i-right" :class="disableClass">
              <i class="iconfont icon-xiayishou-copy" @click="next"></i>
            </div>
            <div class="icon i-right">
              <i class="iconfont icon-xihuan_off"></i>
            </div>
          </div>
        </div>
      </div>
    </transition>
    <transition name="mini">
      <div class="mini-player" v-show="!fullScreen" @click="open">
        <div class="img-box">
          <div :class="cdRotate">
            <img width="40" height="40" :src="'/storage/'+ currentSong.coverUrl">
          </div>
        </div>
        <div class="text">
          <div class="name">{{ currentSong.sName }}</div>
          <div class="desc">{{ playLyric }}</div>
        </div>
        <div class="control">
          <div class="progress" @click.stop="togglePlay">
            <progress-circle :width="circleWidth" :height="circleHeight" :percent="percent">
              <i :class="playIconMini" class="icon-mini"></i>
            </progress-circle>
          </div>
        </div>
        <div class="control">
          <i class="iconfont icon-bofangliebiao"></i>
        </div>
      </div>
    </transition>
    <audio :src="'/storage/'+currentSong.playUrl" ref="audio" @error="error" @timeupdate="updateTime" @ended="end"></audio>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
import ProgressBar from './ProgressBar/ProgressBar'
import ProgressCircle from './ProgressCircle/ProgressCircle'
import { playMode } from '../../JS/playMode'
import Scroll from '../scroll/scroll'
import Lyric from 'lyric-parser'

export default {
  components: { ProgressBar, ProgressCircle, Scroll },
  data () {
    return {
      songReady: false,
      currentTime: 0,
      circleWidth: 32,
      circleHeight: 35,
      lyrics: [],
      currentLyrics: null,
      currentLineNum: 0,
      currentShow: 'cd',
      playLyric: ''
    }
  },
  computed: {
    playIcon () {
      return this.playing ? 'iconfont icon-bofang' : 'iconfont icon-zanting'
    },
    playIconMini () {
      return this.playing ? 'iconfont icon-bofang-mini' : 'iconfont icon-zanting'
    },
    iconMode () {
      return this.mode === playMode.sequence ? 'iconfont icon-liebiaobofang' : this.mode === playMode.loop ? 'iconfont icon-danquxunhuan' : 'iconfont icon-suijibofang'
    },
    cdRotate () {
      return this.playing ? 'cd play' : 'cd play pause'
    },
    disableClass () {
      return this.songReady ? '' : 'disable'
    },
    ...mapGetters([
      'singer',
      'fullScreen',
      'playList',
      'currentSong',
      'playing',
      'currentIndex',
      'mode',
      'sequenceList'
    ]),
    // 进度条百分比
    percent () {
      return this.currentTime / (parseFloat(this.currentSong.duration))
    }
  },
  watch: {
    currentSong (newSong, oldSong) {
      if (newSong.sid === oldSong.sid) {
        return
      }
      if (this.currentLyrics) {
        this.currentLyrics.stop()
      }
      // this.$nextTick 确保后台播放请求js, 所以换成setTimeout
      setTimeout(() => {
        this.$refs.audio.play()
        this.getLyrics()
      })
    },
    playing (newPlaying) {
      const audio = this.$refs.audio
      this.$nextTick(() => {
        newPlaying ? audio.play() : audio.pause()
      })
    }
  },
  created () {
    this.touch = {}
  },
  methods: {
    back () {
      this.setFullScreen(false)
    },
    open () {
      this.setFullScreen(true)
    },
    ...mapMutations({
      setFullScreen: 'SET_FULL_SCREEN',
      setPlayingState: 'SET_PLAYING_STATE',
      setCurrentIndex: 'SET_CURRENT_INDEX',
      setPlayMode: 'SET_PLAY_MODE',
      setPlayList: 'SET_PLAY_LIST'
    }),

    // 播放暂停
    togglePlay () {
      if (!this.songReady) {
        return
      }
      this.setPlayingState(!this.playing)
      if (this.currentLyrics) {
        this.currentLyrics.togglePlay()
      }
    },
    // 上一首
    prev () {
      if (!this.songReady) {
        return
      }
      if (this.playList.length === 1) {
        this.loop()
        return
      } else {
        let index = this.currentIndex - 1
        if (index === -1) {
          index = this.playList.length - 1
        }
        this.setCurrentIndex(index)
        if (!this.playing) {
          this.togglePlay()
        }
      }
      this.songReady = true
    },
    // 下一首
    next () {
      if (!this.songReady) {
        return
      }
      if (this.playList.length === 1) {
        this.loop()
        return
      } else {
        let index = this.currentIndex + 1
        if (index === this.playList.length) {
          index = 0
        }
        this.setCurrentIndex(index)
        if (!this.playing) {
          this.togglePlay()
        }
      }
      this.songReady = true
    },
    // 循环
    loop () {
      this.$refs.audio.currentTime = 0
      this.$refs.audio.play()
      this.setPlayingState(true)
      if (this.currentLyrics) {
        this.currentLyrics.seek(0)
      }
    },
    // 自动播放下一首
    end () {
      if (this.mode === playMode.loop) {
        // 循环播放
        this.loop()
      } else {
        this.next()
      }
    },
    error () {
      this.songReady = true
    },
    // 播放时间
    updateTime (e) {
      this.currentTime = e.target.currentTime
    },
    formatTime (interval) {
      interval = Math.floor(interval)
      const minute = this.fillInO(Math.floor(interval / 60))
      const second = this.fillInO(Math.floor(interval % 60))
      return `${minute}:${second}`
    },
    // 时间前面补零
    fillInO (num, n = 2) {
      let len = num.toString().length
      while (len < n) {
        num = '0' + num
        len++
      }
      return num
    },
    // 进度条
    onProgressChange (percent) {
      const currentTime = (parseFloat(this.currentSong.duration)) * percent
      this.$refs.audio.currentTime = currentTime
      if (!this.playing) {
        this.togglePlay()
      }
      if (this.currentLyrics) {
        this.currentLyrics.seek(currentTime * 1000)
      }
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
    // 获取歌词
    getLyrics () {
      this.axios.post('/api/sgdetail/lyrics', this.currentSong).then((res) => {
        const lyrics = res.data
        const str = '[00:00.00]'
        this.lyrics = str + lyrics.substring(lyrics.search(/.*\](词.*?)|(Lyrics by.*?)\n/)).substring(str.length)
        this.currentLyrics = new Lyric(this.lyrics, this.handleLyric)
        if (this.playing) {
          this.currentLyrics.play()
        }
      }).catch(() => {
        this.currentLyrics = null
        this.playLyric = ''
        this.currentLineNum = 0
      })
    },
    // 歌词滚动
    handleLyric ({ lineNum, txt }) {
      this.currentLineNum = lineNum
      if (lineNum > 5) {
        // 让高亮的歌词显示在中间
        const lineEl = this.$refs.lyricsLine[lineNum - 5]
        this.$refs.lyricsList.scrollToElement(lineEl, 1000)
      } else {
        this.$refs.lyricsList.scrollTo(0, 0, 1000)
      }
      this.playLyric = txt
    },
    // 左右切换歌词
    middleTouchStart (el) {
      this.touch.initiated = true
      this.touch.startX = el.touches[0].pageX
      this.touch.startY = el.touches[0].pageY
    },
    middleTouchMove (el) {
      if (!this.touch.initiated) {
        return
      }
      const deltaX = el.touches[0].pageX - this.touch.startX
      const deltaY = el.touches[0].pageY - this.touch.startY
      if (Math.abs(deltaY) > Math.abs(deltaX)) {
        return
      }
      const left = this.currentShow === 'cd' ? 0 : -window.innerWidth
      const offsetWidth = Math.min(0, Math.max(-window.innerWidth, left + deltaX))
      this.touch.percent = Math.abs(offsetWidth / window.innerWidth)
      this.$refs.lyricsList.$el.style.transform = `translateX(${offsetWidth}px)`
      this.$refs.lyricsList.$el.style.transitionDuration = 0
      this.$refs.middleL.style.opacity = 1 - this.touch.percent
      this.$refs.middleL.style.transitionDuration = 0
    },
    middleTouchEnd () {
      let offsetWidth
      let opacity
      if (this.currentShow === 'cd') {
        if (this.touch.percent > 0.1) {
          offsetWidth = -window.innerWidth
          opacity = 0
        } else {
          offsetWidth = 0
          opacity = 1
        }
      } else {
        if (this.touch.percent < 0.9) {
          offsetWidth = 0
          opacity = 1
        } else {
          offsetWidth = -window.innerWidth
          opacity = 0
        }
      }
      const time = 300
      this.$refs.lyricsList.$el.style.transform = `translate3d(${offsetWidth}px,0,0)`
      this.$refs.lyricsList.$el.style.transitionDuration = `${time}ms`
      this.$refs.middleL.style.opacity = opacity
      this.$refs.middleL.style.transitionDuration = `${time}ms`
    }
  }
}
</script>

<style lang="less">
  .player {
    .normal-player {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background-color: #7f7f7f;
      z-index: 102;
      .iconfont {
        color: #fff;
      }
      .top {
        position: relative;
        .back {
          position: absolute;
          top: 0;
          left: 6px;
          z-index: 50;
          .iconfont {
            display: block;
            padding: 9px;
            font-size: 22px;
          }
        }
        .title {
          width: 70%;
          margin: 0 auto;
          line-height: 40px;
          text-align: center;
          text-overflow: ellipsis;
          overflow: hidden;
          white-space: nowrap;
          font-size: 18px;
          font-weight: 400;
          color: #fff;
        }
        .subtitle {
          line-height: 20px;
          text-align: center;
          font-size: 14px;
          color: #fff;
          font-weight: 400;
          margin: 0;
        }
      }
      .background {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: -1;
        opacity: 0.4;
        filter: blur(18px);
        -webkit-filter: blur(18px);
        -moz-filter: blur(18px);
        -ms-filter: blur(18px);
      }
      .middle {
        position: fixed;
        width: 100%;
        top: 4.375rem;
        bottom: 9.6875rem;
        white-space: nowrap;
        font-size: 0;
        .middle-l {
          display: inline-block;
          vertical-align: top;
          position: relative;
          top: 45%;
          width: 100%;
          height: 0;
          padding-top: 85%;
          transform: translateY(-50%);
          .cd-box {
            position: absolute;
            left: 50%;
            top: 0;
            width: 85%;
            height: 100%;
            transform: translateX(-50%);
            .cd {
              width: 100%;
              height: 100%;
              box-sizing: border-box;
              border-radius: 50%;
              border: 17px solid rgba(255, 255, 255, 0.1);
              &.play {
                animation: cdRotate 20s linear infinite;
              }
              &.pause {
                animation-play-state: paused;
              }
              .img {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                border-radius: 50%;
                box-shadow: 0 0 25px rgb(255, 255, 255);
              }
            }
          }
        }
        .middle-r {
          display: inline-block;
          vertical-align: top;
          width: 100%;
          height: 100%;
          overflow: hidden;
          .lyrics-wrapper {
            // width: 80%;
            margin: 0 auto;
            overflow: hidden;
            text-align: center;
            p {
              margin: 0;
              padding: 0;
            }
            .text {
              line-height: 40px;
              color: hsla(0,0%,100%,.5);
              font-size: 14px;
              white-space: break-spaces;
            }
          }
          .current {
            color: #fff!important;
          }
        }
      }
      .bottom {
        position: absolute;
        bottom: 8%;
        width: 100%;
        .dot-box {
          text-align: center;
          font-size: 0;
          .dot {
            display: inline-block;
            vertical-align: middle;
            margin: 0 4px;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: hsla(0,0%,100%,.5);
          }
          .active {
            width: 20px;
            border-radius: 5px;
            background: hsla(0,0%,100%,.8);
          }
        }
        .progress-box {
          display: flex;
          align-items: center;
          width: 80%;
          margin: 0 auto;
          padding: 7px 0;
          .time {
            color: #fff;
            font-size: 12px;
            flex: 0 0 30px;
            line-height: 30px;
            width: 30px;
          }
          .time-l {
            text-align: left;
          }
          .time-r {
            text-align: right;
          }
          .progress-bar-box {
            flex: 1;
            margin: 0 6px;
          }
        }
        .operators {
          display: flex;
          align-items: center;
          .icon {
            flex: 1;
            .iconfont {
              font-size: 30px;
            }
            .icon-zanting,
            .icon-bofang {
              font-size: 50px;
            }
          }
          .i-left {
            text-align: right;
          }
          .i-center {
            padding: 0 20px;
            text-align: center;
          }
          .i-right {
            text-align: left;
          }
        }
      }
      &.normal-enter-active,
      &.normal-leave-active {
        transition: all 0.4s;
        .top,
        .bottom {
          transition: all 0.4s cubic-bezier(0.86, 0.18, 0.82, 1.32)
        }
      }
      &.normal-enter,
      &.normal-leave-to {
        opacity: 0;
        .top {
          transform: translate3d(0, -100px, 0)
        }
        .bottom {
          transform: translate3d(0, 100px, 0)
        }
      }
    }
    .mini-player {
      display: flex;
      align-items: center;
      position: fixed;
      left: 0;
      bottom: 0;
      z-index: 180;
      width: 100%;
      height: 55px;
      background: rgba(255,255,255,0.98);
      box-shadow: 0 3px 5px #6a6a6a;
      .img-box {
        flex: 0 0 40px;
        width: 40px;
        height: 40px;
        padding: 0 10px 0 15px;
        .cd {
          height: 100%;
          width: 100%;
          &.play {
            animation: cdRotate 20s linear infinite;
          }
          &.pause {
            animation-play-state: paused;
          }
          img {
            border-radius: 50%;
          }
        }
      }
      .text {
        display: flex;
        flex-direction: column;
        justify-content: center;
        flex: 1;
        line-height: 20px;
        overflow: hidden;
        .name {
          margin: 0 0 2px 0;
          text-overflow: ellipsis;
          overflow: hidden;
          white-space: nowrap;
          font-size: 14px;
          font-weight: 400;
        }
        .desc {
          margin: 0;
          text-overflow: ellipsis;
          overflow: hidden;
          white-space: nowrap;
          font-size: 12px;
          color: #757575;
        }
      }
      .control {
        flex: 0 0 30px;
        width: 30px;
        padding: 0 10px;
        .progress {
          position: relative;
          .iconfont {
            font-size: 30px;
          }
        }
        .iconfont {
          font-size: 30px;
          color: #616161;
        }
        .icon-mini {
          font-size: 32px;
          position: absolute;
          left: 0;
          top: 50%;
          transform: translateY(-50%);
        }
      }
      &.mini-enter-active,
      &.mini-leave-active {
        transition: all 0.4s
      }
      &.mini-enter,
      &.mini-leave-to {
        opacity: 0
      }
    }
    @keyframes cdRotate {
      0% {
        transform: rotate(0)
      }
      100% {
        transform: rotate(360deg);
      }
    }
  }
</style>

<template>
  <scroll class="rankdetaildata" :data="rankDetail">
    <div ref="rankdetaildata" @touchmove="rankDataMove">
      <div class="detail" v-if="rankDetail[0]" ref="detail">
        <div class="sgbgimg" v-lazy:background="'/storage/'+rkBgImage">
          <div class="bgmask" v-lazy:background="'/storage/'+rank.rbCover"></div>
        </div>
      </div>
      <div class="song" v-if="rankDetail[0]" ref='list'>
        <div class="icon_span play_all">
          <div class="left">
            <i class="iconfont icon-zanting"></i>
            <span class="all">播放全部</span><span class="count">(共{{ rankDetail.length }}首)</span>
          </div>
          <div class="right">
            <i class="iconfont icon-piliang"></i>
          </div>
        </div>
        <van-cell-group>
          <van-cell center clickable v-for="(song, i) of rankDetail" :key="i" @click="select(song, i)">
            <template #icon>
              <span class="index">{{ i + 1 }}</span>
            </template>
            <template #title>
              <span class="sname textyichu">{{ song.sName }}<span class="subName"> {{ song.subName }} </span></span>
            </template>
            <template #label>
              <div class="icon_span">
                <i class="iconfont icon-sq"></i>
                <span>{{ song.singer.sgName.match(/[\u4e00-\u9fa5,a-zA-Z,\w\s\w,a-zA-z\.+]+/)[0] }} - {{song.album.alName }}</span>
              </div>
            </template>
            <template>
              <i :class="playing && (song.sid === currentSong.sid) ? 'iconfont icon-laba' : 'iconfont icon-bofang3-copy'"></i>
            </template>
          </van-cell>
        </van-cell-group>
      </div>
    </div>
  </scroll>
</template>

<script>
import { mapGetters } from 'vuex'
import Scroll from '../../../../scroll/scroll'
import { playListMixin } from '../../../../../JS/mixin'
export default {
  components: { Scroll },
  mixins: [playListMixin],
  props: {
    rankDetail: {
      type: Array,
      default: () => []
    },
    rkBgImage: {
      type: String,
      default: ''
    }
  },
  computed: {
    ...mapGetters([
      'rank',
      'playing',
      'currentSong'
    ])
  },
  methods: {
    // 监听导航
    rankDataMove () {
      const detailTop = this.$refs.detail.offsetHeight
      const scrollHeight = this.$refs.detail.getBoundingClientRect().top
      const backHeader = this.$parent.$el.children[0].offsetHeight
      const percent = Math.abs(scrollHeight / (detailTop - backHeader))
      if (scrollHeight <= 0) {
        this.$parent.$el.children[0].style.background = `rgba(252,65,86,${percent})`
      }
    },
    select (song, i) {
      this.$emit('selectItem', song, i)
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
  .rankdetaildata {
    width: 100%;
    height: 100%;
    .detail {
      width: 100%;
      height: 40vh;
      .sgbgimg {
        width: 100%;
        height: 100%;
        background-repeat: no-repeat!important;
        background-position: center center!important;
        background-size: 100% 100%!important;
        .bgmask {
          width: 100%;
          height: 100%;
          background-color: rgba(0,0,0,0.2);
          position: relative;
          background-repeat: no-repeat!important;
          background-position: center center!important;
          background-size: 100% 100%!important;
          opacity: 0.4;
        }
      }
    }
    .song {
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
        .iconfont {
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
          .iconfont {
            color: #000;
            font-size: 1.2em;
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
            flex: 3rem;
            height: 2.2rem;
            line-height: 2.2rem;
            color: #ee0a24;
            .iconfont {
              font-size: 1.75rem;
            }
          }
        }
      }
    }
  }
</style>

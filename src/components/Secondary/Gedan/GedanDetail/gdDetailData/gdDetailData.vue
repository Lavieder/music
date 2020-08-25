<template>
  <scroll class="gddetaildata" :data="gedanData">
    <div>
      <div class="cover_operate" v-if="gedanData[0]">
        <div class="cover">
          <div class="coverImg" >
            <img v-lazy="'/storage/'+gedanData[0].gdCover" :alt="gedanData[0].gdTitle">
          </div>
          <div class="info">
            <div class="album_singer">
              <div class="album_name">{{ gedanData[0].gdTitle }}</div>
              <div class="singer_name textyichu" v-if="gedanData[0].user">创建者：{{ gedanData[0].user.nickName }}</div>
            </div>
            <div class="intro textyichu">简介：{{ gedanData[0].gdIntro }}
              <i class="iconfont icon-xiangyou alIntro"></i>
            </div>
          </div>
        </div>
        <div class="operate">
          <div class="icon collect">
            <i class="iconfont icon-xihuan_off"></i>
            <span>545</span>
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
      <div class="song"  ref='list'>
        <div class="icon_span play_all">
          <div class="left" v-if="gedanData[0]">
            <i class="iconfont icon-zanting"></i>
            <span class="all">播放全部</span><span class="count">(共{{ gedanData[0].song.length }}首)</span>
          </div>
          <div class="right">
            <i class="iconfont icon-piliang"></i>
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
              <i class="iconfont">&#xe753;</i>
            </template>
          </van-cell>
        </van-cell-group>
      </div>
    </div>
  </scroll>
</template>

<script>
import Scroll from '../../../../scroll/scroll'
import { mapActions } from 'vuex'
import { playListMixin } from '../../../../../JS/mixin'
export default {
  components: { Scroll },
  mixins: [playListMixin],
  props: {
    gedanData: {
      type: Array,
      default: () => []
    }
  },
  methods: {
    ...mapActions([
      'selectPlay'
    ]),
    select (song, index) {
      this.selectPlay({
        list: this.gedanData[0].song,
        index
      })
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
          .singer_name {
            width: 8.5rem;
            margin-top: 7px;
            font-size: 0.9em!important;
            color: rgba(255, 255, 255, 0.8);
            .sgname {
              top: 3px;
              right: 0;
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
            top: 1px;
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
    // 文字溢出
    .textyichu {
      overflow: hidden;
      white-space: nowrap;
      text-overflow: ellipsis;
      position: relative;
    }
  }
</style>

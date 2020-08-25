<template>
  <div class="aldetaildata">
    <div class="cover_operate">
      <div class="cover">
        <div class="coverImg">
          <img :src="'/storage/' + album.alImgUrl" alt="album.alName">
        </div>
        <div class="info">
          <div class="album_singer">
            <div class="album_name">{{album.alName}}</div>
            <div v-if="album.singer">
              <router-link :to="`/singer/${album.singer[0].sgid}`">
                <div class="singer_name textyichu">歌手：{{album.singer[0].sgName}}</div>
              </router-link>
            </div>
          </div>
          <div class="intro textyichu">简介：{{album.alIntro}}
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
    <div class="song">
      <div class="icon_span play_all">
        <div class="left">
          <i class="iconfont icon-zanting"></i>
          <span class="all">播放全部</span><span class="count">(共{{albumDetail.length}}首)</span>
        </div>
        <div class="right">
          <i class="iconfont icon-piliang"></i>
        </div>
      </div>
      <van-cell-group>
        <van-cell center clickable v-for="(song, i) of albumDetail.song" :key="i" @click="select(song,i)">
          <template #icon>
            <span class="index">{{ i + 1 }}</span>
          </template>
          <template #title>
            <span class="sname textyichu">{{ song.sName }}<span class="subName"> {{ song.subName }} </span></span>
          </template>
          <template #label>
            <div class="icon_span">
              <i class="iconfont icon-sq"></i>
              <span v-if="album.singer">{{ album.singer[0].sgName }}</span>
            </div>
          </template>
          <template>
            <i class="iconfont">&#xe753;</i>
          </template>
        </van-cell>
      </van-cell-group>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  props: {
    albumDetail: {
      type: Object,
      default: () => {}
    }
  },
  computed: {
    ...mapGetters([
      'singer',
      'album'
    ])
  },
  methods: {
    select (song, index) {
      this.$emit('selectSong', song, index)
    }
  }
}
</script>

<style lang="less">
  .aldetaildata {
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
          .router-link-active {
            color: #fff;
            .singer_name {
              width: 8.5rem;
              margin-top: 7px;
              font-size: 0.9em;
              color: rgba(255,255,255,0.8);
              .sgname {
                top: 3px;
                right: 0;
              }
            }
          }
          .intro {
            width: 11rem;
            font-size: 0.9em;
            color: rgba(255,255,255,0.8);
            .alIntro {
              right: 0.1rem;
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

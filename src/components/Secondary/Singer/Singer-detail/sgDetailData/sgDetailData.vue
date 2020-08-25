<template>
  <div class="sgdetaildata">
    <div v-for="(singer,index) of singerDetail" :key="index">
      <div class="detail">
        <div class="sgbgimg" :style="{ background: 'url(/storage/'+singer.sgBgImgUrl +')'}">
          <div class="bgmask">
            <div class="info">
              <div class="fans">
                <div class="name">{{singer.sgName}}</div>
                <div class="fans">100万粉丝</div>
              </div>
              <div class="guanzBtn">
                <van-button round block>
                  + 关注
                </van-button>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="content">
        <van-tabs v-model="tabActive" @change="tabClick" animated swipeable sticky offset-top="46px">
          <van-tab v-for="(tab,index) of singerTab" :key="index" :title="tab.title">
            <template v-if="tabActive == 0">
              <songs :singer="singer" @selectSong="selectSong"></songs>
            </template>
            <template v-if="tabActive == 1">
              <albums :albums="singerDetailAlbum" @selectAlbum="selectAlbum"></albums>
            </template>
            <template v-if="tabActive == 2">
              <sg-info :sginfo="singer"></sg-info>
            </template>
          </van-tab>
        </van-tabs>
      </div>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
import songs from './ChildDetail/songs'
import albums from './ChildDetail/albums'
import sgInfo from './ChildDetail/sgInfo'
import { mapActions, mapMutations, mapGetters } from 'vuex'

export default {
  components: { songs, albums, sgInfo },
  props: {
    singerDetail: {
      type: Array,
      default: () => []
    },
    singerDetailAlbum: {
      type: Array,
      default: () => []
    }
  },
  data () {
    return {
      singerTab: [
        { tid: 0, title: '歌曲' },
        { tid: 1, title: '专辑' },
        { tid: 2, title: '详情' }
      ],
      tabActive: 0
    }
  },
  computed: {
    ...mapGetters([
      'singer'
    ])
  },
  methods: {
    tabClick (i) {
      this.tabActive = i
    },
    // 接收子组件传过来的歌曲和下标
    selectSong (song, index) {
      this.selectPlay({
        list: this.singerDetail[0].song,
        index
      })
    },
    ...mapActions([
      'selectPlay'
    ]),
    ...mapMutations({
      setAlbum: 'SET_ALBUM'
    }),
    selectAlbum (album) {
      const singer = this.singer
      this.$router.push({
        path: `/singer/${singer.sgid}/${album.alid}`
      })
      this.setAlbum(album)
    }
  }
}
</script>

<style lang="less">
  .sgdetaildata {
    height: 100%;
    .detail {
      width: 100%;
      height: 44vh;
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
          .info {
            position: absolute;
            bottom: 3.3rem;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 1.2rem;
            box-sizing: border-box;
            .name {
              font-size: 20px;
              color: #eee;
              margin-bottom: 0.2rem;
            }
            .fans {
              font-size: 13px;
              color: #eee;
            }
            .guanzBtn {
              width: 75px;
              display: flex;
              justify-content: center;
              align-items: center;
              border-radius: 20px;
              .van-button {
                height: 35px;
                border: 0;
                color: #fff;
                background-color: #ee0a24;
              }
            }
          }
        }
      }
    }
    .content {
      position: relative;
      top: -2.6rem;
      .van-tab--active {
        color: #ee0a24;
      }
      .van-tabs--line .van-tabs__wrap {
        height: 40px;
        border-bottom: 1px solid rgb(238, 238, 238);
        border-radius: 15px 15px 0 0;
      }
      .van-tabs__line {
        width: 2.25rem!important;
      }
    }
  }
</style>

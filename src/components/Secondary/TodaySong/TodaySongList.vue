<template>
  <div class="todaysonglist">
    <div class="songCard">
      <van-cell-group ref="list">
        <van-cell center v-for="(song,idx) of tdSlist" :key="idx" clickable @click="select(song,idx)">
          <template #icon>
          <van-image :src="'/storage/'+song.coverUrl" lazy-load/>
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
      <loading v-if="!tdSlist"></loading>
    </div>
  </div>
</template>

<script>
import { playListMixin } from '../../../JS/mixin'
import Loading from '../../Loading/Loading'
export default {
  components: { Loading },
  mixins: [playListMixin],
  props: {
    tdSlist: {
      type: Array,
      default: () => []
    }
  },
  methods: {
    select (song, index) {
      this.$emit('selectSong', song, index)
    },
    handlePlayList (playList) {
      const paddingBottom = playList.length > 0 ? '55px' : ''
      this.$refs.list.style.paddingBottom = paddingBottom
    }
  }
}
</script>

<style lang="less">
  .todaysonglist {
    padding-top: 46px;
    .songCard {
      .van-cell {
        line-height: 1rem;
        padding: 8px 16px;
        background: rgba(247,247,247);
        .icon_span {
          display: flex;
          .iconfont {
            margin-right: 5px;
            font-size: 1.7em;
            color: #fc4156;
          }
        }
        .van-image {
          width: 3.5rem;
          height: 3rem;
          .van-image__img {
            border-radius: 10px;
          }
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
  .van-grid-item__content--centersong {
    justify-content: 0!important;
    padding: 0 20px !important;
  }

</style>

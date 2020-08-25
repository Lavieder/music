<template>
  <div class="gedanlist" ref="list">
    <div>{{ title }}</div>
    <van-grid column-num="3">
      <van-grid-item v-for="(item, i) of list" :key="i" @click="select(item)">
        <div class="gdimg">
          <img v-if="item.gdCover" v-lazy="'storage/'+item.gdCover" :alt="item.gdTitle">
          <img v-if="item.rbCover" v-lazy="'storage/'+item.rbCover" :alt="item.rbTitle">
          <div class="covermask"></div>
          <div class="playNum">
            <i class="iconfont">&#xe641;</i>
            <span v-if="item.gdPlayNum">{{ item.gdPlayNum >= 10000 ? (item.gdPlayNum / 10000).toFixed(1) + '万' : item.gdPlayNum }}</span>
            <span v-if="item.rbPlayNum">{{ item.rbPlayNum >= 10000 ? (item.rbPlayNum / 10000).toFixed(1) + '万' : item.rbPlayNum }}</span>
          </div>
          <div class="rbUpdate" v-if="item.rbUpdate">{{ item.rbUpdate }}</div>
        </div>
        <span v-if="item.gdTitle" class="gdtitle">{{ item.gdTitle }}</span>
        <span v-if="item.rbTitle" class="gdtitle">{{ item.rbTitle }}</span>
      </van-grid-item>
    </van-grid>
    <loading v-if="!list"></loading>
  </div>
</template>

<script>
import { playListMixin } from '../../../JS/mixin'
import Loading from '../../Loading/Loading'
export default {
  components: { Loading },
  mixins: [playListMixin],
  props: {
    title: {
      type: String,
      default: ''
    },
    list: {
      type: Array,
      default: () => []
    }
  },
  methods: {
    select (item) {
      this.$emit('selectItem', item)
    },
    handlePlayList (playList) {
      const paddingBottom = playList.length > 0 ? '55px' : ''
      this.$refs.list.style.paddingBottom = paddingBottom
    }
  }

}
</script>

<style lang="less">
  .gedanlist {
    padding: 2.875rem .625rem 0;
    box-sizing: border-box;
    background: rgba(247,247,247);
    .van-grid {
      .van-grid-item {
        flex-basis: 33.33%!important;
        font-size: 0.7em;
        .van-grid-item__content {
          padding: 10px 0px;
          background-color: inherit;
          .gdimg {
            position: relative;
            width: 7rem;
            height: 7rem;
            img{
              width: 100%;
              height: 100%;
              border-radius: 10px;
            }
            .covermask {
              position: absolute;
              top: 0;
              left: 0;
              right: 0;
              bottom: 0;
              width: 100%;
              height: 100%;
              border-radius: 10px;
              background: rgba(0,0,0,0.12);
            }
            .playNum {
              position: absolute;
              right: 3px;
              top: 0;
              color: #fff;
              span {
                position: relative;
                top: -1px;
                margin-left: 4px;
              }
            }
            .rbUpdate {
              position: absolute;
              bottom: 4px;
              left: 2px;
              color: #fff;
            }
          }
          .gdtitle {
            display: -webkit-box;
            height: inherit;
            width: 7rem;
            overflow: hidden;
            text-overflow: ellipsis;
            -webkit-box-orient: vertical;
            // 显示2行
            -webkit-line-clamp: 2;
          }
        }
      }
    }
  }
</style>

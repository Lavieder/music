<template>
  <div class="recgedan">
    <van-cell :title="title" is-link center class="title" to="/gedan"></van-cell>
    <van-grid>
      <van-grid-item v-for="(gedan, i) of recGedanList" :key="i" @click="select(gedan)">
        <div class="gdimg">
          <img v-lazy="'storage/'+gedan.gdCover" :alt="gedan.gdTitle">
          <div class="covermask"></div>
          <div class="playNum">
            <i class="iconfont">&#xe641;</i>
            <span>{{ gedan.gdPlayNum >= 10000 ? (gedan.gdPlayNum / 10000).toFixed(1) + '万' : gedan.gdPlayNum }}</span>
          </div>
        </div>
        <span class="gdtitle">{{ gedan.gdTitle }}</span>
      </van-grid-item>
    </van-grid>
  </div>
</template>

<script>
export default {
  props: {
    title: {
      type: String
    },
    recGedanList: {
      type: Array,
      default: () => []
    }
  },
  methods: {
    select (gedan) {
      this.$emit('selectGedan', gedan)
    }
  }
}
</script>

<style lang="less">
  .recgedan{
    .van-cell__title {
      text-align: left;
    }
    .van-grid {
      flex-wrap: nowrap;
      padding-left: 10px;
      box-sizing: border-box;
      overflow-x: scroll;
      overflow-y: hidden;
      .van-grid-item {
        font-size: 0.7em;
        padding: 5px;
        .van-grid-item__content {
          padding: 0px;
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
            white-space: normal;
            text-align: left;
          }
        }
      }
    }
  }
</style>

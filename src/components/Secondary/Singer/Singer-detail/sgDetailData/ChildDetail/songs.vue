<template>
  <div class="songs">
    <van-cell-group>
      <van-cell center v-for="(song,i) of singer.song" :key="'song'+i" clickable @click="selectSong(song, i)">
        <template #icon>
          <span class="index">{{i + 1}}</span>
        </template>
        <template #title>
            <span>{{ song.sName }}<span class="subName"> {{ song.subName }} </span></span>
        </template>
        <template #label>
          <div>
            <span>{{ singer.sgName.match(/[\u4e00-\u9fa5,a-zA-Z,\w\s\w,a-zA-z\.+]+/)[0] }} - {{song.album.alName}}</span>
          </div>
        </template>
        <template>
          <i class="iconfont">&#xe753;</i>
        </template>
      </van-cell>
    </van-cell-group>
  </div>
</template>

<script>
export default {
  props: {
    singer: {
      type: Object
    }
  },
  methods: {
    // .match(/[\u4e00-\u9fa5,a-zA-Z,\w\s\w,a-zA-z\.+]+/)[0]
    selectSong (song, index) {
      // 此函数不写任何业务逻辑，只告诉外面的父组件我被点击了，以及点击的元素是什么,索引是什么
      this.$emit('selectSong', song, index)
    }
  }
}
</script>

<style lang="less">
.songs {
  .van-cell-group {
    .van-cell {
      line-height: 1rem;
      .index {
        margin-right: 1rem;
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
        .iconfont {
          font-size: 28px;
        }
      }
      .alImg {
        width: 3.4rem;
        height: 3.18rem;
        position: relative;
        z-index: 1;
        margin-right: 1.5rem;
        img {
          width: 100%;
          height: 100%;
          border-radius: 5px;
        }
      }
      .alImg::after {
        content: '';
        display: block;
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        width: 3.8rem;
        height: 100%;
        background: #d3d3d3;
        z-index: -1;
        border-radius: 50%;
      }
    }
  }
}
</style>

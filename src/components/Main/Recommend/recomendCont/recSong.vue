<template>
  <div class="recsong">
    <van-cell :title="title" is-link center class="title" to="/todayrec"></van-cell>
    <van-cell-group>
      <van-cell center clickable v-for="(song, i) of recSongList" :key="i" @click="select(song, i)">
        <template #icon>
          <van-image :src="'/storage/'+song.coverUrl" lazy-load/>
        </template>
        <template #title>
          <span class="sname textyichu">{{ song.sName }}</span>
        </template>
        <template #label>
          <div class="icon_span">
            <i class="iconfont icon-sq"></i>
            <span>{{ song.singer.sgName.match(/[\u4e00-\u9fa5,a-zA-Z,\w\s\w,a-zA-z\.+]+/)[0] }}-{{ song.album.alName }}</span>
          </div>
        </template>
        <template>
          <i :class="playing && (song.sid === currentSong.sid) ? 'iconfont icon-laba' : 'iconfont icon-bofang3-copy'" ></i>
        </template>
      </van-cell>
    </van-cell-group>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  props: {
    recSongList: {
      type: Array,
      default: () => []
    },
    title: String
  },
  computed: {
    ...mapGetters([
      'playing',
      'currentSong'
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
.recsong {
  .icon_span {
    display: flex;
    .iconfont {
      margin-right: 5px;
      font-size: 1.7em;
      color: #fc4156;
    }
  }
  .van-cell {
    line-height: 1rem;
    padding: 8px 16px;
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
      text-align: left;
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
</style>

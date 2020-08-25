<template>
  <div class="singerlist">
    <span class="title">热门歌手</span>
    <van-cell-group ref="list">
      <van-cell center v-for="(singer,idx) of singerList" :key="'singer'+idx" clickable @click="select(singer)">
        <template #icon>
          <div class="sgFace" v-lazy:background="'/storage/'+singer.sgFaceUrl" >
          </div>
        </template>
        <template #title>
          <span>{{ singer.sgName }}</span>
        </template>
        <template>
          <i class="iconfont">&#xe61d;</i>
        </template>
      </van-cell>
    </van-cell-group>
    <loading v-if="!singerList"></loading>
  </div>
</template>

<script>
import { playListMixin } from '../../../JS/mixin'
import Loading from '../../Loading/Loading'
export default {
  components: { Loading },
  mixins: [playListMixin],
  props: {
    singerList: Array
  },
  methods: {
    select (singer) {
      this.$emit('select', singer)
    },
    handlePlayList (playList) {
      const paddingBottom = playList.length > 0 ? '55px' : ''
      this.$refs.list.style.paddingBottom = paddingBottom
    }
  }
}
</script>

<style scoped>
  .iconfont {
    font-size: 1.3rem!important;
    color: #ee0a24!important;
  }
  .singerlist {
    position: absolute;
    top: 123px;
    left: 0;
    right: 0;
  }
  .title {
    display: block !important;
    font-size: 0.8rem;
    background-color: rgb(231, 231, 231);
    padding: 6px 16px;
  }
  .van-cell {
    font-size: 13px;
  }
  .sgFace {
    width: 2.5rem;
    height: 2.5rem;
    margin-right: 10px;
    background-repeat: no-repeat!important;
    background-position: center!important;
    background-size: 140%!important;
    border-radius: 50%!important;
  }
</style>

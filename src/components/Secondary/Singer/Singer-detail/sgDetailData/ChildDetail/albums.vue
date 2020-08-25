<template>
  <div class="albums">
    <van-cell-group>
      <van-cell center v-for="(album,i) of albums" :key="'album'+i" clickable @click="select(album)">
        <template #icon>
          <div class="alImg">
            <img :src="'/storage/'+album.alImgUrl">
          </div>
        </template>
        <template #title>
          <span>{{ album.alName }}</span>
        </template>
        <template #label>
          <div>
            <span>{{ album.alResTime }}</span>
          </div>
        </template>
      </van-cell>
    </van-cell-group>
  </div>
</template>

<script>
export default {
  props: {
    albums: {
      type: Array,
      default: () => []
    }
  },
  methods: {
    select (album) {
      this.$emit('selectAlbum', album)
    }
  }

}
</script>

<style lang="less">
 .albums {
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
    }
    .van-cell__value {
      flex: 3rem;
      height: 2.2rem;
      line-height: 2.2rem;
    }
    .alImg {
      width: 3rem;
      height: 2.8rem;
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
      left: 13%;
      right: 0;
      bottom: 0;
      width: 3rem;
      height: 100%;
      background: #545454;
      z-index: -2;
      border-radius: 50%;
    }
  }
 }
</style>

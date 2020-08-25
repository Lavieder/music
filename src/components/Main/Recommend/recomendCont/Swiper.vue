<template>
  <div class="swiper">
   <van-swipe :autoplay="3000" indicator-color="white" v-if="bannerList.length">
      <van-swipe-item v-for="(image,idx) of bannerList" :key="idx">
        <a :href="image.rLink">
          <img :src="'/storage/'+image.rpicUrl" class="img">
        </a>
      </van-swipe-item>
    </van-swipe>
  </div>
</template>

<script>
export default {
  props: {
    bannerList: {
      type: Array
    }
  }
}
</script>

<style lang="less">
  .swiper{
    width: 100vw;
    .img {
      display: block;
      width: 94vw;
      border-radius: 0.8rem;
      margin: 0 auto;
    }
  }
</style>

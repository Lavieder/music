<template>
  <div class="navClass">
    <van-grid>
      <van-grid-item v-for="(item, i) of navClass" :key="i" :to="item.path">
        <i :class="item.navIco"></i>
        <span class="span">{{ item.navName }}</span>
      </van-grid-item>
    </van-grid>
  </div>
</template>

<script>
export default {
  props: {
    navClass: {
      type: Array,
      default: () => []
    }
  }

}
</script>

<style lang="less">
  .navClass {
    span {
      font-size: 0.8rem;
    }
    .iconfont {
      font-size: 1.5625rem;
    }
  }
</style>

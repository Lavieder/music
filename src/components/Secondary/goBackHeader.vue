<template>
  <div class="gobackheader">
    <van-nav-bar>
      <template #left>
        <svg  @click="back" t="1594105764120" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="6064" width="200" height="200"><path d="M470.816019 868.874967c-6.158257 0-12.316513-3.079128-18.47477-6.158257L144.425344 554.800805c-21.553898-24.633027-21.553898-61.58359 0-83.137489l307.915905-307.915905c6.158257-6.158257 12.316513-6.158257 18.47477-6.158257 6.158257 0 12.316513 3.079128 18.47477 6.158257 9.237385 9.237385 9.237385 27.712155 0 36.94954L181.375907 508.61388c-3.079128 3.079128-3.079128 6.158257 0 9.237385l307.915905 307.915905c9.237385 9.237385 9.237385 27.712155 0 36.94954C486.21166 868.874967 480.053404 868.874967 470.816019 868.874967zM184.455035 536.326035c-15.395642 0-24.633027-12.316513-24.633027-24.633027 0-15.395642 12.316513-24.633027 24.633027-24.633027l686.651762 0c15.395642 0 24.633027 12.316513 24.633027 24.633027 0 15.395642-12.316513 24.633027-24.633027 24.633027L184.455035 536.326035z" p-id="6065"></path></svg>
      </template>
      <template #title>
        <div class="title">{{ title }}</div>
      </template>
    </van-nav-bar>
    <div class="subtitle">{{ subtitle }}</div>
  </div>
</template>

<script>
export default {
  props: {
    title: String,
    subtitle: String
  },
  methods: {
    back () {
      this.$router.back()
    }
  }
}
</script>

<style lang="less">
  .gobackheader{
    position: fixed;
    z-index: 100;
    width: 100%;
    .icon{
      width: 1.6rem;
      height: 1.6rem;
    }
    .van-nav-bar {
      .van-nav-bar__title {
        margin: 0 3rem;
        color: #000!important;
      }
    }
  }
</style>

<template>
  <div class="loading">
    <div class='mock'>
      <div class="load" v-for="index in 4" :key="index"></div>
    </div>
    <div class='text'>数据加载中...</div>
  </div>
</template>

<script>
export default {
}
</script>

<style lang="less" scoped>
  .loading {
    display: flex;
    justify-content: center;
    align-items: baseline;
    padding: 20px 0;
    box-sizing: border-box;
    font: 400 0.96em '微软雅黑';
    .mock {
      width: 26px;
      height: 25px;
      display: flex;
      justify-content: space-between;
      margin-right: .6rem;
      .load {
        width:4px;
        height:100%;
        background:rgb(219, 98, 119);
        transform-origin: 25px 25px;
        border-radius: 10px 10px 5px 5px;
        animation:dh .55s infinite linear;
      }
      .load:nth-child(2) {
        animation-delay: 0.1s;
      }
      .load:nth-child(3) {
        animation-delay: 0.3s;
      }
      .load:nth-child(4) {
        animation-delay: 0.18s;
      }
    }
    @keyframes dh{
      50%{
        transform:scaleY(0);
        background:linear-gradient(to top right,rgb(245, 174, 186),rgb(238, 10, 36));
      }
    }
  }
</style>

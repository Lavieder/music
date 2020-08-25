<template>
  <div class="suguser">
    <van-cell-group>
      <van-cell center v-for="(user,idx) of users" :key="'user'+idx" clickable>
        <template #icon>
          <div class="sgFace" v-lazy:background="'/storage/'+user.faceUrl" >
          </div>
        </template>
        <template #title>
          <span>{{ user.nickName }}</span>
        </template>
        <template>
          <i class="iconfont">&#xe61d;</i>
        </template>
      </van-cell>
    </van-cell-group>
  </div>
</template>

<script>
export default {
  props: {
    users: {
      type: Array,
      default: () => []
    }
  }

}
</script>

<style lang="less">
  .suguser {
    .iconfont {
      font-size: 1.3rem!important;
      color: #ee0a24!important;
    }
    .van-cell {
      font-size: 13px;
      .sgFace {
        width: 2.5rem;
        height: 2.5rem;
        margin-right: 10px;
        background-repeat: no-repeat!important;
        background-position: center!important;
        background-size: 140%!important;
        border-radius: 50%!important;
      }
      .van-cell__title {
        flex: 10rem;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: clip;
      }
      .van-cell__value {
        flex: 0rem;
        height: 2.2rem;
        line-height: 2.2rem;
        .iconfont {
          font-size: 28px;
        }
      }
    }
  }
</style>

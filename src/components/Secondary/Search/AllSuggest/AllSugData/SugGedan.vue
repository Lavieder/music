<template>
  <div class="suggedan">
    <van-cell-group>
      <van-cell center v-for="(gedan,i) of gedans" :key="'gedan'+i" clickable @click="select(gedan)">
        <template #icon>
          <div class="alImg">
            <img :src="'/storage/'+gedan.gdCover">
          </div>
        </template>
        <template #title>
          <span>{{ gedan.gdTitle }}</span>
        </template>
        <template #label>
          <div v-if="gedan.user">
            <span>by {{ gedan.user.nickName }}，<span>播放{{ gedan.gdPlayNum }}次</span></span>
          </div>
        </template>
      </van-cell>
    </van-cell-group>
  </div>
</template>

<script>
export default {
  props: {
    gedans: {
      type: Array,
      default: () => []
    }
  },
  methods: {
    select (gedan) {
      this.$emit('select', gedan)
    }
  }
}
</script>

<style lang="less">
  .suggedan {
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
        margin-right: 0.5rem;
        img {
          width: 100%;
          height: 100%;
          border-radius: 5px;
        }
      }
    }
  }
</style>

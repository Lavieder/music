<template>
  <div class="singerclass">
    <van-grid :column-num="5">
      <van-grid-item v-for="(area,index) of areaList" :key="'area'+index" class="area">
        <span @click="areaClick(area.areaid, index)" :class="area.areaid == areaActive ? 'hongse' : 'heise'">{{ area.areaName }}</span>
      </van-grid-item>
      <van-grid-item v-for="(sex,index) of sexList" :key="'sex'+index" class="sex">
        <span @click="sexClick(sex.sexid,index)" :class="sex.sexid == sexActive ? 'hongse' : 'heise'">{{ sex.sexName }}</span>
      </van-grid-item>
    </van-grid>
  </div>
</template>

<script>
export default {
  props: {
    areaList: Array,
    sexList: Array
  },
  data () {
    return {
      areaActive: '',
      sexActive: ''
    }
  },
  methods: {
    areaClick (id, i) {
      this.areaActive = id
      this.$parent.area = id
    },
    sexClick (id, i) {
      this.sexActive = id
      this.$parent.sex = id
    }
  }
}
</script>

<style lang="less">
  .heise{
    color:#333;
  }
  .hongse {
    color:#f00;
  }
  .singerclass{
    position: fixed;
    top: 46px;
    z-index: 100;
    width: 100%;
    box-shadow: 0 4px 5px rgb(231, 231, 231);
    .van-grid {
      padding: 0.8rem 0;
      background-color: #ffffff;
      .area {
        margin-bottom: 1rem;
      }
      .van-grid-item__content {
        padding: 0;
        font-size: 0.85rem;
      }
    }
  }
</style>

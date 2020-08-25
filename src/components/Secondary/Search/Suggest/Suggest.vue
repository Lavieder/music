<template>
  <div class="suggest">
    <van-cell-group>
      <van-cell center v-for="(item, i) of searchData" :key="i" @click="select(item)">
        <template #icon>
          <van-icon :name="getItemIcon(item)" />
        </template>
        <template #title>
          <span class="sname textyichu" :class="getColor(item)">{{ getName(item) }}
            <span :class="keyword === item.singer.sgName ? 'cutColor' : 'defColor'" v-if="item.singer"> {{ item.singer.sgName }}</span>
          </span>
        </template>
      </van-cell>
    </van-cell-group>
  </div>
</template>

<script>
export default {
  props: {
    keyword: {
      type: String,
      default: ''
    },
    searchData: {
      type: Array,
      default: () => []
    }
  },
  methods: {
    getItemIcon (item) {
      if (item.type === 'SINGER') {
        return 'contact'
      } else {
        return 'search'
      }
    },
    getName (item) {
      if (item.type === 'SINGER') {
        return item[0].sgName
      } else if (item.type === 'KEYWORD') {
        return item.keyword
      } else {
        return item.sName
      }
    },
    getColor (item) {
      if (this.keyword === item.sName) {
        return 'cutColor'
      } else if (this.keyword === item.keyword) {
        return 'qeyColor'
      } else {
        return 'defColor'
      }
    },
    select (item) {
      this.$emit('selectItem', item)
    }
  }

}
</script>

<style lang="less">
  .suggest {
    .van-cell {
      padding: 5px 16px;
      box-sizing: border-box;
      font-size: 0.95em;
      line-height: 2.1rem;
      .van-icon  {
        width: 1.875rem;
        font-size: 1.4em;
        color: #a5a5a5;
      }
      .van-cell__title {
        flex: 18rem;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: clip;
      }
    }
    .cutColor {
      color: #dd717d;
    }
    .defColor {
      color: #6a6a6a;
    }
    .qeyColor {
      color: #ee0a24;
    }
  }
</style>

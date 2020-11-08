<template>
  <div class="search-cont" v-if="hotWords.length">
    <div class="hotword his" v-if="searchHistory.length">
      <h2 class="ct-title history">搜索历史
        <span class="his-clear" @click="clearHis">
          <i class="iconfont">&#xe822;</i>
        </span>
      </h2>
      <span class="ct-cont" v-for="(word, i) of searchHistory" :key="i" @click="addWord(word)">{{ word }}</span>
    </div>
    <div class="hotword">
      <h2 class="ct-title">热门搜索</h2>
      <span class="ct-cont" v-for="(word, i) of hotWords" :key="i" @click="addWord(word.swName)">{{ word.swName }}</span>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    hotWords: {
      type: Array,
      default: () => []
    },
    searchHistory: {
      type: Array,
      default: () => []
    }
  },
  data () {
    return {
    }
  },
  methods: {
    addWord (keyword) {
      this.$parent.setWord(keyword)
    },
    clearHis () {
      localStorage.removeItem('searchWord')
      this.searchHistory = []
    }
  }
}
</script>

<style lang="less">
  .search-cont {
    padding: 1rem;
    box-sizing: border-box;
    .hotword {
      .history {
        display: flex;
        justify-content: space-between;
        .his-clear {
          line-height: 1.4rem;
          font-weight: 400;
        }
      }
      .ct-title {
        margin: 0 0 0.8rem!important;
        font-size: 1rem;
        font-weight: 700;
        color: rgba(26,26,26,1);
      }
      .ct-cont {
        vertical-align: top;
        display: inline-block;
        height: 1.3rem;
        line-height: 1.4rem;
        padding: 0.3rem 0.7rem;
        margin: 0 0.7rem 0.5rem 0;
        font-size: 0.8rem;
        background: #f2f2f2;
        border-radius: 20px;
        color: rgba(39, 39, 39, 0.92);
      }
    }
    .his {
      margin-bottom: 1.8rem;
    }
  }
</style>

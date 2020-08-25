<template>
  <transition name="slide" appear>
    <div class="search">
      <van-nav-bar>
        <template #left>
          <svg  @click="back" t="1594105764120" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="6064" width="200" height="200"><path d="M470.816019 868.874967c-6.158257 0-12.316513-3.079128-18.47477-6.158257L144.425344 554.800805c-21.553898-24.633027-21.553898-61.58359 0-83.137489l307.915905-307.915905c6.158257-6.158257 12.316513-6.158257 18.47477-6.158257 6.158257 0 12.316513 3.079128 18.47477 6.158257 9.237385 9.237385 9.237385 27.712155 0 36.94954L181.375907 508.61388c-3.079128 3.079128-3.079128 6.158257 0 9.237385l307.915905 307.915905c9.237385 9.237385 9.237385 27.712155 0 36.94954C486.21166 868.874967 480.053404 868.874967 470.816019 868.874967zM184.455035 536.326035c-15.395642 0-24.633027-12.316513-24.633027-24.633027 0-15.395642 12.316513-24.633027 24.633027-24.633027l686.651762 0c15.395642 0 24.633027 12.316513 24.633027 24.633027 0 15.395642-12.316513 24.633027-24.633027 24.633027L184.455035 536.326035z" p-id="6065"></path></svg>
        </template>
        <template #title>
          <input type="text" v-model="keyword" class="inputText" placeholder="输入歌曲，歌手，专辑" @keyup.enter="search" @focus="inputFocus">
          <span class="clear-text" v-show="keyword" @click="clearText">
            <i class="iconfont">&#xe60b;</i>
          </span>
        </template>
        <template #right>
          <router-link to="/singer">
            <i class="iconfont icon-singer_x"></i>
          </router-link>
        </template>
      </van-nav-bar>
      <transition name="fade">
        <suggest :searchData="searchData" v-if="keyword && !showAll" :keyword="keyword" @selectItem="selectItem"></suggest>
        <all-suggest :searchAllData="searchAllData" v-if="keyword && showAll"></all-suggest>
        <search-cont :hot-words="hotWords" :searchHistory="searchHistory" v-if="!keyword"></search-cont>
      </transition>
      <router-view></router-view>
    </div>
  </transition>
</template>

<script>
import SearchCont from '../components/Secondary/Search/SearchCont'
import Suggest from '../components/Secondary/Search/Suggest/Suggest'
import AllSuggest from '../components/Secondary/Search/AllSuggest/AllSuggest'
import { mapMutations, mapActions } from 'vuex'
export default {
  components: { SearchCont, Suggest, AllSuggest },
  data () {
    return {
      keyword: '',
      showAll: false,
      page: 1,
      hotWords: [],
      searchData: [],
      searchHistory: [],
      searchAllData: {}
    }
  },
  created () {
    const history = localStorage.getItem('searchWord')
    if (history) {
      this.searchHistory = history.split(',')
    }
  },
  mounted () {
    this.getHotWords()
  },
  methods: {
    back () {
      this.$router.back()
    },
    clearText () {
      this.keyword = ''
    },
    setWord (keyword) {
      this.keyword = keyword
    },
    inputFocus () {
      this.showAll = false
    },
    // enter键搜索数据
    search () {
      this.axios.post('/api/search/word', { query: this.keyword }).then((res) => {
        if (res.data) {
          this.searchData = this.genSearch(res.data)
          this.setLocalStorage()
        } else if (res.data === 0) {
          return ''
        }
      })
    },
    shAllData () {
      this.axios.post('/api/search/shall', { query: this.keyword, page: this.page }).then((res) => {
        if (res.data) {
          this.searchAllData = res.data
        } else if (res.data === 0) {
          return ''
        }
      })
    },
    getHotWords () {
      this.axios.get('/api/search/hotwords').then((res) => {
        if (res.data) {
          this.hotWords = res.data
        } else {
          return this.hotWords
        }
      })
    },
    genSearch (data) {
      let res = []
      if (data.singer[0] && data.singer[0].sgid) {
        res.push({ ...data.singer, ...{ type: 'SINGER' } })
      }
      res = res.concat({ keyword: this.keyword, type: 'KEYWORD' })
      if (data) {
        res = res.concat(data[0])
      }
      return res
    },
    setLocalStorage () {
      const searchWord = localStorage.getItem('searchWord')
      if (searchWord == null) {
        localStorage.setItem('searchWord', this.keyword)
      } else {
        let searchHis = this.searchHistory
        let array = localStorage.getItem('searchWord')
        array = array.split(',')
        // 去除重复的历史搜索
        if (array.indexOf(this.keyword) !== -1) {
          array.splice(array.indexOf(this.keyword), 1)
          array.unshift(this.keyword)
          searchHis = array
        } else {
          // unshift() 方法可向数组的开头添加一个或更多元素，并返回新的长度。
          searchHis.unshift(this.keyword)
        }
        this.searchHistory = searchHis
        if (this.searchHistory.length > 15) {
          this.historySearch.pop()
        }
        localStorage.setItem('searchWord', this.searchHistory)
      }
    },
    selectItem (item) {
      if (item.type === 'SINGER') {
        this.$router.push({
          path: `/sg/${item[0].sgid}`
        })
        this.setSinger(item[0])
      } else if (item.type === 'KEYWORD') {
        this.shAllData()
        this.showAll = true
      } else {
        this.insertSong(item)
      }
    },
    ...mapMutations({
      setSinger: 'SET_SINGER'
    }),
    ...mapActions([
      'insertSong'
    ])
  },
  watch: {
    keyword () {
      this.search()
    }
  }

}
</script>

<style lang="less">
  .search {
    overflow: hidden;
    .van-nav-bar {
      .icon{
        width: 1.6rem;
        height: 1.6rem;
      }
      .van-nav-bar__title {
        width: 100%!important;
        max-width: 100%!important;
        margin: 0 3rem!important;
        color: #000!important;
        line-height: 2.2rem;
        position: relative;
        .inputText {
          width: 97%;
          padding: 0;
          border: 0;
          border-bottom: 1px solid #525252;
          font-size: 1em;
        }
        .clear-text {
          position: absolute;
          right: 0;
          top: 0;
          bottom: 0;
          .iconfont {
            font-size: 1.5em;
          }
        }
      }
    }
  }
  &.fade-enter-active {
    transition: all 0.25s
  }
  &.fade-leave-active {
    transition: all 0s
  }
  &.fade-enter,
  &.fade-leave-to {
    opacity: 0
  }
</style>

<template>
  <transition name="slide">
    <div class="singer">
      <go-back-header :title="title"></go-back-header>
      <singer-class :areaList="areaList" :sexList="sexList"/>
      <singer-list :singerList="getSinger" :sgList="sgList" @select="selectSinger" @getSingerList="getSingerList"/>
      <router-view></router-view>
    </div>
  </transition>
</template>

<script>
import goBackHeader from '../components/Secondary/goBackHeader'
import SingerClass from '../components/Secondary/Singer/SingerClass'
import SingerList from '../components/Secondary/Singer/SingerList'
import { mapMutations } from 'vuex'
export default {
  components: { goBackHeader, SingerClass, SingerList },
  data () {
    return {
      areaList: [],
      sexList: [],
      singerList: [],
      sex: '',
      area: '',
      title: '歌手分类',
      sgList: {
        page: 1,
        allSinger: false,
        isSingerOk: false
      }
    }
  },
  mounted () {
    this.getAreaList()
    this.getSexList()
    this.getSingerList()
  },
  methods: {
    getAreaList () {
      this.axios.get('/api/singer/arealist').then((res) => {
        this.areaList = res.data
      })
    },
    getSexList () {
      this.axios.get('/api/singer/sexlist').then((res) => {
        this.sexList = res.data
      })
    },
    getSingerList () {
      const oldList = this.singerList
      this.axios.get('/api/singer/sglist', { params: { page: this.sgList.page } }).then((res) => {
        this.singerList = oldList.concat(res.data.data)
        ++this.sgList.page
        if (this.singerList.length === res.data.total) {
          this.sgList.allSinger = true
          this.sgList.isSingerOk = true
          setTimeout(() => {
            this.sgList.allSinger = false
          }, 3000)
        }
      })
    },
    selectSinger (singer) {
      this.$router.push({
        path: `/singer/${singer.sgid}`
      })
      this.setSinger(singer)
    },

    ...mapMutations({
      setSinger: 'SET_SINGER'
    })

  },
  computed: {
    getSinger () {
      let list = this.singerList
      if (this.area) {
        list = list.filter((value) => {
          return value.areaid === this.area
        })
      }
      if (this.sex) {
        list = list.filter((value) => {
          return value.sexid === this.sex
        })
      }
      return list
    }
  }
}
</script>

<style lang="less">
  .singer {
    .singerlode {
      position: fixed;
      bottom: 0;
      width: 100%;
      text-align: center;
      padding: 15px 0;
      background-image: linear-gradient(to top,#ffffff, transparent);
      z-index: 1;
    }
  }
</style>

<template>
  <transition name="slide">
    <div class="singer">
      <go-back-header :title="title"></go-back-header>
      <singer-class :areaList="areaList" :sexList="sexList"/>
      <singer-list :singerList="getSinger" @select="selectSinger"/>
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
      page: 1,
      allSingerLoaded: false
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
      this.axios.get('/api/singer/sglist', { params: { page: this.page } }).then((res) => {
        this.singerList = res.data.data
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
</style>

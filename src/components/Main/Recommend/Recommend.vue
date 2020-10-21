<template>
  <div class="recommend" ref="recommend">
    <swiper :banner-list="bannerList" ref="banner"/>
    <nav-class :nav-class="navClass" ref="navclass"/>
    <rec-gedan :recGedanList="recGedanList" :title="gedantitle" @selectItem="selectGedan" ref="recgedan"/>
    <rec-song :recSongList="recSongList" :title="songtitle" @selectSong="selectSong" ref="recsong"/>
  </div>
</template>

<script>
import Swiper from './recomendCont/Swiper'
import NavClass from './recomendCont/NavClass'
import RecGedan from './recomendCont/recGedan'
import RecSong from './recomendCont/recSong'
import { mapMutations, mapActions } from 'vuex'
import { playListMixin } from '../../../JS/mixin'
export default {
  components: { Swiper, NavClass, RecGedan, RecSong },
  mixins: [playListMixin],
  data () {
    return {
      bannerList: [],
      navClass: [
        { path: 'todayrec', navName: '今日推荐', navIco: 'iconfont icon-tuijian' },
        { path: 'singer', navName: '歌手', navIco: 'iconfont icon-singer_x' },
        { path: 'gedan', navName: '歌单', navIco: 'iconfont icon-gedan2' },
        { path: 'rank', navName: '排行榜', navIco: 'iconfont icon-paihangbang4' }
      ],
      recGedanList: [],
      recSongList: [],
      gedantitle: '精选歌单',
      songtitle: '推荐歌曲'
    }
  },
  mounted () {
    this.touch = {}
    this.getBanner()
    this.getGedanList()
    this.getSongList()
  },
  methods: {
    getBanner () {
      this.axios.get('/api/rec/banner').then((res) => {
        this.bannerList = res.data
      })
    },
    getGedanList () {
      this.axios.get('/api/rec/gedan').then((res) => {
        this.recGedanList = res.data
      })
    },
    getSongList () {
      this.axios.get('/api/rec/song').then((res) => {
        this.recSongList = res.data
      })
    },
    selectGedan (gedan) {
      this.$router.push({
        path: `/rgd/${gedan.gdid}`
      })
      this.setGedan(gedan)
    },
    selectSong (song, index) {
      this.selectPlay({
        list: this.recSongList,
        index
      })
    },
    ...mapMutations({
      setGedan: 'SET_GEDAN'
    }),
    ...mapActions([
      'selectPlay'
    ]),
    handlePlayList (playList) {
      const paddingBottom = playList.length > 0 ? '55px' : ''
      this.$refs.recommend.style.paddingBottom = paddingBottom
    }
  }
}
</script>

<style lang="less">
  .recommend {
    width: 100vw;
    padding-top: 50px;
  }
</style>

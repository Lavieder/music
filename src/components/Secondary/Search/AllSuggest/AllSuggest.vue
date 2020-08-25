<template>
  <div class="allsuggest">
    <van-tabs v-model="tabActive" animated swipeable scrollspy>
      <van-tab v-for="(tab, index) of suggestTile" :key="index" :title="tab.sugTitle">
        <div>
          <template v-if="tabActive == 0 && searchAllData.song">
            <sug-song :songs="searchAllData.song.data" @select="selectSong"></sug-song>
          </template>
          <template v-if="tabActive == 1 && searchAllData.singer">
            <sug-singer :singers="searchAllData.singer.data" @select="selectSinger"></sug-singer>
          </template>
          <template v-if="tabActive == 2 && searchAllData.album">
            <sug-album :albums="searchAllData.album.data" @select="selectAlbum"></sug-album>
          </template>
          <template v-if="tabActive == 3 && searchAllData.gedan">
            <sug-gedan :gedans="searchAllData.gedan.data" @select="selectGedan"></sug-gedan>
          </template>
          <template v-if="tabActive == 4 && searchAllData.user">
            <sug-user :users="searchAllData.user.data" @select="selectUser"></sug-user>
          </template>
        </div>
        <loading v-if="loading"></loading>
      </van-tab>
    </van-tabs>
  </div>
</template>

<script>
import Loading from '../../../Loading/Loading'
import SugSong from '../AllSuggest/AllSugData/SugSong'
import SugSinger from '../AllSuggest/AllSugData/SugSinger'
import SugAlbum from '../AllSuggest/AllSugData/SugAlbum'
import SugGedan from '../AllSuggest/AllSugData/SugGedan'
import SugUser from '../AllSuggest/AllSugData/SugUser'
import { mapActions, mapMutations, mapState } from 'vuex'
export default {
  components: { Loading, SugSong, SugSinger, SugAlbum, SugGedan, SugUser },
  props: {
    searchAllData: {
      type: Object,
      default: () => {}
    }
  },
  data () {
    return {
      suggestTile: [
        { stid: 0, sugTitle: '歌曲' },
        { stid: 1, sugTitle: '歌手' },
        { stid: 2, sugTitle: '专辑' },
        { stid: 3, sugTitle: '歌单' },
        { stid: 4, sugTitle: '用户' }
      ],
      tabActive: 0
    }
  },
  computed: {
    ...mapState([
      'loading'
    ])
  },
  methods: {
    // 接收子组件传过来的歌曲和下标
    selectSong (song, index) {
      this.selectPlay({
        list: this.searchAllData.song.data,
        index
      })
    },
    selectAlbum (album) {
      this.$router.push({
        path: `/al/${album.alid}`
      })
      this.setAlbum(album)
    },
    selectSinger (singer) {
      this.$router.push({
        path: `/sg/${singer.sgid}`
      })
      this.setSinger(singer)
    },
    selectGedan (gedan) {
      this.$router.push({
        path: `/gd/${gedan.gdid}`
      })
      this.setGedan(gedan)
    },
    selectUser () {

    },
    ...mapActions([
      'selectPlay'
    ]),
    ...mapMutations({
      setAlbum: 'SET_ALBUM',
      setGedan: 'SET_GEDAN',
      setSinger: 'SET_SINGER'
    })
  }

}
</script>

<style lang="less">
  .allsuggest {
    .van-tabs{
      width: 100%;
      height: 100%;
      .van-tabs__line {
        width: 36px!important;
      }
      .van-tab--active{
        color: #ee0a24!important;
      }
    }
  }
</style>

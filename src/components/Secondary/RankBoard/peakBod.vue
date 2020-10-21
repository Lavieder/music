<template>
  <div class="peakbod">
    <div>{{ title }}</div>
    <div class="cover_song" v-for="(item, i) of peakList" :key="i" @click="selectRank(item)">
      <div class="coverImg" >
        <img :src="'/storage/'+item.rbCover" :alt="item.rbTitle">
        <div class="rbUpdate">{{ item.rbUpdate }}</div>
      </div>
      <div class="csong">
        <div class="sitem" v-for="(rksong, idx) of item.songs" :key="idx">
          <span>{{idx + 1}}. </span>{{ rksong.sName }}<span class="rkSinger" v-if="rksong.singer"> - {{rksong.singer.sgName}}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapMutations } from 'vuex'
export default {
  props: {
    peakList: {
      type: Array,
      default: () => []
    }
  },
  data () {
    return {
      title: '巅峰榜'
    }
  },
  methods: {
    selectRank (rank) {
      this.$router.push({
        path: `/rank/${rank.rbid}`
      })
      this.setRank(rank)
    },
    ...mapMutations({
      setRank: 'SET_RANK'
    })
  }
}
</script>

<style lang="less">
  .peakbod {
    padding: 1.8rem 0.625rem 0;
    box-sizing: border-box;
    background: initial;
    .cover_song {
      height: 7.5rem;
      display: flex;
      align-items: center;
      padding: 5px 0 2px 5px;
      .coverImg {
        position: relative;
        border-radius: 5px;
        img {
          display: block;
          height: 7rem;
          width: 7rem;
          border-radius: 10px;
        }
        .rbUpdate {
          position: absolute;
          bottom: 4px;
          left: 2px;
          font-size: 0.7em;
          color: #fff;
        }
      }
      .csong {
        width: 100%;
        padding: 0 15px;
        box-sizing: border-box;
        font-size: 0.9em;
        color: rgb(71,71,71);
        .sitem {
          height: 2rem;
          line-height: 2rem;
          width: 13.5rem;
          overflow: hidden;
          text-overflow: ellipsis;
          white-space: nowrap;
          .rkSinger {
            font-size: 0.5em;
            color: #8b8b8b;
          }
        }
      }
    }
  }
</style>

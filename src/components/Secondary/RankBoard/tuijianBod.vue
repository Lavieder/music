<template>
  <div class="tuijianbod">
    <gedan-list :list="tuijianList" :title="title" @selectItem="selectRank"></gedan-list>
  </div>
</template>

<script>
import GedanList from '../Gedan/GedanList'
import { mapMutations } from 'vuex'
export default {
  components: { GedanList },
  props: {
    tuijianList: {
      type: Array,
      default: () => []
    }
  },
  data () {
    return {
      title: '榜单推荐'
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
  .tuijianbod {
    margin: 20px 0 0 0;
    .gedanlist {
      padding-bottom: 0!important;
    }
  }
</style>

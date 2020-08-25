<template>
  <div class="otherbod">
    <gedan-list :list="otherList" :title="title" @selectItem="selectRank"></gedan-list>
  </div>
</template>

<script>
import GedanList from '../Gedan/GedanList'
import { mapMutations } from 'vuex'
export default {
  components: { GedanList },
  props: {
    otherList: {
      type: Array,
      default: () => []
    }
  },
  data () {
    return {
      title: '特色榜'
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
  .otherbod {
    .gedanlist {
      padding-top: 1.8rem;
    }
  }
</style>

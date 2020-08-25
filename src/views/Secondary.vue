<template>
  <div class="secondary">
    <go-back-header />
      <router-view></router-view>
  </div>
</template>

<script>
import goBackHeader from '../components/Secondary/goBackHeader'
export default {
  components: { goBackHeader }
}
</script>

<style>

</style>

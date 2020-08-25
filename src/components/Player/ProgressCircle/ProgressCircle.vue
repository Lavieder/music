<template>
  <div class="progress-circle">
    <svg :width="width" :height="height" viewBox="0 0 100 100" version="1.1" xmlns="http://www.w3.org/2000/svg">
      <circle class="progress-background" r="50" cx="50" cy="50" fill="transparent"/>
      <circle class="progress-bar" r="50" cx="50" cy="50" fill="transparent" :stroke-dasharray="dashArray"
        :stroke-dashoffset="dashOffset"/>
    </svg>
    <slot></slot>
  </div>
</template>

<script>
export default {
  props: {
    width: {
      type: Number,
      default: 32
    },
    height: {
      type: Number,
      default: 35
    },
    percent: {
      type: Number,
      default: 0
    }
  },
  data () {
    return {
      dashArray: Math.PI * 100
    }
  },
  computed: {
    dashOffset () {
      return (1 - this.percent) * this.dashArray
    }
  }
}
</script>

<style lang="less">
  .progress-circle {
    position: relative;
    svg {
      position: relative;
      top: .11rem;
      left: -0.0625rem;
      z-index: 1;
      circle {
        stroke-width: 7px;
        transform-origin: center;
        &.progress-background {
          transform: scale(0.9);
          // stroke: rgba(0,0,0,0.1);
        }
        &.progress-bar {
          transform: scale(0.91) rotate(-90deg);
          stroke: #ee0a24;
        }
      }
    }
  }
</style>

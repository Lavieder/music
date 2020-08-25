<template>
  <div class="sgInfo">
      <div class="info pad">
        <div class="title">个人信息</div>
        <div class="cont">性别：{{sginfo.sgSex}}</div>
        <div class="cont">出生日期：{{sginfo.birth}}</div>
        <div class="cont">入驻日期：{{sginfo.setIn}}</div>
      </div>
      <div class="intro pad">
        <div class="title">个人介绍</div>
        <div class="cont">{{sginfo.sgIntro == "" ? '还没有填写个人介绍哦': sginfo.sgIntro}}</div>
      </div>
      <div class="honor pad">
        <div class="title">荣誉记录</div>
        <div class="cont">{{sginfo.honor == "" ? '还没有填写个人荣誉哦': sginfo.honor}}</div>
      </div>
    </div>
</template>

<script>
export default {
  props: {
    sginfo: {
      type: Object
    }
  }
}
</script>

<style lang="less">
  .sgInfo {
    .title {
      font-weight: 500;
      margin-bottom: .5rem;
    }
    .cont {
        padding: 3px 0;
        font-size: 0.9rem;
        color: #626262;
      }
    .pad {
      padding: 19px 10px;
    }
  }
</style>

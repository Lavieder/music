import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import './assets/css/style.less'
import './assets/iconfont/iconfont.css'
import Vant from 'vant'
import 'vant/lib/index.css'
import Axios from 'axios'
import VueAxios from 'vue-axios'
import animated from 'animate.css'
import VueLazyload from 'vue-lazyload'
import qs from 'qs'
Vue.use(VueLazyload, {
  error: require('../src/assets/images/error.png'),
  loading: require('../src/assets/images/loading.gif'),
  lazyComponent: true
})
Vue.use(animated)
Vue.use(Vant)
Vue.prototype.axios = Axios
Vue.prototype.$http = VueAxios
Vue.config.productionTip = false

// 添加服务端的请求的拦截，响应的拦截
// 拦截目的：添加携带数据，令牌等
// 请求拦截
Axios.interceptors.request.use(
  config => {
    // 针对post方法进行编码，否则发送不出去
    if (config.method === 'post') {
      // qs 请求字符串，stringify() 对数据进行编码
      if (config.flag !== 'face') {
        config.data = qs.stringify(config.data)
      }
    }
    if (localStorage.token) {
      // 捆绑token等信息，后端中间件
      config.headers = {
        'x-token': localStorage.token,
        'x-uName': localStorage.uName,
        'Content-type': 'application/x-www-form-urlencoded;charset=utf-8'
      }
    }
    store.commit('SET_LOADING', true)
    return config
  },
  err => {
    return Promise.reject(err)
  }
)

// 定义一个响应拦截器  在这里对返回的数据进行处理
Axios.interceptors.response.use((response) => {
  if (response.data.state === 0 && response.data.errcode === 401) {
    // 如果未认证 ，就跳转到登录界面进行认证
    router.replace({
      path: '/login',
      query: { redirect: router.currentRoute }
    })
  }
  store.commit('SET_LOADING', false)
  return response
})

// 添加路由卫士（路由拦截）
router.beforeEach((to, from, next) => {
  if (to.path === '/login') {
    next()
  } else {
    const userInfo = localStorage.getItem('user')
    if (userInfo === null) {
      next('/login')
    } else {
      next()
    }
  }
  // 使用路由的meta参数，显示页面标题
  if (to.meta.title) {
    document.title = to.meta.title
  }
  next()
})
Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')

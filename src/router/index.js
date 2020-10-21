import Vue from 'vue'
import VueRouter from 'vue-router'
import Main from '../views/Main'
import TodaySong from '../views/TodaySong'
import Singer from '../views/Singer'
import Gedan from '../views/Gedan'
import RankBoard from '../views/RankBoard'
import Login from '../views/Login'
import Search from '../views/Search'
import SingerDetail from '../components/Secondary/Singer/Singer-detail/Singer-detail'
import AlbumDetail from '../components/Secondary/Singer/Singer-detail/AlbumDetail/AlbumDetail'
import GedanDetail from '../components/Secondary/Gedan/GedanDetail/GedanDetail'
import RankDetail from '../components/Secondary/RankBoard/RankDetail/RankDetail'
import MyInfo from '../components/Main/My/MyInfo/MyInfo'

Vue.use(VueRouter)

const routes = [
  {
    path: '/login',
    name: 'login',
    component: Login
  },
  {
    path: '/',
    name: 'main',
    component: Main,
    children: [
      { path: '/rgd/:gdid', component: GedanDetail },
      { path: '/mgd/:gdid', component: GedanDetail }
    ]
  },
  { path: '/user/detail', component: MyInfo },
  {
    path: '/todayrec',
    name: 'todaySong',
    component: TodaySong
  },
  {
    path: '/gedan',
    name: 'gedan',
    component: Gedan,
    children: [
      { path: ':gdid', component: GedanDetail }
    ]
  },
  {
    path: '/rank',
    name: 'rankboard',
    component: RankBoard,
    children: [
      { path: ':rbid', component: RankDetail }
    ]
  },
  {
    path: '/singer',
    name: 'singer',
    component: Singer,
    children: [
      {
        path: ':sgid',
        component: SingerDetail,
        children: [
          { path: ':alid', component: AlbumDetail }
        ]
      }
    ]
  },
  {
    path: '/search',
    name: 'search',
    component: Search,
    children: [
      { path: '/sg/:sgid', component: SingerDetail },
      { path: '/al/:alid', component: AlbumDetail },
      { path: '/gd/:gdid', component: GedanDetail }
    ]
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router

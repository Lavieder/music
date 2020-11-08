import { playMode } from '../JS/playMode'
// state 存放最基本的数据
const state = {
  playing: false, // 播放状态，播放/暂停
  fullScreen: false, // 播放页展开和收起
  mode: playMode.sequence, // 播放模式, 默认有序播放
  playList: [], // 播放列表
  sequenceList: [], // 顺序列表
  currentIndex: -1, // 当前播放歌曲的索引，通过索引计算正在播放的歌曲，上一首，下一首
  singer: {},
  album: {},
  gedan: {},
  rank: {},
  loading: false, // loading动画
  loginInfo: JSON.parse(localStorage.getItem('user')) || {},
  playHistory: JSON.parse(localStorage.getItem('playHistory')) || [],
  favoriteList: [],
  collectGedanList: [],
  createGedanList: []
}

export default state

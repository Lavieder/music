import * as types from './mutation-types'
const mutations = {
  [types.SET_SINGER] (state, singer) {
    state.singer = singer
  },
  [types.SET_PLAYING_STATE] (state, flag) {
    state.playing = flag
  },
  [types.SET_FULL_SCREEN] (state, flag) {
    state.fullScreen = flag
  },
  [types.SET_PLAY_MODE] (state, mode) {
    state.mode = mode
  },
  [types.SET_PLAY_LIST] (state, list) {
    state.playList = list
  },
  [types.SET_SEQUENCE_LIST] (state, list) {
    state.sequenceList = list
  },
  [types.SET_CURRENT_INDEX] (state, index) {
    state.currentIndex = index
  },
  [types.SET_ALBUM] (state, album) {
    state.album = album
  },
  [types.SET_GEDAN] (state, gedan) {
    state.gedan = gedan
  },
  [types.SET_RANK] (state, rank) {
    state.rank = rank
  },
  [types.SET_LOADING] (state, loading) {
    state.loading = loading
  },
  [types.SET_LOGININFO] (state, loginInfo) {
    state.loginInfo = loginInfo
  }
}

export default mutations

export const singer = state => state.singer

export const playing = state => state.playing

export const fullScreen = state => state.fullScreen

export const mode = state => state.mode

export const playList = state => state.playList

export const sequenceList = state => state.sequenceList

export const currentIndex = state => state.currentIndex

export const currentSong = (state) => {
  return state.playList[state.currentIndex] || {}
}

export const album = state => state.album

export const rank = state => state.rank

export const gedan = state => state.gedan

export const loginInfo = state => state.loginInfo

export const playHistory = state => state.playHistory

export const favoriteList = state => state.favoriteList

export const collectGedanList = state => state.collectGedanList

export const createGedanList = state => state.createGedanList

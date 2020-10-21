import * as types from './mutation-types'
// 在一个动作多次改变mutation 则最好封装个action
// 给selectPlay 传2个对象，然后分别取对象里的值
export const selectPlay = ({ commit, state }, { list, index }) => {
  commit(types.SET_SEQUENCE_LIST, list)
  commit(types.SET_PLAY_LIST, list)
  commit(types.SET_CURRENT_INDEX, index)
  commit(types.SET_FULL_SCREEN, true)
  commit(types.SET_PLAYING_STATE, true)
}

function findIndex (list, song) {
  return list.findIndex((item) => {
    return item.sid === song.sid
  })
}
// 搜索页面点击歌曲自动添加到播放列表
export const insertSong = ({ commit, state }, song) => {
  // action内部不能直接修改state状态，需要给mutation修改state状态，这里使用slice() 建立一个副本
  const playList = state.playList.slice()
  const sequenceList = state.sequenceList.slice()
  let currentIndex = state.currentIndex
  // 1.记录当前歌曲
  const currentSong = playList[currentIndex]
  // 2. 调用findIndex方法，playList 中有没有这首歌曲
  // 查找当前是否有待插入的歌曲并返回其索引
  const findPlayListIndex = findIndex(playList, song)
  // 3.如果是插入歌曲的话，所以索引+1
  currentIndex++
  // 4.插入这首歌到当前索引位置
  playList.splice(currentIndex, 0, song)
  // 5.如果已经包含这首歌，就把这首歌从playList列表中删除
  if (findPlayListIndex > -1) {
    // 5.1 如果当前插入的歌曲序号大于它在列表中的下标序号
    //     如果当前插入的歌曲在它本身后面 [1,2,3,2]
    if (currentIndex > findPlayListIndex) {
      // 在playList中删除开始的歌曲，删掉之后的数组长度就要-1
      playList.splice(findPlayListIndex, 1)
      currentIndex--
    } else {
      // 5.2 如果当前插入的歌曲在它本身前面或本身位置 [1,3,2,3]/[1,2(2),3]
      //     那么播放列表 的长度都要+1
      playList.splice(findPlayListIndex + 1, 1)
    }
  }
  // 6.获取需要插入的歌曲的位置
  const currentSeqIndex = findIndex(sequenceList, currentSong) + 1
  // 7. 找之前sequenceList里面有没有包含currentSong
  const findSeqIndex = findIndex(sequenceList, song)
  // 8.如果已经包含这首歌，就把这首歌从sequenceList列表中删除,并在后面插入需要插入的歌曲
  sequenceList.splice(currentSeqIndex, 0, song)
  // 9.判断插入的位置
  if (findSeqIndex > -1) {
    if (currentSeqIndex > findSeqIndex) {
      // 9.1 如果当前插入的歌曲在它本身后面 [1,2,3,2]
      sequenceList.splice(findSeqIndex, 1)
      // currentIndex 不需要-1，因为currentIndex是在playList中的位置
    } else {
      // 9.2 如果当前插入的歌曲在它本身前面或本身位置 [1,3,2,3]/[1,2(2),3]
      sequenceList.splice(findSeqIndex + 1, 1)
    }
  }
  // 10. 提交给Mutation处理
  commit(types.SET_PLAY_LIST, playList)
  commit(types.SET_SEQUENCE_LIST, sequenceList)
  commit(types.SET_CURRENT_INDEX, currentIndex)
  commit(types.SET_FULL_SCREEN, true)
  commit(types.SET_PLAYING_STATE, true)
}

// 登录信息
export const Login = ({ commit }, user) => {
  commit(types.SET_LOGININFO, user)
}

module.exports = {
  // lintOnSave: false,
  devServer: {
    host: '0.0.0.0', // 允许外部ip访问
    port: 8080, // 端口
    https: false, // 启用https
    proxy: {
      '/api': {
        // target: 'http://192.168.137.1:19230/index.php',
        target: 'http://127.0.0.1:8000',
        ws: true,
        changeOrigin: true
      },
      // 图片请求地址
      '/storage': {
        // target: 'http://192.168.137.1:19230',
        target: 'http://127.0.0.1:8000',
        ws: true,
        changeOrigin: true
      }
    }
    // overlay: {
    //   warnings: false,
    //   errors: false
    // }
  }
}

const path = require("path");

module.exports = {
  entry: "./js/app.js",
  output: {
    path: path.resolve(__dirname, "public"),
    filename: "main.js"
  },
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
          "style-loader", 
          {
            loader: "css-loader",
            options: { url: false }
          }, 
          "sass-loader"
        ]
      }
    ]
  }
}

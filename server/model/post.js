const mg = require("mongoose");
const User = require("./user");

const postModel = new mg.Schema({
  title: {
    type: String,
    required: true,
  },
  content: {
    type: String,
    required: true,
  },
  author: {
    type: String,
    required: true,
  },
  likes: [
    {
      // type: mg.Schema.Types.ObjectId,
      // ref: "User",
      type: String,
      required: true,
    },
  ],
  createdAt: { type: Date, default: Date.now },
  updatedAt: { type: Date, default: Date.now },
});

const Post = mg.model("Post", postModel);

module.exports = Post;

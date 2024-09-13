const express = require("express");
const Post = require("../model/post");
const User = require("../model/user");
const postRouter = express.Router();

/// Getters .
postRouter.get("/api/getAllPosts", async (req, res) => {
  try {
    const data = await Post.find();
    res.send(data);
  } catch (e) {
    res.status(500).json(e);
  }
});
postRouter.get("/api/getAuthorPosts", async (req, res) => {
  try {
    const { authorId } = req;
    const authorPost = await Post.find({ authorId });
    res.status(200).json({
      msg: "scucess",
      data: authorPost,
    });
  } catch (e) {
    res.status(500).json(e);
  }
});
postRouter.get("/api/getPopularPosts", async (req, res) => {
  try {
    const posts = await Post.find();
    const sortedPost = posts.sort((a, b) => a.likes.length);
    res.status(200).json({
      msg: "scucess",
      data: sortedPost,
    });
  } catch (e) {
    res.status(500).json(e);
  }
});

/// Setters
postRouter.post("/api/createPost", async (req, res) => {
  try {
    const { userId, data } = req.body;
    const user = await User.findOne({ _id: userId });
    if (!user) {
      res.status(404).json({ msg: "User not found" });
      return;
    }
    let newPost = new Post({
      ...data,
      author: userId,
      likes: [],
    });
    newPost = await newPost.save();
    res.status(200).json({
      msg: "scucess",
      data: newPost,
    });
  } catch (e) {
    res.status(500).json(e);
  }
});

postRouter.post("/api/updatePost", async (req, res) => {
  try {
    const { userId, data, postId } = req.body;
    const post = await Post.findOne({ _id: postId });
    if (!post) {
      res.status(404).json({ msg: "Post not found" });
      return;
    }
    if (post.author !== userId) {
      res.status(400).json({ msg: "You can't edit this post" });
      return;
    }
    let editPost = await Post.findOneAndUpdate(
      { _id: postId },
      { ...data },
      { new: true }
    );
    res.status(200).json({
      msg: "post updated",
      data: editPost,
    });
  } catch (e) {
    res.status(500).json(e);
  }
});

postRouter.post("/api/deletePost", async (req, res) => {
  try {
    const { userId, postId } = req.body;
    const post = await Post.findOne({ _id: postId });
    if (post.author !== userId) {
      res.status(400).json({ msg: "You can't delete this Post" });
      return;
    }
    const del = await Post.deleteOne({ _id: postId });
    console.log(del);
    if (del != null && del.acknowledged) {
      res.send("Post deleted");
    } else {
      res.status(400).json({ msg: "Issue in deleting" });
    }
  } catch (e) {
    res.status(500).json(e);
  }
});

postRouter.post("/api/likePost", async (req, res) => {
  try {
    const { userId, postId } = req.body;
    const user = await User.findOne({ _id: userId });
    const post = await Post.findOne({ _id: postId });

    if (!user) {
      res.status(400).json({ msg: "You are not valid user to like the Post" });
      return;
    }
    if (!post) {
      res.status(404).json({ msg: "Post not found" });
      return;
    }

    console.log(post.likes);
    console.log(post.likes.length);

    if (post.likes.includes(user._id)) {
      res.status(200).json({ msg: "You already liked the post" });
      return;
    }

    let editPost = await Post.findOneAndUpdate(
      { _id: postId },
      { likes: [...post.likes, user._id] },
      { new: true }
    );
    console.log(editPost);

    res.status(200).json({
      msg: "post updated",
      data: editPost,
    });
  } catch (e) {
    console.log(e);

    res.status(500).json(e);
  }
});

module.exports = postRouter;

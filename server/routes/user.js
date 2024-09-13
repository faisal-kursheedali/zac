const express = require("express");
const User = require("../model/user");
const userRoute = express.Router();
const bcryptjs = require("bcryptjs");

userRoute.post("/api/createUser", async (req, res) => {
  const { name, email, password } = req.body;

  const user = await User.findOne({ email });
  if (user) {
    res.status(400).json({
      msg: "User exist, please login",
    });
  } else {
    const hash = await bcryptjs.hash(password, 8);
    let newUser = new User({
      name,
      email,
      password: hash,
    });
    newUser = await newUser.save();
    res.status(200).json({
      msg: "user Created",
      data: { name: newUser.name, email: newUser.email, id: newUser._id },
    });
  }
});

userRoute.post("/api/loginUser", async (req, res) => {
  const { email, password } = req.body;

  const user = await User.findOne({ email });
  if (user) {
    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }
    res.status(200).json({
      msg: "User logged in",
      data: { name: user.name, email: user.email, id: user._id },
    });
  } else {
    res.status(400).json({
      msg: "User don't exist",
    });
  }
});

userRoute.post("/api/getUserData", async (req, res) => {
  const { userId } = req.body;

  const user = await User.findOne({ _id: userId });
  if (user) {
    res.status(200).json({
      msg: "User logged in",
      data: { name: user.name, email: user.email, id: user._id },
    });
  } else {
    res.status(400).json({
      msg: "User don't exist",
    });
  }
});

module.exports = userRoute;

const dotenv = require("dotenv");
dotenv.config();

const express = require("express");
const userRoute = require("./routes/user");
const postRouter = require("./routes/post");
const mongoose = require("mongoose");
const PORT = process.env.PORT || 3000;
const DB = process.env.DB_URL;
const app = express();

app.get("/", (req, res) => {
  res("Server is working");
});
app.use(express.json());
app.use(postRouter);
app.use(userRoute);

mongoose
  .connect(DB)
  .then(() => console.log("mongoose connected"))
  .catch((e) => console.log(e));

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});

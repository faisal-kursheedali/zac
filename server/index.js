const express = require("express");
const userRoute = require("./routes/user");
const postRouter = require("./routes/post");
const mongoose = require("mongoose");
const PORT = process.env.PORT || 3000;
const app = express();

app.get("/", (req, res) => {
  res("Server is working");
});
app.use(express.json());
app.use(postRouter);
app.use(userRoute);

mongoose
  .connect(
    "mongodb+srv://dummy:bogAUiRl89GRzNP3@cluster0.scg1y.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
  )
  .then(() => console.log("mongoose connected"))
  .catch((e) => console.log(e));

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});

/// dummy
/// bogAUiRl89GRzNP3
// mongodb+srv://dummy:bogAUiRl89GRzNP3@cluster0.scg1y.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0

console.log("Hello World");
// IMPORTS FROM PACKAGES
import express, { json } from "express";
import mongoose from "mongoose";

// import authRouter from "./routes/auth.js

// import adminRouter from "./routes/admin";
// IMPORTS FROM OTHER FILES
import authRouter from "./routes/auth.js";
// import productRouter from "./routes/product";
// import userRouter from "./routes/user";


// INIT
const PORT = process.env.PORT || 3000;
const app = express();
/// CREATING AN API
/// get ,put,post,delete,update -> CRUD

const DB =
  "mongodb+srv://nguyenthongoc22072004:Js69vGKB28ajTN0i@cluster0.kw9th.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// middleware
app.use(json()); /// để nó chuyển dữ liệu từ json sang js object để dễ dàng xử lý được đối với js object đó để lấy ra các thuộc tính của nó

app.use(authRouter);
// app.use(adminRouter);
// app.use(productRouter);
// app.use(userRouter);

// Connections
mongoose.connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});

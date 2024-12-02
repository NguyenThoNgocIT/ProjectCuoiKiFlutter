// IMPORTS FROM PACKAGES
import express, { json } from "express";
import mongoose from "mongoose";
// import adminRouter from "./routes/admin";
// IMPORTS FROM OTHER FILES
import authRouter from "./routes/auth.js";
import productRouter from "./routes/product.js";
import userRouter from "./routes/user.js";

// INIT
const PORT = process.env.PORT || 3000;
const app = express();
const DB =
  "mongodb+srv://nguyenthongoc22072004:nguyenthongoc@cluster0.3rkpx.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// middleware
app.use(json());
app.use(authRouter);
// app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// Connections

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});

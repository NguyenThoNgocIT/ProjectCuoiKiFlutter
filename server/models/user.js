// user.js
import { Product, productSchema } from "../models/product.js";
import mongoose from "mongoose";

const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        /// Simple email validation regex
        /// Regex này kiểm tra cấu trúc email cơ bản nhưng không hoàn hảo 
        ///và có thể không bao gồm tất cả các địa chỉ email hợp lệ.
        // Nếu bạn cần kiểm tra email một cách chính xác hơn, bạn có thể cần
        // sử dụng một thư viện hoặc dịch vụ bên ngoài.
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.]*)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: "Please enter a valid email address",
    },
  },/// Xác thực mật khẩu rất đơn giản, bạn có thể thêm độ phức tạp hơn nếu cần

  password: {
    required: true,
    type: String,
  },
  address: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "user",
  },
  cart: [
    {
      product: productSchema, // Using productSchema here
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
});

const User = mongoose.model("User", userSchema);
export default userSchema;

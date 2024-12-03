// user.js
import mongoose from "mongoose";
import { Product, productSchema } from "../models/product.js";

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
        /// source:stackoverflow
        /// nó đảm bảo rằng email phải đúng định dạng bằng cách sử dụng biểu thức chính quy (regular expression) được định nghĩa trong hàm validator. 
        //Biểu thức chính quy này kiểm tra xem email có đúng định dạng hay không, bao gồm cả các ký tự trước và sau dấu @, cũng như các ký tự sau dấu chấm trong tên miền.
        // Nếu email không khớp với biểu thức chính quy, validator sẽ trả về false, và thông báo lỗi sẽ được hiển thị.
        /// Đây là một cách để đảm bảo rằng dữ liệu email được nhập vào hợp lệ và có định dạng chính xác.
        //validate an email address in JavaScript
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.]*)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      ///nếu email không hợp lệ, thì sẽ hiển thị thông báo lỗi "Please enter a valid email address"
      message: "Vui lòng nhập địa chỉ email hợp lệ", /// cái phương thức này sẽ được user bên routes gọi lại 
    },
  },
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
export default User;

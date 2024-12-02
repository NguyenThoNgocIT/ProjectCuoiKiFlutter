import express from "express";
import User from "../models/user.js";
import bcryptjs from "bcryptjs";//cái ni dùng để mã hóa mk user 
import jwt from "jsonwebtoken"; // Sử dụng import thay vì require chức năng tạo token để xác thực người dùng.
import auth from "../middlewares/auth.js"; // Đảm bảo nhập middleware đúng

const authRouter = express.Router();

// SIGN UP
// lấy dữ liệu từ client đưa lên database 
// trả lại dữ liệu cho client 
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    // Kiểm tra nếu thiếu trường
    if (!name || !email || !password) {
      return res.status(400).json({ msg: "Vui lòng cung cấp tất cả các trường bắt buộc!" });
    }
// nó sẽ tìm kiếm trong database xem có email nào trùng với email mà client gửi lên không, nếu có thì nó sẽ trả về lỗi, 
//nếu không thì nó sẽ tiếp tục thực hiện các bước tiếp theo.
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "Người dùng có cùng email đã tồn tại!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);
//
    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// SIGN IN
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ msg: "Vui lòng cung cấp tất cả các trường bắt buộc!" });
    }

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "Người dùng có email này không tồn tại!" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Mật khẩu không chính xác." });
    }

    // Sử dụng khóa bảo mật từ biến môi trường
    // chức năng tạo token đã được định nghĩa ở trên để tạo token cho người dùng đã xác thực. Token này sẽ được sử dụng để xác thực yêu cầu sau này của người dùng.
    // Token được tạo ra bằng cách sử dụng thư viện JSON Web Token (JWT) và chứa ID của người dùng. Token có thời gian hết hạn sau 1 giờ. Token được gửi lại cho 
    //người dùng trong phản hồi JSON của yêu cầu đăng nhập. Người dùng có thể sử dụng token này để xác thực các yêu cầu sau này đến API bằng cách bao gồm token trong tiêu 
    //đề "x-auth-token" của yêu cầu. Điều này cho phép API xác minh danh tính của người dùng và cung cấp các tài nguyên hoặc thực hiện các hành động 
    //được ủy quyền cho người dùng.


    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: "1h" });
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Token validation route
// Đây là một route bảo mật, nó sẽ kiểm tra xem token gửi lên có hợp lệ hay không. Nếu token hợp lệ, nó sẽ trả về true, ngược lại sẽ trả về false.
// Route này có thể được sử dụng để kiểm tra tính hợp lệ của token trước khi thực hiện các yêu cầu được bảo vệ bởi middleware "auth". 
authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);

    const verified = jwt.verify(token, process.env.JWT_SECRET);
    if (!verified) return res.json(false);

    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Get user data (protected route)
// CHỨC NĂNG ĐĂNG NHẬP, LẤY DỮ LIỆU NGƯỜI DÙNG (route được bảo vệ).
authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

export default authRouter;
 
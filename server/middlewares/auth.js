import jwt from "jsonwebtoken";

const auth = async (req, res, next) => {
  try {
    // Lấy token từ header
    const token = req.header("x-auth-token");
    if (!token)
      return res.status(401).json({ msg: "No auth token, access denied." });

    // Xác minh token
    const verified = jwt.verify(token, "passwordKey");
    if (!verified)
      return res
        .status(401)
        .json({ msg: "Token verification failed, authorization denied." });

    // Gắn thông tin người dùng vào req
    req.user = verified.id;
    req.token = token;

    next(); // Chuyển tiếp đến middleware tiếp theo
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default auth;

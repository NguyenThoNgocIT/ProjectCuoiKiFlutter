import jwt from"jsonwebtoken";
//// xử lí token để đăng nhập vào trang web được đây 
const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res.status(401).json({ msg: "No auth token, access denied" });
/// nếu token không tồn tại thì trả về lỗi 401 và thông báo "No auth token, access denied"
    const verified = jwt.verify(token, "passwordKey");
    if (!verified)
      return res
        .status(401)
        .json({ msg: "Token verification failed, authorization denied." });
/// nếu token đúng thì cho phép truy cập vào trang web
    req.user = verified.id;
    req.token = token;
    next();
    /// nếu token sai thì trả về lỗi 401 và thông báo "Token verification failed, authorization denied."
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
export default auth;
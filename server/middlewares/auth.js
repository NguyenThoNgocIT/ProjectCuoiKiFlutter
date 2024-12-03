import jwt from "jsonwebtoken";
// có chức năng kiểm tra và xác thực mã thông báo (token) trong các yêu cầu HTTP. Nó thường được 
// sử dụng trong các ứng dụng
//  web để bảo vệ các route yêu cầu người dùng phải được xác thực trước khi truy cập.
const auth = async (req, res, next) => {
  try {
    // Lấy token từ header ủy quyền của yêu cầu HTTP 
    const token = req.header("x-auth-token");
    if (!token)
      return res.status(401).json({ msg: "Không có mã token thông báo xác thực, quyền truy cập bị từ chối." });

    // Xác minh token
    const verified = jwt.verify(token, "passwordKey");
    if (!verified)
      return res
        .status(401)
        .json({ msg: "Xác minh mã token thông báo không thành công, ủy quyền bị từ chối." });

    // Gắn thông tin người dùng vào req
    req.user = verified.id;
    req.token = token;

    next(); // Chuyển tiếp đến middleware tiếp theo
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default auth;

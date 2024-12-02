import 'dart:convert';

import 'package:e_commerce_doancuoikingocit/constants/global_variables.dart';
import 'package:e_commerce_doancuoikingocit/models/user.dart';
import 'package:e_commerce_doancuoikingocit/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_doancuoikingocit/constants/error_handling.dart';
import 'package:e_commerce_doancuoikingocit/constants/utils.dart';
import 'package:e_commerce_doancuoikingocit/common/widgets/bottom_bar.dart';
import 'package:provider/provider.dart';// thêm depenencies pub.yaml chức năng cung cấp dữ liệu cho các widget con trong cây widget mà không 
//cần phải truyền dữ liệu qua từng cấp widget cha.
// CÓ THỂ TÁI SỬ DỤNG NHANH CHÓNG 

import 'package:http/http.dart' as http; //thêm dependencies pub.yaml

//Thư viện này được sử dụng để thực hiện các yêu cầu HTTP (GET, POST, PUT, DELETE, v.v.)
//Gửi yêu cầu HTTP tới các endpoint RESTful API.
// Xử lý phản hồi HTTP (response) từ các server.
// Hỗ trợ mã hóa và giải mã JSON.
import 'package:shared_preferences/shared_preferences.dart'; // thêm dependencies pub.yaml // chức năng để lưu trữ dữ liệu nhỏ và đơn giản trên thiết bị người dùng. 
//Dữ liệu được lưu trữ dưới dạng các cặp key-value, và có thể được truy cập và sử dụng trong toàn bộ ứng dụng.

class AuthService {
  // sign up user
  /// người dùng đăng ký tài khoản. Phương thức này sẽ gửi một yêu cầu POST tới API để tạo một tài khoản mới.
  /// Nếu tạo tài khoản thành công, phương thức sẽ hiển thị một thông báo thành công và chuyển hướng người dùng đến
  /// trang đăng nhập. Nếu có lỗi xảy ra, phương thức sẽ hiển thị một thông báo lỗi tương ứng.
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Tài khoản đã được tạo! Đăng nhập với thông tin tương tự!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  // phương thức để xử lý quá trình đăng nhập của người dùng. Nó sẽ gửi một yêu cầu POST
  //tới API để xác thực thông tin đăng nhập của người dùng. Nếu thông tin đăng nhập hợp lệ,
  //API sẽ trả về một token xác thực (authentication token) cho người dùng. Token này sẽ được lưu
  //trữ trong SharedPreferences để được sử dụng trong các yêu cầu API tiếp theo.
  //Sau khi đăng nhập thành công, người dùng sẽ được chuyển hướng đến trang chính của ứng dụng (BottomBar).
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  // lấy thông tin người dùng từ API và cập nhật vào trạng thái của ứng dụng bằng cách sử dụng Provider.
  //Để lấy thông tin người dùng, phương thức này sẽ gửi một yêu cầu GET tới API với token xác thực được
  // lưu trữ trong SharedPreferences. Sau khi nhận được phản hồi từ API, thông tin người dùng sẽ được giải mã
  //từ JSON và được cập nhật vào trạng thái của ứng dụng bằng cách gọi phương thức setUser của UserProvider.
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );
/// Đoạn mã trên là một phương thức getUserData trong một lớp UserProvider. Phương thức này sẽ thực hiện việc gửi một yêu cầu GET tới một API để lấy thông tin người dùng.
/// // Trước khi gửi yêu cầu, phương thức sẽ kiểm tra xem có token xác thực hay không. Nếu có, phương thức sẽ gửi token trong header của yêu cầu. 
/// //Sau khi nhận được phản hồi từ API, phương thức sẽ giải mã thông tin người dùng từ JSON và cập nhật vào trạng thái của ứng dụng bằng cách gọi phương thức setUser 
/// //của UserProvider. Nếu có lỗi xảy ra trong quá trình gửi yêu cầu hoặc giải mã thông tin người dùng, phương thức sẽ hiển thị thông báo lỗi bằng cách gọi phương 
/// thức showSnackBar.
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

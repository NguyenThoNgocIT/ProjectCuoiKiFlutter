import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool obscureText;  // Thêm tham số này để kiểm soát ẩn/hiện mật khẩu
  final String? Function(String?) validator;  // Thêm tham số validator

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1, 
    this.obscureText = false,  // Mặc định không ẩn text
    required this.validator,     // Cần truyền validator vào
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,  // Xử lý ẩn/hiện mật khẩu
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      // Sử dụng validator để kiểm tra hợp lệ
      validator: validator,
      maxLines: maxLines,
    );
  }
}

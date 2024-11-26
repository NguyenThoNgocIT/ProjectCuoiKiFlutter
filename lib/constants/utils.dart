// import 'dart:io';
// import 'package:file_picker/file_picker.dart';  // Thêm import cho FilePicker
// import 'package:flutter/material.dart';

// // Hàm để hiển thị SnackBar với thông báo
// void showSnackBar(BuildContext context, String text) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(text),
//     ),
//   );
// }

// // Hàm để chọn nhiều hình ảnh
// Future<List<File>> pickImages() async {
//   List<File> images = [];
//   try {
//     // Mở trình chọn file với tùy chọn chỉ chọn hình ảnh và cho phép chọn nhiều file
//     var files = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowMultiple: true,
//     );

//     // Kiểm tra nếu người dùng chọn file
//     if (files != null && files.files.isNotEmpty) {
//       // Duyệt qua danh sách các file đã chọn
//       for (int i = 0; i < files.files.length; i++) {
//         // Thêm file vào danh sách images
//         var filePath = files.files[i].path;
//         if (filePath != null) {
//           images.add(File(filePath));
//         }
//       }
//     } else {
//       // Trường hợp không có file nào được chọn
//       debugPrint('No files selected');
//     }
//   } catch (e) {
//     // In ra lỗi nếu có lỗi xảy ra trong quá trình chọn file
//     debugPrint('Error picking files: $e');
//   }
//   return images;
// }

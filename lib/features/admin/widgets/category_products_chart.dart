import 'package:e_commerce_doancuoikingocit/features/admin/models/sales.dart';
import 'package:flutter/material.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> salesData; // Đổi tên sang kiểu dữ liệu phù hợp
  const CategoryProductsChart({
    Key? key,
    required this.salesData, // Sử dụng salesData thay vì seriesList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: salesData.map((sales) {
        return ListTile(
          title: Text(sales.label),
          trailing: Text('\$${sales.earning}'),
        );
      }).toList(),
    );
  }
}

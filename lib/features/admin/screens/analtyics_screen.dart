import 'package:e_commerce_doancuoikingocit/common/widgets/loader.dart';
import 'package:e_commerce_doancuoikingocit/features/admin/models/sales.dart';
import 'package:e_commerce_doancuoikingocit/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                '\$$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Hiển thị dữ liệu dưới dạng danh sách
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: earnings?.length ?? 0,
                  itemBuilder: (context, index) {
                    final sales = earnings![index];
                    return ListTile(
                      title: Text(sales.label),
                      trailing: Text('\$${sales.earning}'),
                    );
                  },
                ),
              ),
            ],
          );
  }
}

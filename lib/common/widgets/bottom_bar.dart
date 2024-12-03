import 'package:e_commerce_doancuoikingocit/constants/global_variables.dart';
import 'package:e_commerce_doancuoikingocit/features/account/screens/account_screen.dart';
import 'package:e_commerce_doancuoikingocit/features/cart/screens/cart_screen.dart';
import 'package:e_commerce_doancuoikingocit/features/home/screens/home_screen.dart';
import 'package:e_commerce_doancuoikingocit/providers/user_provider.dart'; //thêm dependency: provider: ^6.0.5 trong file pubspec.yaml
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; //thêm dependency: provider: ^6.0.5 trong file pubspec.yaml
import 'package:badges/badges.dart'
    as badges; //thêm dependency: badges: ^3.0.2 trong file pubspec.yaml

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  // chức năng chuyển trang
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.person_outline_outlined,
              ),
            ),
            label: '',
          ),
          // CART
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              // Để hiển thị biểu tượng giỏ hàng với số lượng sản phẩm trong giỏ
              child: badges.Badge(
                badgeContent: Text(
                  userCartLen.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
                badgeColor: Colors
                    .white, // Chỉnh sửa tại đây, không cần dùng BadgeStyle nữa
                elevation: 0, // Đảm bảo không có hiệu ứng đổ bóng
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

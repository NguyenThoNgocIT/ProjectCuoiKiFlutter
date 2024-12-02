import 'package:e_commerce_doancuoikingocit/constants/global_variables.dart';
import 'package:e_commerce_doancuoikingocit/features/screens/auth_screens.dart';
import 'package:e_commerce_doancuoikingocit/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,

          /// đây là màu nền của trang đã đc setup trong file tĩnh
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
              elevation: 0, iconTheme: IconThemeData(color: Colors.black))),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Hello"),
        ),
        body: Column(
          children: [ 
            const  Center(
              child: const Text("Flutter"),
            ),
            Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AuthScreens.routeName);
                  },
                  child: Text("Click"),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}

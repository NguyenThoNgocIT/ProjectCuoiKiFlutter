import 'package:e_commerce_doancuoikingocit/constants/global_variables.dart';
import 'package:e_commerce_doancuoikingocit/features/auth/screens/auth_screen.dart';
import 'package:e_commerce_doancuoikingocit/features/auth/service/auth_service.dart';
import 'package:e_commerce_doancuoikingocit/models/user.dart';
import 'package:e_commerce_doancuoikingocit/providers/user_provider.dart';
import 'package:e_commerce_doancuoikingocit/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create:(context)=>
      UserProvider(),
    ),
  ], child: const MyApp()));

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();

  void initState(){
    super.initState();
  }
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
            const Center(
              child: const Text("Flutter"),
            ),
            Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AuthScreen.routeName);
                },
                child: Text("Click"),
              );
            }),
          ],
        ),
      ),
    );
  }
}

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/feature/admin/screen/admin_screen.dart';
import 'package:amazon_clone/feature/auth/screens/auth_screen.dart';
import 'package:amazon_clone/feature/auth/services/auth_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/routes.dart';
import 'package:amazon_clone/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Amazon Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        textTheme: GoogleFonts.poppinsTextTheme(textTheme),
        // .copyWith(
        //     bodyMedium: GoogleFonts.poppins(textStyle: textTheme.bodyMedium)),
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 4, 83, 148),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      onGenerateRoute: (settings) => generateRoutes(settings),
      home: const SplashScreen(),
      // Provider.of<UserProvider>(context).user.token.isNotEmpty
      //     ? Provider.of<UserProvider>(context).user.type == 'User'
      //         ? const BottomBar()
      //         : const AdminScreen()
      //     : const AuthScreen(),
    );
  }
}

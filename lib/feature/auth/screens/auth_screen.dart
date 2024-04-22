import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_field.dart';
import 'package:amazon_clone/feature/auth/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  List<String> socialMediaLogo = [
    "https://play-lh.googleusercontent.com/U202Yto9o6IT1ZA8bgigA5q4nIzvu0S9ztl2d0WQSj6Iw0hIw5W7SIAnH0U2-Kk3nao",
    "https://as1.ftcdn.net/v2/jpg/03/88/07/84/500_F_388078454_mKtbdXYF9cyQovCCTsjqI0gbfu7gCcSp.jpg",
    "https://static.vecteezy.com/system/resources/thumbnails/031/737/227/small/twitter-new-logo-twitter-icons-new-twitter-logo-x-2023-x-social-media-icon-free-png.png"
  ];

  void SignUpUser() {
    authService.signUpUser(
      email: _emailController.text,
      name: _nameController.text,
      context: context,
      password: _passwordController.text,
    );
  }

  void SignInUser() {
    authService.signInUser(
      email: _emailController.text,
      context: context,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _auth == Auth.signup
                ? const SizedBox(
                    width: double.maxFinite,
                    height: 100,
                  )
                : const SizedBox(
                    width: double.maxFinite,
                    height: 120,
                  ),
            _auth == Auth.signup
                ? Column(
                    children: [
                      "Create Account"
                          .text
                          .fontWeight(FontWeight.w500)
                          .size(35)
                          .color(Colors.black)
                          .make()
                          .centered()
                          .px(23),
                      const SizedBox(
                        height: 12,
                      ),
                      "Fill your information below."
                          .text
                          .size(16)
                          .color(
                            Colors.black45,
                          )
                          .make()
                          .px(23)
                          .centered(),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  )
                : Container(),
            if (_auth == Auth.signup)
              Form(
                key: _signUpFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Username".text.size(16).make().px32(),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                            controller: _nameController, text: "Abu Bakar")
                        .px(18),
                    const SizedBox(
                      height: 13,
                    ),
                    "Email".text.size(16).make().px32(),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                            controller: _emailController,
                            text: "example@gmail.com")
                        .px(18),
                    const SizedBox(
                      height: 13,
                    ),
                    "Password".text.size(16).make().px32(),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                            isTrue: true,
                            controller: _passwordController,
                            text: "*********")
                        .px(18),
                    const SizedBox(
                      height: 45,
                    ),
                    CustomButton(
                      color: const Color.fromARGB(255, 4, 83, 148),
                      text: "Sign up",
                      onTap: () {
                        if (_signUpFormKey.currentState!.validate()) {
                          SignUpUser();
                        }
                      },
                    ).px(18),
                  ],
                ),
              ),
            _auth == Auth.signin
                ? Column(
                    children: [
                      "Sign In"
                          .text
                          .fontWeight(FontWeight.w500)
                          .size(35)
                          .color(Colors.black)
                          .make()
                          .centered()
                          .px(23),
                      const SizedBox(
                        height: 12,
                      ),
                      "Hi! Welcome back, you've been missed"
                          .text
                          .size(16)
                          .color(
                            Colors.black45,
                          )
                          .make()
                          .px(23)
                          .centered(),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  )
                : Container(),
            if (_auth == Auth.signin)
              Form(
                key: _signInFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Email".text.size(16).make().px32(),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                            controller: _emailController,
                            text: "example@gmail.com")
                        .px(18),
                    const SizedBox(
                      height: 20,
                    ),
                    "Password".text.size(16).make().px32(),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                            isTrue: true,
                            controller: _passwordController,
                            text: "*********")
                        .px(18),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: double.maxFinite,
                      margin:
                          const EdgeInsetsDirectional.symmetric(horizontal: 25),
                      child: const Text(
                        "Forgot Password",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    CustomButton(
                        color: const Color.fromARGB(255, 4, 83, 148),
                        text: "Log in",
                        onTap: () {
                          if (_signInFormKey.currentState!.validate()) {
                            SignInUser();
                          }
                        }).px(18),
                  ],
                ),
              ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: double.maxFinite,
              margin: const EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  Container(
                    height: 2,
                    width: 100,
                    color: Colors.black26,
                  ),
                  " Or sign in with ".text.make(),
                  Container(
                    height: 2,
                    width: 100,
                    color: Colors.black26,
                  ),
                ],
              ).centered(),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Wrap(
                children: List.generate(3, (index) {
                  return CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(socialMediaLogo[index]),
                  ).px16();
                }),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                _auth == Auth.signin
                    ? "Dont have an account? ".text.make().pOnly(left: 32)
                    : "Already have an account? ".text.make().pOnly(left: 32),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_auth == Auth.signup) {
                        _auth = Auth.signin;
                      } else {
                        _auth = Auth.signup;
                      }
                    });
                  },
                  child: _auth == Auth.signin
                      ? "Sign Up"
                          .text
                          .size(16)
                          .color(
                            Colors.black,
                          )
                          .underline
                          .bold
                          .make()
                      : "Log In"
                          .text
                          .size(16)
                          .color(
                            Colors.black,
                          )
                          .underline
                          .bold
                          .make(),
                )
              ],
            ).px(context.screenWidth / 7),
          ],
        ),
      ),
    );
  }
}

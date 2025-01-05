import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_interface/core/functions.dart';
import 'package:shopping_app_interface/core/strings.dart';
import 'package:shopping_app_interface/feature/shopping_screen/shopping_main_screen.dart';
import 'package:shopping_app_interface/feature/signup/widgets/custom_button.dart';
import 'package:shopping_app_interface/feature/signup/widgets/custom_icon_button.dart';
import 'package:shopping_app_interface/feature/signup/widgets/custom_logo.dart';
import 'package:shopping_app_interface/feature/signup/widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordVerifyController = TextEditingController();

  // using ValueNotifier to avoid rebuilding the whole screen just for password visibility.
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  void _tooglePasswordVisability() {
    _obscurePassword.value = !_obscurePassword.value;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordVerifyController.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Had to use pushReplacement instead of push here because the back button was messing up the flow >-< :(
      // منه لله فضلت ادور عليها ساعة :)
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing by tapping outside
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(tr('dialog_headline')),
            content: Text(tr('dialog_content')),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss dialog
                  FocusScope.of(context)
                      .unfocus(); // dissmiss Keyboared (for somehow keyboared show )

                  Navigator.pushReplacement(
                    context,
                    // Using a custom page route to add a fade transition
                    PageRouteBuilder(
                      //  pageBuilder for defining the target page and transitionsBuilder for specifying the animation.
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const MyHomePage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Text(tr('dialog_button')),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Language Selector Popup Menu
          PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      value: 'en',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image(
                              image: AssetImage('assets/images/us.png'),
                              width: 30,
                              height: 30),
                          Text(
                            'English',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )),
                  PopupMenuItem(
                      value: 'ar',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image(
                              image: AssetImage('assets/images/eg.png'),
                              width: 30,
                              height: 30),
                          Text(
                            ' العربية ',
                            style: TextStyle(fontSize: 23),
                          ),
                        ],
                      )),
                ];
              },
              icon: Icon(Icons.language),
              onSelected: (String value) {
                if (value == 'en') {
                  context.setLocale(Locale('en', 'US'));
                } else {
                  context.setLocale(Locale('ar', 'EG'));
                }
              }),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // using 4:1 ratio keeps the logo from taking too much space on smaller screens
            const Expanded(flex: 1, child: CustomLogo()),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            tr('create_account'),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CustomTextField(
                            controller: _usernameController,
                            labelText: tr('username'),
                            validator: validateUsername,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CustomTextField(
                            controller: _emailController,
                            labelText: tr('email'),
                            validator: validateEmail,
                          ),
                        ),
                        //Using ValueListenableBuilder to handle both password fields with one listener
                        ValueListenableBuilder(
                            valueListenable: _obscurePassword,
                            builder: (context, value, child) {
                              return CustomTextField(
                                controller: _passwordController,
                                obscureText: value,
                                labelText: tr('password'),
                                suffixIcon: IconButton(
                                  onPressed: _tooglePasswordVisability,
                                  icon: Icon(
                                    value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                validator: validatePassword,
                              );
                            }),
                        ValueListenableBuilder(
                            valueListenable: _obscurePassword,
                            builder: (context, value, child) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: CustomTextField(
                                  controller: _passwordVerifyController,
                                  obscureText: value,
                                  labelText: tr('confirm_password'),
                                  suffixIcon: IconButton(
                                    onPressed: _tooglePasswordVisability,
                                    icon: Icon(
                                      value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  validator: (value) => confirmPassword(
                                      _passwordController, value),
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomButtonWidget(
                            buttonText: tr('sign_up'), onPressed: _submit),
                        const SizedBox(height: 20),
                        // added a divider and social media icons
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                indent:
                                    35, // i had to make it shorter from the left for better design
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                tr('or'),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                endIndent: 35, // shorten it from the right
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomIconWidget(
                                  onTap: () {},
                                  iconPath: AppStrings.googleLogo),
                              CustomIconWidget(
                                  onTap: () {},
                                  iconPath: AppStrings.facebookLogo),
                              CustomIconWidget(
                                  onTap: () {},
                                  iconPath: AppStrings.twitterLogo),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

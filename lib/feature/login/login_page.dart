import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_interface/core/functions.dart';
import 'package:shopping_app_interface/core/strings.dart';
import 'package:shopping_app_interface/core/widgets/language_menu.dart';
import 'package:shopping_app_interface/feature/shopping_screen/shopping_main_screen.dart';
import 'package:shopping_app_interface/feature/signup/signup_page.dart';
import 'package:shopping_app_interface/feature/signup/widgets/custom_button.dart';
import 'package:shopping_app_interface/feature/signup/widgets/custom_icon_button.dart';
import 'package:shopping_app_interface/feature/signup/widgets/custom_logo.dart';
import 'package:shopping_app_interface/feature/signup/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // using ValueNotifier to avoid rebuilding the whole screen just for password visibility.
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  void _tooglePasswordVisability() {
    _obscurePassword.value = !_obscurePassword.value;
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        _isLoading.value = true;
        await signIn();
      } on FirebaseAuthException catch (e) {
        checkRegisteration(e);
      } catch (e) {
        log(e.toString());
      }
    }
    _isLoading.value = false;
  }

  void checkRegisteration(FirebaseAuthException e) {
    if (e.code == 'user-not-found') {
      showSnackBar(context, tr('user_not_found'));
      log(tr('user_not_found'));
    } else if (e.code == 'wrong-password') {
      showSnackBar(context, tr('wrong_password'));
      log(tr('wrong_password'));
    }
  }

  Future<void> signIn() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    if (userCredential.user != null) {
      log('User created successfully ${userCredential.user!.uid}');
      showSnackBar(context, tr('login_success'));
      Navigator.of(context).pushReplacement(
        // Using a custom page route to add a fade transition
        PageRouteBuilder(
          //  pageBuilder for defining the target page and transitionsBuilder for specifying the animation.
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MyHomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _obscurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Language Selector Popup Menu
          LangageMenu(
            screenContext: context,
          ),
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
                            tr('sign_in'),
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                        const SizedBox(
                          height: 25,
                        ),
                        ValueListenableBuilder(
                            valueListenable: _isLoading,
                            builder: (context, value, child) {
                              if (value) {
                                return CircularProgressIndicator();
                              } else {
                                return CustomButtonWidget(
                                    buttonText: tr('sign_in'),
                                    onPressed: _submit);
                              }
                            }),
                        // added a divider and social media icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(tr('dont_have_account')),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  // Using a custom page route to add a fade transition
                                  PageRouteBuilder(
                                    //  pageBuilder for defining the target page and transitionsBuilder for specifying the animation.
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const SignupScreen(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                    transitionDuration:
                                        const Duration(seconds: 1),
                                  ),
                                );
                              },
                              child: Text(tr('sign_up'),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            )
                          ],
                        ),
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

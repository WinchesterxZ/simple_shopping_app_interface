import 'package:flutter/material.dart';
import 'package:shopping_app_interface/core/functions.dart';
import 'package:shopping_app_interface/core/strings.dart';
import 'package:shopping_app_interface/features/shopping_screen/shopping_main_screen.dart';
import 'package:shopping_app_interface/features/signup/widgets/custom_button.dart';
import 'package:shopping_app_interface/features/signup/widgets/custom_icon_button.dart';
import 'package:shopping_app_interface/features/signup/widgets/custom_logo.dart';
import 'package:shopping_app_interface/features/signup/widgets/custom_text_field.dart';

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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Had to use pushReplacement instead of push here because the back button was messing up the flow >-< :(
      // منه لله فضلت ادور عليها ساعة :)
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing by tapping outside
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Account created successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ),
                  );
                },
                child: const Text('OK'),
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
                        const Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            'Create An account',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CustomTextField(
                            controller: _usernameController,
                            labelText: 'Username',
                            validator: validateUsername,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CustomTextField(
                            controller: _emailController,
                            labelText: 'Email',
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
                                labelText: 'Password',
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
                                  labelText: 'Confirm Password',
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
                            buttonText: 'Sign Up', onPressed: _submit),
                        const SizedBox(height: 20),
                        // added a divider and social media icons
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                indent: 35,  // i had to make it shorter from the left for better design
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Or",
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

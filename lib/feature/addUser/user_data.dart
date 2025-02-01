import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_interface/core/functions.dart';
import 'package:shopping_app_interface/core/widgets/language_menu.dart';
import 'package:shopping_app_interface/feature/addUser/widgets/custom_button.dart';
import 'package:shopping_app_interface/feature/addUser/widgets/custom_logo.dart';
import 'package:shopping_app_interface/feature/addUser/widgets/custom_text_field.dart';
import 'package:shopping_app_interface/feature/displayData/display_user.dart';
import 'package:shopping_app_interface/firebase_user_model.dart'; // Add this import

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _favoriteHobbyController = TextEditingController();

  // using ValueNotifier to avoid rebuilding the whole screen just for password visibility.
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isLoading.dispose(); // Add this line to dispose the ValueNotifier
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _favoriteHobbyController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        _isLoading.value = true;
        var db = FirebaseFirestore.instance;

        // Create UserModel instance
        final user = UserModel(
          name: _nameController.text,
          age: _ageController.text,
          phone: _phoneController.text,
          favoriteHobby: _favoriteHobbyController.text,
        );

        var doc = await db.collection('Users').add(user.toJson());

        if (doc.id.isNotEmpty) {
          _formKey.currentState!.reset();
          showSnackBar(context, tr('user_added'));
          _isLoading.value = false;
        }
      } catch (e) {
        log(e.toString());
        _isLoading.value = false;
      }
    }
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
                            tr('user_info'),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CustomTextField(
                            controller: _nameController,
                            labelText: tr('name'),
                            validator: validateUserDate,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CustomTextField(
                            controller: _ageController,
                            labelText: tr('age'),
                            validator: validateAge,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        //Using ValueListenableBuilder to handle both password fields with one listener
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: CustomTextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            labelText: tr('phone'),
                            validator: validatePhoneNuber,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: CustomTextField(
                            controller: _favoriteHobbyController,
                            keyboardType: TextInputType.text,
                            labelText: tr('fav_hobby'),
                            validator: validateUserDate,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ValueListenableBuilder<bool>(
                                valueListenable: _isLoading,
                                builder: (context, isLoading, child) {
                                  return isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : CustomButtonWidget(
                                          buttonText: tr('save'),
                                          onPressed: _submit,
                                        );
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomButtonWidget(
                                    buttonText: tr('display_user_info'),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const UserRealTimeDisplay(),
                                        ),
                                      );
                                    }),
                              ),
                            )
                          ],
                        )
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

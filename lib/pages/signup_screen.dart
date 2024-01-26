import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_foodhub/api_connection/network_api_services.dart';
import 'package:my_foodhub/models/user_model.dart';

import '../api_connection/api_connection.dart';
import '../utilities/constants.dart';

import 'package:http/http.dart' as http;

import '../utilities/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  validateEmail() async {


  NetworkApiServices().postApi(emailController.text.trim(),API.validateEmail);
  //   try {
  //   var res =   await http.post(
  //         Uri.parse(API.validateEmail),
  //         body: {
  //           'user_email': emailController.text.trim(),
  //         }
  //     );
  //
  //   if(res.statusCode ==200){
  //     var resbody = jsonDecode(res.body);
  //
  //     if(resbody['success']){
  //      Utils().showToast("Email is already in used.",true);
  //     }else{
  //       Utils().showToast("Email is valid.",true);
  //
  //       registerAndSaveUser();
  //     }
  //
  //   }else{
  //     Utils().showToast("Error",true);
  //   }
  //   } catch (e) {
  //     Utils().showToast("$e",true);
  //   }
  }

  registerAndSaveUser() async {

    UserModel userModel = UserModel(id: 1, name: nameController.text.trim(), email: emailController.text.trim(), password: passwordController.text.trim());

    try {
      var res =   await http.post(
          Uri.parse(API.signup),
          body: userModel.toJson(),
      );

      if(res.statusCode ==200){
        var resbody = jsonDecode(res.body);

        if(resbody['success']){
          Utils().showToast("User Saved.",true);
        }else{
          Utils().showToast("Please try again",true);
        }

      }else{
        Utils().showToast("Error",true);
      }
    } catch (e) {
      Utils().showToast("$e",true);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroungColor,
      body: LayoutBuilder(
        builder: (context, cons) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: cons.maxHeight,
            ),
            child: SingleChildScrollView(
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: 150,),

                  SizedBox(
                    width: 120,
                    height: 75,
                    child: Image.asset(
                        "assets/images/login_logo.jpg"
                    ),
                  ),

                  SizedBox(height: 24,),

                  const Text(
                    "SignUp In To Continue",
                    style: TextStyle(
                      color: AppColors.themeBlackTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),


                  //login screen sign in part
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      child: Column(
                        children: [
                          // email password and login btn
                          Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                              child: Column(
                                children: [


                                  TextFormField(
                                    controller: nameController,
                                    validator: (val) =>
                                    val == ""
                                        ? "Please write email"
                                        : null,
                                    decoration: InputDecoration(
                                      hintText: "John_doe98",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              16),
                                          borderSide: const BorderSide(
                                            color: AppColors
                                                .textFieldBackgroundCommonColor,
                                          )
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              16),
                                          borderSide: const BorderSide(
                                            color: AppColors
                                                .textFieldBackgroundCommonColor,
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              16),
                                          borderSide: const BorderSide(
                                            color: AppColors
                                                .textFieldBackgroundCommonColor,
                                          )
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              16),
                                          borderSide: const BorderSide(
                                            color: AppColors
                                                .textFieldBackgroundCommonColor,
                                          )
                                      ),
                                      contentPadding: const EdgeInsets
                                          .symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: AppColors
                                          .textFieldBackgroundCommonColor,
                                      filled: true,
                                    ),
                                  ),
                                  const SizedBox(height: 16,),
                                  TextFormField(
                                    controller: emailController,
                                    validator: (val) =>
                                    val == ""
                                        ? "Please write email"
                                        : null,
                                    decoration: InputDecoration(
                                      hintText: "John_doe98",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              16),
                                          borderSide: const BorderSide(
                                            color: AppColors
                                                .textFieldBackgroundCommonColor,
                                          )
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              16),
                                          borderSide: const BorderSide(
                                            color: AppColors
                                                .textFieldBackgroundCommonColor,
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              16),
                                          borderSide: const BorderSide(
                                            color: AppColors
                                                .textFieldBackgroundCommonColor,
                                          )
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              16),
                                          borderSide: const BorderSide(
                                            color: AppColors
                                                .textFieldBackgroundCommonColor,
                                          )
                                      ),
                                      contentPadding: const EdgeInsets
                                          .symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: AppColors
                                          .textFieldBackgroundCommonColor,
                                      filled: true,
                                    ),
                                  ),

                                  const SizedBox(height: 16,),

                                  Obx(() =>
                                      TextFormField(
                                        controller: passwordController,
                                        obscureText: isObsecure.value,
                                        validator: (val) =>
                                        val == ""
                                            ? "Please write password"
                                            : null,
                                        decoration: InputDecoration(
                                          suffixIcon: Obx(
                                                () =>
                                                GestureDetector(
                                                  onTap: () {
                                                    isObsecure.value =
                                                    !isObsecure.value;
                                                  },
                                                  child: Icon(
                                                    isObsecure.value ? Icons
                                                        .visibility_off : Icons
                                                        .visibility,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                          ),
                                          hintText: "*******",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(16),
                                              borderSide: const BorderSide(
                                                color: AppColors
                                                    .textFieldBackgroundCommonColor,
                                              )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(16),
                                              borderSide: const BorderSide(
                                                color: AppColors
                                                    .textFieldBackgroundCommonColor,
                                              )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(16),
                                              borderSide: const BorderSide(
                                                color: AppColors
                                                    .textFieldBackgroundCommonColor,
                                              )
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(16),
                                              borderSide: const BorderSide(
                                                color: AppColors
                                                    .textFieldBackgroundCommonColor,
                                              )
                                          ),
                                          contentPadding: const EdgeInsets
                                              .symmetric(
                                            horizontal: 14,
                                            vertical: 6,
                                          ),
                                          fillColor: AppColors
                                              .textFieldBackgroundCommonColor,
                                          filled: true,
                                        ),
                                      ),),

                                  const SizedBox(height: 18,),

                                  InkWell(
                                    onTap: () {
                                     // Utils().showToast("Email checking",true);
                                      validateEmail();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 48,
                                      width: 162,
                                      decoration: BoxDecoration(
                                        color: AppColors.themeBlueButtonColor,
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child:  Text(
                                        'sign_up'.tr,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //button
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16,),
                          //don't have account btn here


                          const SizedBox(height: 75,),

                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: AppColors.themeGrayTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 8,),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 48,
                              width: 100,
                              decoration: BoxDecoration(
                                color: AppColors.themeLightPurpleButtonColor,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: AppColors.themeBlueTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

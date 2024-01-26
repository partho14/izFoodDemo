
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_foodhub/pages/signup_screen.dart';

import '../utilities/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroungColor,
      body: LayoutBuilder(
        builder: (context, cons)
        {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: cons.maxHeight,
            ),
            child: SingleChildScrollView(
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // login screen header image part
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 285.h,
                      child: Image.asset(
                        "assets/images/login_image.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 32,),

                  SizedBox(
                    width: 120,
                    height: 75,
                    child: Image.asset(
                        "assets/images/login_logo.jpg"
                    ),
                  ),

                  SizedBox(height: 24,),

                  const Text(
                    "Log In To Continue",
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
                                    controller: emailController,
                                    validator: (val) => val == "" ? "Please write email" : null,
                                    decoration: InputDecoration(
                                      hintText: "John_doe98",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                          color: AppColors.textFieldBackgroundCommonColor,
                                        )
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                            color: AppColors.textFieldBackgroundCommonColor,
                                          )
                                      ),
                                      focusedBorder:  OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                            color: AppColors.textFieldBackgroundCommonColor,
                                          )
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                            color: AppColors.textFieldBackgroundCommonColor,
                                          )
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: AppColors.textFieldBackgroundCommonColor,
                                      filled: true,
                                    ),
                                  ),

                                  const SizedBox(height: 16,),

                                 Obx(() =>  TextFormField(
                                   controller: passwordController,
                                   obscureText: isObsecure.value,
                                   validator: (val) => val == "" ? "Please write password" : null,
                                   decoration: InputDecoration(
                                     suffixIcon: Obx(
                                           ()=> GestureDetector(
                                         onTap: (){
                                           isObsecure.value = !isObsecure.value;
                                         },
                                         child: Icon(
                                           isObsecure.value ? Icons.visibility_off : Icons.visibility,
                                           color: Colors.black,
                                         ),
                                       ),
                                     ),
                                     hintText: "*******",
                                     border: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(16),
                                         borderSide: const BorderSide(
                                           color: AppColors.textFieldBackgroundCommonColor,
                                         )
                                     ),
                                     enabledBorder: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(16),
                                         borderSide: const BorderSide(
                                           color: AppColors.textFieldBackgroundCommonColor,
                                         )
                                     ),
                                     focusedBorder:  OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(16),
                                         borderSide: const BorderSide(
                                           color: AppColors.textFieldBackgroundCommonColor,
                                         )
                                     ),
                                     disabledBorder: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(16),
                                         borderSide: const BorderSide(
                                           color: AppColors.textFieldBackgroundCommonColor,
                                         )
                                     ),
                                     contentPadding: const EdgeInsets.symmetric(
                                       horizontal: 14,
                                       vertical: 6,
                                     ),
                                     fillColor: AppColors.textFieldBackgroundCommonColor,
                                     filled: true,
                                   ),
                                 ),),

                                  const SizedBox(height: 18,),

                                  InkWell(
                                    onTap: (){

                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 48,
                                      width: 162,
                                      decoration: BoxDecoration(
                                        color: AppColors.themeBlueButtonColor,
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: const Text(
                                        "Log In",
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

                          InkWell(
                            onTap: (){

                            },
                            child: const Text(
                              "Forgot Password",
                              style: TextStyle(
                                color: AppColors.themeBlueTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          const SizedBox(height: 75,),

                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: AppColors.themeGrayTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 8,),
                          InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => SignupScreen()));
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
                                "Register",
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

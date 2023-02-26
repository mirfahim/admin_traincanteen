import 'package:admin_traincanteen/screen/auth/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';
import '../../utils/helper.dart';
import '../../widgets/customTextInput.dart';


class SignUpScreen extends StatefulWidget {
  static const routeName = '/signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  CollectionReference trainCanteen = FirebaseFirestore.instance.collection('traincanteen');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: Helper.getScreenWidth(context),
          height: Helper.getScreenHeight(context),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(
                children: [
                  Text(
                    "Sign Up",
                    style: Helper.getTheme(context).headline6,
                  ),
                  Spacer(),
                  Text(
                    "Add your details to sign up",
                  ),
                  Spacer(),
                  CustomTextInput(
                      textController: nameController,
                      hintText: "Name"),
                  Spacer(),
                  CustomTextInput(
                      textController: emailController,
                      hintText: "Email"),
                  Spacer(),
                  CustomTextInput(
                      textController: mobileController,
                      hintText: "Mobile No"),
                  Spacer(),
                  CustomTextInput(
                      textController: addressController,
                      hintText: "Address"),
                  Spacer(),
                  CustomTextInput(
                      textController: passController,
                      hintText: "Password"),
                  Spacer(),
                  CustomTextInput(
                      textController: confirmPassController,
                      hintText: "Confirm Password"),
                  Spacer(),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        trainCanteen.doc("9dP3oajtd2Q7JWoqAAd7").collection("registration").add(
                            {
                              "name": nameController.text,
                              "email": emailController.text,
                              "mobile": mobileController.text,
                              "address": addressController.text,
                              "pass": passController.text,


                            });
                      },
                      child: Text("Sign Up"),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an Account?"),
                        Text(
                          "Login",
                          style: TextStyle(
                            color: AppColor.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

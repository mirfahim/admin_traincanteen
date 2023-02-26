import 'dart:io';

import 'package:admin_traincanteen/screen/auth/sign_up_screen.dart';

import 'package:admin_traincanteen/widgets/customTextInput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:admin_traincanteen/screen/homeScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';

import '../../const/colors.dart';
import '../../utils/helper.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  CollectionReference trainCanteen = FirebaseFirestore.instance.collection('traincanteen');
  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final picker = ImagePicker();
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<bool> doesMobileAlreadyExist(String name) async {
    print("+++ $name");
    final QuerySnapshot result = await trainCanteen.doc("9dP3oajtd2Q7JWoqAAd7").collection("registration")
        .where('mobile', isEqualTo: name)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.length == 1;
  }
  Future<bool> doesPassAlreadyExist(String pass) async {
    print("+++ $pass");
    final QuerySnapshot result = await trainCanteen.doc("9dP3oajtd2Q7JWoqAAd7").collection("registration")
        .where('pass', isEqualTo: pass)
        .limit(1)
        .get();

    final List<DocumentSnapshot> documents = result.docs;
    return documents.length == 1;
  }
  imagePicker() async {


    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final file = File(pickedFile!.path);
    final fileName = file.path;

    uploadImage(fileName, file);



  }

  uploadImage(fileName, file) async{
    final Reference storageRef = storage.ref();
    final Reference ref = storageRef.child('images/$fileName');
    final TaskSnapshot task = await ref.putFile(file);



    final String downloadUrl = await task.ref.getDownloadURL();
    print("my dowbload url ++++ $downloadUrl");
  }

  /////////



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Helper.getScreenHeight(context),
        width: Helper.getScreenWidth(context),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 30,
            ),
            child: Column(
              children: [
                Text(
                  "Login",
                  style: Helper.getTheme(context).headline6,
                ),
                Spacer(),
                Text('Add your details to login'),
                Spacer(),
                CustomTextInput(
                  textController: mobileController,
                  hintText: "Your mobile",
                ),
                Spacer(),
                CustomTextInput(
                  textController: passController ,
                  hintText: "password",
                ),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      print("login started");
                      doesMobileAlreadyExist(mobileController.text).then((value) {

                        if(value == true){
                          doesPassAlreadyExist(passController.text).then((pass) {
                            if(pass == true){

                              Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(

                                  builder: (BuildContext context) => HomeScreen(),
                                ),
                                    (route) => false,//if you want to disable back feature set to false
                              );
                            }else {
                              print("login pass error");
                            }
                          });

                        } else {
                          print("login error");
                        }
                      });


                    },
                    child: Text("Login"),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {


                  },
                  child: Text("Forget your password?"),
                ),
                Spacer(
                  flex: 2,
                ),
                Text("or Login With"),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(
                          0xFF367FC0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      imagePicker();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Helper.getAssetName(
                            "fb.png",
                            "virtual",
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("Login with Facebook")
                      ],
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(
                          0xFFDD4B39,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Helper.getAssetName(
                            "google.png",
                            "virtual",
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("Login with Google")
                      ],
                    ),
                  ),
                ),
                Spacer(
                  flex: 4,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(SignUpScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an Account?"),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppColor.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}

import 'dart:io';

import 'package:admin_traincanteen/screen/add_restaurant/restaurant_list.dart';
import 'package:admin_traincanteen/screen/auth/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../const/colors.dart';
import '../../utils/helper.dart';
import '../../widgets/customTextInput.dart';


class AddRestaurant extends StatefulWidget {
  static const routeName = '/signUpScreen';

  @override
  State<AddRestaurant> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<AddRestaurant> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool loading = false;
  TextEditingController passController = TextEditingController();
 List<String> popular = ["yes", "not"];
 String? selectedPopular;
   String? downloadUrl ;
  TextEditingController confirmPassController = TextEditingController();
  CollectionReference trainCanteen = FirebaseFirestore.instance.collection('traincanteen');
  final picker = ImagePicker();
  File? imagefile;
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
    imagefile = file;
    final fileName = file.path;

    uploadImage(fileName, file);
    print("my dowbload url ++++ $downloadUrl");
return imagefile ;

  }

  uploadImage(fileName, file) async{
    final Reference storageRef = storage.ref();
    final Reference ref = storageRef.child('images/$fileName');
    final TaskSnapshot task = await ref.putFile(file);



    downloadUrl = await task.ref.getDownloadURL();

  }
  @override
  Widget build(BuildContext context) {
    selectedPopular = popular[0];
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Restaurant"),
      ),
        body: SingleChildScrollView(
          child: Container(
            width: Helper.getScreenWidth(context),
            height: Helper.getScreenHeight(context),
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Text(
                      "Add Restaurant Name",
                    ),
                    CustomTextInput(
                        textController: nameController,
                        hintText: "Restaurant Name"),
                    Spacer(),
                    Text(
                      "Email",
                      style: Helper.getTheme(context).bodySmall,
                    ),
                    CustomTextInput(
                        textController: emailController,
                        hintText: "Email"),
                    Spacer(),
                    Text(
                      "Mobile No",
                      style: Helper.getTheme(context).bodySmall,
                    ),
                    CustomTextInput(
                        textController: mobileController,
                        hintText: "Mobile No"),
                    Spacer(),
                    Text(
                      "Address",
                      style: Helper.getTheme(context).bodySmall,
                    ),
                    CustomTextInput(
                        textController: addressController,
                        hintText: "Address"),
                    Spacer(),
                    Text(
                      "Station Name",
                      style: Helper.getTheme(context).bodySmall,
                    ),
                    CustomTextInput(
                        textController: addressController,
                        hintText: "Station Name"),
                    Spacer(),
                    Text(
                      "Offer available?",
                      style: Helper.getTheme(context).bodySmall,
                    ),
                    CustomTextInput(
                        textController: addressController,
                        hintText: "Offer"),
                    Spacer(),
                    Text(
                      "Popular?",
                      style: Helper.getTheme(context).bodySmall,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.black12, width: 1),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedPopular,
                            icon:
                            Icon(Icons.arrow_drop_down_outlined),
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.transparent,
                            ),
                            onChanged: (String? value) {

                            },
                            items:

                            popular
                                .map((value) {
                              return DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(value.toString()),
                              );
                            }).toList(),
                          ),
                        )),
                    Spacer(),
                    Text(
                      "Password",
                      style: Helper.getTheme(context).bodySmall,
                    ),
                    CustomTextInput(
                        textController: passController,
                        hintText: "Password"),
                    Spacer(),
                    Text(
                      "Confirm Password",
                      style: Helper.getTheme(context).bodySmall,
                    ),
                    CustomTextInput(
                        textController: confirmPassController,
                        hintText: "Confirm Password"),
                    Spacer(),


                    const Text(
                      'Photos(Optional)',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              imagePicker().then((e) {
                                if (e != null) {
                                  setState(() {});
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(.35))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text('Tap to Upload')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: imagefile == null
                              ? Container()
                              : Image.file(
                            imagefile!,
                            height: 45.0,
                            width: 45.0,
                          ),
                        )
                      ],
                    ),
                    Spacer(),

                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                             loading = true;
                          });
                          if(downloadUrl == null ){
                             print("no image url found in add restaurant");
                          } else {
                            print("my dowbload url ++++ $downloadUrl");
                            trainCanteen.doc("9dP3oajtd2Q7JWoqAAd7").collection("restaurant").add(
                                {
                                  "name": nameController.text,
                                  "email": emailController.text,
                                  "mobile": mobileController.text,
                                  "address": addressController.text,
                                  "popular": selectedPopular,
                                  "pass": passController.text,
                                  "image" : downloadUrl!,


                                }).then((value) {
                                  if(value.id.isNotEmpty){
                                    setState(() {
                                      loading = false;
                                    });
                                    Get.to(RestaurantList());

                                  } else {
                                    print("error _____");
                                  }

                            });
                          }

                        },
                        child: loading == true ? CircularProgressIndicator(): Text("Add Restaurant"),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

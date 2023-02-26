import 'package:admin_traincanteen/screen/add_restaurant/add_restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';
import '../utils/helper.dart';
import '../widgets/customNavBar.dart';

import '../widgets/searchBar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference trainCanteen =
      FirebaseFirestore.instance.collection('traincanteen');
  List allData = [];
  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await trainCanteen
        .doc("9dP3oajtd2Q7JWoqAAd7")
        .collection("restaurant")
        .get();

    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print("get all data ${allData.length}");
  }

  Future<void> getName() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await trainCanteen
        .doc("9dP3oajtd2Q7JWoqAAd7")
        .collection("registration")
        .get();

    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print("get all data ${allData.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: [
          Container(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 120,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                   // Get.to(DashBrdFront());
                    // Get.to(WebViewClass());
                    // Get.to(DashBoardPage());
                  },
                  child: Card(
                    elevation: 10,
                    color: Colors.teal[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(

                                image: AssetImage(

                                  'images/Icons/dash2.png',
                                )),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Center(child: const Text("Dashboard")),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AddRestaurant.routeName);
                  },
                  child: Card(
                    elevation: 10,
                    color: Colors.teal[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  'images/Icons/eye1.png',
                                )),
                          ),
                        ),
                        Center(child: const Text('Add Restaurant')),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  color: Colors.teal[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                'images/Icons/list1.png',
                              )),
                        ),
                      ),
                      Center(child: const Text('Add Food')),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                   // Get.to(EmployeeList());
                  },
                  child: Card(
                    elevation: 10,
                    color: Colors.teal[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  'images/Icons/list3.png',
                                )),
                          ),
                        ),
                        Center(child: const Text('Add Category')),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                   // Get.to(LeaveFront());
                  },
                  child: Card(
                    elevation: 10,
                    color: Colors.teal[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(  'images/Icons/holiday.png',)

                            ),
                          ),

                        ),
                        Center(child: const Text('Add Station')),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                   // Get.to(ReminderList());
                  },
                  child: Card(
                    elevation: 10,
                    color: Colors.teal[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(  'images/Icons/belluser.png', )

                            ),
                          ),

                        ),
                        Center(child:  Text('Add Offer', style: TextStyle(color: Colors.black),)),
                      ],
                    ),
                  ),
                ),



              ],
            ),
          ),
        ],
      )
    );
  }
}

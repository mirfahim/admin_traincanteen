import 'package:admin_traincanteen/const/colors.dart';
import 'package:admin_traincanteen/utils/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class RestaurantList extends StatefulWidget {
  static const routeName = "/homeScreen";

  @override
  State<RestaurantList> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<RestaurantList> {
  CollectionReference trainCanteen = FirebaseFirestore.instance.collection('traincanteen');
  List allData = [];
  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await trainCanteen.doc("9dP3oajtd2Q7JWoqAAd7").collection("restaurant").get();

    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print("get all data ${allData.length}");
  }
  Future<void> getName() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await trainCanteen.doc("9dP3oajtd2Q7JWoqAAd7").collection("registration").get();

    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print("get all data ${allData.length}");
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant List"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),




              Container(

                  child: FutureBuilder(
                      future: getData(),
                      builder: (context, snapshot) {
                        print("ggggggggg ${allData[0]['image']}");
                        return Column(
                          children: [
                            Text("Total Restaurant: ${allData.length}"),
                            Container(
                              height: 1400,
                              child: ListView.builder(
                                  itemCount: allData.length,
                                  itemBuilder: (BuildContext context, index){
                                    return Card(
                                      child: RestaurantCard(
                                        image: allData[index]['image'],
                                        name: allData[index]['name'],
                                      ),
                                    );
                                  }),
                            ),
                          ]
                        );
                      }
                  )
              ),

              // RestaurantCard(
              //   image: Image.asset(
              //     Helper.getAssetName("pizza2.jpg", "real"),
              //     fit: BoxFit.cover,
              //   ),
              //   name: "Station Pizza",
              // ),

            ],
          ),
        ),
      ),
    );
  }
}



class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    Key? key,
     String? name,
     String? image,
  })  : _image = image,
        _name = name,
        super(key: key);

  final String? _name;
  final String? _image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Column(
        children: [
       Row(
         children: [
           Container(
                height: 80,
              width: 100,
               child: CachedNetworkImage(imageUrl: "https://firebasestorage.googleapis.com/v0/b/khotianit.appspot.com/o/images%2Fdata%2Fuser%2F0%2Fcom.traincanteen.admin_traincanteen%2Fcache%2F7859669d-6b20-4cdb-96cf-68157e3c9017%2F20230225_191124.jpg?alt=media&token=eb95d2d8-c97a-4e4f-b7d2-5fab0da77da9"!,),

      ),

           Padding(
             padding: const EdgeInsets.symmetric(
               horizontal: 10,
             ),
             child: Column(
               children: [
                 Row(
                   children: [
                     Text(
                       _name!,
                       style: Helper.getTheme(context).bodyMedium,
                     ),
                   ],
                 ),
                 SizedBox(
                   height: 5,
                 ),
                 Row(
                   children: [
                     Image.asset(
                       Helper.getAssetName("star_filled.png", "virtual"),
                     ),
                     SizedBox(
                       width: 5,
                     ),
                     Text(
                       "4.9",
                       style: TextStyle(
                         color: AppColor.orange,
                       ),
                     ),
                     SizedBox(
                       width: 5,
                     ),
                     Text("(124 ratings)"),
                     SizedBox(
                       width: 5,
                     ),
                     Text("Cafe"),
                     SizedBox(
                       width: 5,
                     ),
                     Padding(
                       padding: const EdgeInsets.only(bottom: 5.0),
                       child: Text(
                         ".",
                         style: TextStyle(
                           color: AppColor.orange,
                           fontWeight: FontWeight.w900,
                         ),
                       ),
                     ),
                     SizedBox(
                       width: 5,
                     ),
                     Text("Station Food"),
                   ],
                 ),
               ],
             ),
           )
         ],
       ),

        ],
      ),
    );
  }
}



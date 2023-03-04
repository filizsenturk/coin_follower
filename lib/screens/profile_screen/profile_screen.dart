import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_follower/constants/strings.dart';
import 'package:coin_follower/screens/home_page_screen/home_page_screen.dart';
import 'package:coin_follower/local_helper/preferecences_helper.dart';
import 'package:coin_follower/utils/logger.dart';
import 'package:coin_follower/widgets/profile_info_row.dart';
import 'package:coin_follower/widgets/user.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/ProfileScreen";
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final log = getLogs();

  TextEditingController controller = TextEditingController();
  TextEditingController changeController = TextEditingController();


  Future<User?> readUser()async{
    final docID = await PreferencesHelper.get(Strings.cEmail);
    final docUser = FirebaseFirestore.instance.collection('users').doc(docID);
    final snapshot = await docUser.get();
    if(snapshot.exists){
      return User.fromJson(snapshot.data()!);
    }
  }

  //update is name or surname
  Future<void> _showMyDialog({required String update}) async {
    final email = await PreferencesHelper.get(Strings.cEmail);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('$update'),
          content: TextFormField(
            controller: changeController,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Send'),
              onPressed: () {
                final docUser = FirebaseFirestore.instance.collection('users').doc(email);
                docUser.update(
                  {
                    update : changeController.text.trim().toString()
                  }
                );
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              },
            ),
          ],
        );
      },
    );
  }

  onNameTapped()async{
    _showMyDialog(update: 'name');
  }

  onSurnameTapped()async{
    _showMyDialog(update: 'surname');
  }

  onHomeClicked(){
    Navigator.pushNamed(context, HomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User?>(
       future: readUser(),
       builder: (context,snapshot){
      if(snapshot.hasError){
        log.i("snapshot has error");
        return Center(child: Text("Something went wrong"),);
      }else if(snapshot.hasData){
        log.i("snapshot has data and $snapshot");
         final users = snapshot.data;
         return   Container(
           height: 100.h,
           color: Colors.white,
            padding: EdgeInsets.only(top: 5.h),
            child: Column(
              children: [
                Container(height: 20.h,child: Icon(Icons.person,size: 150,color: Colors.grey.withOpacity(0.9),
                shadows: [Shadow(color: Colors.grey.withOpacity(0.9),
                  blurRadius: 17,
                  offset: Offset(0, -5),)],
                ),
                ),
                Container(
                  height: 75.h,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(100),topRight: Radius.circular(100)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.9),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, -5), // changes position of shadow
                      ),
                    ]
                  ),
                  child: Column(
                    children: [
                      ProfileInfoRow(text: "name", value: users!.name!,onTap: onNameTapped,),
                      ProfileInfoRow(text: "surname", value: users.surname,onTap: onSurnameTapped,),
                      ProfileInfoRow(text: "country", value: users.country??"",onTap: (){},),
                      ProfileInfoRow(text: "birthday", value: users.birthday.toString()??"",onTap: (){},),
                      buildHomeScreenIcon()
                    ],
                  ),
                ),
              ],
            ),
          );
       }else{
       // Navigator.of(context).pushNamed(EditProfileScreen.routeName);
        return CircularProgressIndicator();
      }

       },
      )
    );
  }

  Padding buildHomeScreenIcon() {
    return Padding(
      padding:  EdgeInsets.only(top: 5.h),
      child: IconButton(onPressed: onHomeClicked, icon: Icon(Icons.home,color: Colors.white,)),
    );
  }
}

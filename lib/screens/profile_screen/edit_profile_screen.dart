import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_follower/constants/strings.dart';
import 'package:coin_follower/local_helper/preferecences_helper.dart';
import 'package:coin_follower/screens/home_page_screen/home_page_screen.dart';
import 'package:coin_follower/screens/profile_screen/send_btn.dart';
import 'package:coin_follower/utils/appcolor.dart';
import 'package:coin_follower/widgets/profile_text_fields.dart';
import 'package:coin_follower/widgets/profile_texts.dart';
import 'package:coin_follower/widgets/user.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = "/EditProfileScreen";
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController surnameController = TextEditingController();

  TextEditingController birthDayController = TextEditingController();

  bool showCalender = false;
  String birthday = "";

  Future createUser({required String name, required String surname}) async {
    final docID = await PreferencesHelper.get(Strings.cEmail);
    final docUser = FirebaseFirestore.instance.collection('users').doc(docID);
    final user =
        User(id: docUser.id, name: name, surname: surname, birthday: birthday);
    final json = user.toJson();
    await docUser
        .set(json)
        .then((value) => Navigator.of(context).pushNamed(HomePage.routeName));
  }

  onSendClicked() {
    final name = nameController.text;
    final surname = surnameController.text;
    // final birthday = (birthDayController.text as Timestamp).toDate();
    createUser(
      name: name,
      surname: surname,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(left: 5.w, top: 10.h),
        child: Column(
          children: [
            buildIcon(),
            showCalender
                ? _buildDefaultSingleDatePickerWithValue()
                : buildInfoColumn(),
            buildSendBtn()
          ],
        ),
      ),
    );
  }

  Padding buildName() {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        children: [
          ProfileTexts(text: Strings.cName),
          ProfileTextFields(controller: nameController)
        ],
      ),
    );
  }

  Padding buildSurname() {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        children: [
          ProfileTexts(text: Strings.cSurName),
          ProfileTextFields(controller: surnameController)
        ],
      ),
    );
  }

  Padding buildBirthDay() {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        children: [
          ProfileTexts(text: Strings.cBirthday),
          buildCalender()
          //  ProfileTextFields(controller: birthDayController)
        ],
      ),
    );
  }

  Padding buildCountry() {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        children: [
          ProfileTexts(text: Strings.cCountry),
        ],
      ),
    );
  }

  Container buildIcon() {
    return Container(
      padding: EdgeInsets.only(right: 5.w),
      // height: 15.h,
      child: Icon(
        Icons.person,
        size: 250,
      ),
    );
  }

  SendBtn buildSendBtn() {
    return SendBtn(
      onSendClicked: onSendClicked,
    );
  }

  Row buildCalender() {
    return Row(
      children: [
        Container(width:40.w,child: Text(birthday)),
        IconButton(
            onPressed: () {
              setState(() {
                showCalender = true;
              });
            },
            icon: Icon(Icons.calendar_month)),
      ],
    );
  }

  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];

  _buildDefaultSingleDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      selectedDayHighlightColor: Colors.amber[900],
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle:  TextStyle(
        color: AppColors.textColor,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 20,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Colors.amber,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        CalendarDatePicker2(
            config: config,
            initialValue: _singleDatePickerValueWithDefaultValue,
            onValueChanged: (values) {
              setState(() {
                _singleDatePickerValueWithDefaultValue = values;
                showCalender = false;
                birthday =  _singleDatePickerValueWithDefaultValue[0]!
                        .day.toString() + "/" +
                    _singleDatePickerValueWithDefaultValue[0]!
                        .month.toString() + "/" +
                    _singleDatePickerValueWithDefaultValue[0]!.year.toString();
              });
            }),
      ],
    );
  }

  Column buildInfoColumn() {
    return Column(
      children: [
        buildName(),
        buildSurname(),
        buildCountry(),
        buildBirthDay(),
      ],
    );
  }
}

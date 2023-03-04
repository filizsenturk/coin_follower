import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String id;
  String? name;
  String surname;
  String? country;
  String? birthday;
  User({required this.name,required this.surname,this.country,this.id='',required this.birthday});

  Map<String,dynamic> toJson()=>{
    'id':id,
    'name':name,
    'surname':surname,
    'country':country,
    'birthday':birthday
  };

  static User fromJson(Map<String,dynamic> json)=>User(
    id: json['id'],
    name: json['name'],
    country: json['country'],
    surname: json['surname'],
    birthday: json['birthday'] ,
  );
}
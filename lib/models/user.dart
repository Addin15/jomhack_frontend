import 'package:jomhack/models/assestment.dart';

class XUser {
  String? id;
  String? name;
  String? email;
  String? image;
  Assestment? assestment;

  XUser({
    this.id,
    this.name,
    this.email,
    this.image,
    this.assestment,
  });

  factory XUser.fromMap(Map<String, dynamic> data) => XUser(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        image: data['image'],
        assestment: data['assestment'] == null
            ? null
            : Assestment.fromMap(data['assestment']),
      );
}

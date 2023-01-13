class XUser {
  String? id;
  String? name;
  String? email;

  XUser({
    this.id,
    this.name,
    this.email,
  });

  factory XUser.fromMap(Map<String, dynamic> data) => XUser(
        id: data['id'],
        name: data['name'],
        email: data['email'],
      );
}

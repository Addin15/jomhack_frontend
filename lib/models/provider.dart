class ProviderModel {
  String? id;
  String? name;
  String? logo;
  String? about;
  String? phone;
  String? email;
  String? website;

  ProviderModel({
    this.id,
    this.name,
    this.logo,
    this.about,
    this.phone,
    this.email,
    this.website,
  });

  factory ProviderModel.fromMap(Map<String, dynamic> data) => ProviderModel(
        id: data['id'],
        name: data['name'],
        logo: data['logo'],
        about: data['about'],
        phone: data['phone'],
        email: data['email'],
        website: data['website'],
      );
}

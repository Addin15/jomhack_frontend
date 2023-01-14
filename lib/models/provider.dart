class ProviderModel {
  String? id;
  String? name;
  String? logo;
  String? about;

  ProviderModel({
    this.id,
    this.name,
    this.logo,
    this.about,
  });

  factory ProviderModel.fromMap(Map<String, dynamic> data) => ProviderModel(
        id: data['id'],
        name: data['name'],
        logo: data['logo'],
        about: data['about'],
      );
}

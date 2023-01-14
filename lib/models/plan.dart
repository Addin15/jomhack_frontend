import 'package:jomhack/models/provider.dart';

class PlanModel {
  String? id;
  String? name;
  String? about;
  String? category;
  ProviderModel? provider;

  PlanModel({
    this.id,
    this.name,
    this.about,
    this.category,
    this.provider,
  });

  factory PlanModel.fromMap(Map<String, dynamic> data) => PlanModel(
        id: data['id'],
        name: data['name'],
        about: data['about'],
        category: data['category'],
        provider: ProviderModel.fromMap(data['provider']),
      );
}

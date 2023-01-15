import 'package:jomhack/models/provider.dart';

class PlanModel {
  String? id;
  String? name;
  String? about;
  String? category;
  ProviderModel? provider;
  double? price;

  PlanModel({
    this.id,
    this.name,
    this.about,
    this.category,
    this.provider,
    this.price,
  });

  factory PlanModel.fromMap(Map<String, dynamic> data, int tier) => PlanModel(
      id: data['id'],
      name: data['name'],
      about: data['about'],
      category: data['category'],
      provider: ProviderModel.fromMap(data['provider']),
      price: tier == 1
          ? data['tier_one_price']
          : tier == 2
              ? data['tier_two_price']
              : data['tier_three_price']);
}

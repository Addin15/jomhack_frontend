import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:jomhack/config/api.dart';
import 'package:jomhack/config/headers.dart';
import 'package:jomhack/models/news.dart';
import 'package:jomhack/models/plan.dart';

class APIService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<List<PlanModel>> getUserPlans() async {
    try {
      String? token = await _storage.read(key: 'token');

      if (token != null) {
        String url = '${baseURL}user/plans/';

        Response response = await get(
          Uri.parse(url),
          headers: headersWithToken(token),
        );

        if (response.statusCode == 200) {
          Map data = jsonDecode(response.body);

          List<PlanModel> plans =
              (data['plans'] as List).map((e) => PlanModel.fromMap(e)).toList();

          return plans;
        }
      }

      return [];
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<List<PlanModel>> getPlans() async {
    try {
      String? token = await _storage.read(key: 'token');

      if (token != null) {
        String url = '${baseURL}plans/';

        Response response = await get(
          Uri.parse(url),
          headers: headersWithToken(token),
        );

        log(response.body.toString());

        if (response.statusCode == 200) {
          List data = jsonDecode(response.body);

          List<PlanModel> plans =
              data.map((e) => PlanModel.fromMap(e)).toList();

          return plans;
        }
      }

      return [];
    } catch (e) {
      log('Plan' + e.toString());
      return [];
    }
  }

  static Future<List<NewsModel>> getNews() async {
    try {
      String? token = await _storage.read(key: 'token');

      if (token != null) {
        String url = '${baseURL}user/news/';

        Response response = await get(
          Uri.parse(url),
          headers: headersWithToken(token),
        );

        if (response.statusCode == 200) {
          Map data = jsonDecode(response.body);

          List<NewsModel> news =
              (data['news'] as List).map((e) => NewsModel.fromMap(e)).toList();

          return news;
        }
      }

      return [];
    } catch (e) {
      log('News' + e.toString());
      return [];
    }
  }
}

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jomhack/config/headers.dart';
import 'package:jomhack/models/assestment.dart';

import '../config/api.dart';
import '../models/user.dart';

class AuthService with ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  XUser? user;

  AuthService() {
    init();
  }

  Future<void> init() async {
    try {
      String? token = await _storage.read(key: 'token');

      if (token != null) {
        String url = '${baseURL}user/';

        Response response = await get(
          Uri.parse(url),
          headers: headersWithToken(token),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.body);

          XUser u = XUser.fromMap(data);
          user = u;
          notifyListeners();
        } else if (response.statusCode == 401) {
          await _storage.delete(key: 'token');
          user = null;
          notifyListeners();
        }
      }
    } catch (e) {
      log('Init' + e.toString());
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      String url = '${baseURL}login/';
      Response response = await post(Uri.parse(url),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: headersWithoutToken());

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        XUser u = XUser.fromMap(data['user']);
        user = u;
        await _storage.write(key: 'token', value: data['token']);
        notifyListeners();
        return null;
      }

      return 'User not found';
    } catch (e) {
      log(e.toString());
      return 'Error while loging in';
    }
  }

  Future<bool> edit({
    required File? image,
    required String name,
  }) async {
    try {
      String? token = await _storage.read(key: 'token');
      if (token != null) {
        String url = '${baseURL}edit/';
        if (image == null) {
          Response response = await post(Uri.parse(url),
              body: jsonEncode({
                'name': name,
              }),
              headers: headersWithToken(token));

          if (response.statusCode == 200) {
            user!.name = name;
            notifyListeners();
            return true;
          }
        } else {
          MultipartRequest request = MultipartRequest(
            'POST',
            Uri.parse(url),
          );

          request.headers.addAll({
            "Authorization": "Token $token",
            "Content-type": "multipart/form-data"
          });

          request.fields.addAll({
            'name': name,
          });

          request.files.add(
            MultipartFile(
              'image',
              image.readAsBytes().asStream(),
              image.lengthSync(),
              filename: image.path,
              contentType: MediaType('image', 'jpeg'),
            ),
          );

          StreamedResponse response = await request.send();

          if (response.statusCode == 200) {
            await init();
            notifyListeners();
            return true;
          }
        }
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      String url = '${baseURL}register/';
      Response response = await post(Uri.parse(url),
          body: jsonEncode({
            'name': name,
            'email': email,
            'password': password,
          }),
          headers: headersWithoutToken());

      if (response.statusCode == 201) {
        Map<String, dynamic> data = jsonDecode(response.body);

        XUser u = XUser.fromMap(data['user']);
        user = u;
        await _storage.write(key: 'token', value: data['token']);
        notifyListeners();
        return null;
      }

      return 'User already exists';
    } catch (e) {
      log(e.toString());
      return 'Error while loging in';
    }
  }

  Future<bool> submitAssestment({
    required Assestment assestment,
  }) async {
    try {
      String? token = await _storage.read(key: 'token');

      if (token != null) {
        String url = '${baseURL}assestment/';
        Response response = await post(
          Uri.parse(url),
          body: jsonEncode(assestment.toMap()),
          headers: headersWithToken(token),
        );

        log(response.statusCode.toString());

        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.body);

          Assestment assestment = Assestment.fromMap(data);
          user!.assestment = assestment;
          notifyListeners();
          return true;
        }
      }

      return false;
    } catch (e) {
      log('Auth' + e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    try {
      String? token = await _storage.read(key: 'token');
      if (token != null) {
        String url = '${baseURL}logout/';
        await post(
          Uri.parse(url),
          headers: headersWithToken(token),
        );
      }

      user = null;
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> uploadPhoto({required File image}) async {
    try {
      String? token = await _storage.read(key: 'token');

      if (token != null) {
        String url = '${baseURL}upload/';

        MultipartRequest request = MultipartRequest(
          'POST',
          Uri.parse(url),
        );

        request.headers.addAll({
          "Authorization": "Token $token",
          "Content-type": "multipart/form-data"
        });

        request.files.add(
          MultipartFile(
            'image',
            image.readAsBytes().asStream(),
            image.lengthSync(),
            filename: image.path,
            contentType: MediaType('image', 'jpeg'),
          ),
        );

        StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          await init();
          return true;
        }
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}

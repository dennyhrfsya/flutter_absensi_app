import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_absensi_app/core/constants/variables.dart';
import 'package:flutter_absensi_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_absensi_app/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
    String email,
    // String username,
    String password,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
      // body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left('Failed to Login');
    }
  }

  //logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/logout');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );
    if (response.statusCode == 200) {
      return Right('Logout Success');
    } else {
      return Left('Failed to Logout');
    }
  }
}

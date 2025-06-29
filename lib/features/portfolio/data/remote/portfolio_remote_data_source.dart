import 'dart:convert';

import 'package:baraka_flutter/features/portfolio/data/models/portfolio_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/environment.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class PortfolioRemoteDataSource {
  final Dio client;

  PortfolioRemoteDataSource(this.client);

  Future<PortfolioModel> getPortfolio() async {
    try {
      final response = await client.get(
        '${EnvironmentConfig.baseUrl}/c/60b7-70a6-4ee3-bae8',
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load portfolio (status: ${response.statusCode})');
      }

      final data = response.data is String
          ? json.decode(response.data as String)
          : response.data;
      return PortfolioModel.fromJson(data['portfolio']);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on FormatException {
      throw Exception('Unexpected response format');
    }
  }
}

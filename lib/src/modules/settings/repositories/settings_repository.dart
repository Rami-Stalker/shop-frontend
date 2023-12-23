import 'dart:async';

import 'package:shop_app/src/resources/base_repository.dart';

import '../../../public/api_gateway.dart';
import 'package:dio/dio.dart' as diox;

class SettingsRepository {
  final BaseRepository baseRepository;
  SettingsRepository(this.baseRepository);

  Future<diox.Response> updateAvatar({
    required String photo,
    // required String toBlurHash,
  }) async {
    var body = {
      "photo": photo,
      // "toBlurHash": toBlurHash,
    };
    return await BaseRepository().patchRoute(
      ApiGateway.UPDATE_AVATAR,
      body: body,
    );
    // if ([200, 201].contains(response.statusCode)) {
    //   return UserModel.fromMap(response.data['data'] as Map<String, dynamic>);
    // }
    // return null;
  }
}

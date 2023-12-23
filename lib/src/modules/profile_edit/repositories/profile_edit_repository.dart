import 'package:dio/dio.dart' as diox;

import '../../../public/api_gateway.dart';

import '../../../resources/base_repository.dart';

class ProfileEditRepository {
  final BaseRepository baseRepository;
  ProfileEditRepository(this.baseRepository);

  Future<diox.Response> modifyUserInfo(
    String address,
    String name,
    String phone,
  ) async {
    var body = {
      "address": address,
      "name": name,
      "phone": phone,
    };
    return await baseRepository.postRoute(
      ApiGateway.UPDATE_USER_INFO,
      body,
    );
  }
}

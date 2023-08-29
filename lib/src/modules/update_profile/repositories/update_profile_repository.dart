import 'package:dio/dio.dart' as diox;

import '../../../public/api_gateway.dart';

import '../../../core/api/base_repository.dart';
class UpdateProfileRepository {
  final BaseRepository baseRepository;
  UpdateProfileRepository({
    required this.baseRepository,
  });

  Future<diox.Response> modifyUserInfo(
      String address, String name, String phone) async {
    var body = {
      "address": address,
      "name": name,
      "phone": phone,
    };
    return await baseRepository.postRoute(
      ApiGateway.MODIFY_USER_INFO,
      body,
    );
  }
}

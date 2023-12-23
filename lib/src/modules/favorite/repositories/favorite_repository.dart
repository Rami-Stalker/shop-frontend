import '../../../public/api_gateway.dart';
import '../../../resources/base_repository.dart';
import 'package:dio/dio.dart' as diox;

class FavoriteRepository {
  final BaseRepository baseRepository;
  FavoriteRepository(this.baseRepository);

  Future<diox.Response> fetchProductFavorites() async {
    return await baseRepository.getRoute(ApiGateway.GET_FAVORITES);
  }

  Future<diox.Response> changeMealFavorite(String mealId) async {
    var body = {
      "mealId": mealId,
    };
    return await baseRepository.postRoute(
      ApiGateway.FAVORITE_PRODUCT,
      body,
    );
  }
}

import '../../../domain/models/user/business_category/business_category.dart';
import '../../http/http.dart';

class CategoryService {
  CategoryService(this._http);
  final Http _http;

  Future<List<BusinessCategory>?> getBusinessCategory() async {
    String categoriaQuery = '''
  query{
    categoriaNegocios{
      id
      descripcion
    }
  }
 ''';
    final resutlGraphql = await _http.requestGraphQL(
      query: categoriaQuery,
      authentication: false,
      onSucces: (json) {
        final categorias = (json['categoriaNegocios'] as List)
            .map((e) => BusinessCategory.fromJson(e))
            .toList();
        return categorias;
      },
    );
    return resutlGraphql.when(
      left: (_) => null,
      right: (categorias) => categorias,
    );
  }
}

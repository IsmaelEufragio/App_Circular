import '../../domain/models/user/business_category/business_category.dart';
import '../../domain/repositories/category_repsitory.dart';
import '../services/remoto/category_service.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(this._categoryService);

  final CategoryService _categoryService;

  @override
  Future<List<BusinessCategory>?> getBusinessCategory() {
    return _categoryService.getBusinessCategory();
  }
}

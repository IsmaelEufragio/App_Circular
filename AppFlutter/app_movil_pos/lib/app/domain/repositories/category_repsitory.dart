import '../models/user/business_category/business_category.dart';

abstract class CategoryRepository {
  Future<List<BusinessCategory>?> getBusinessCategory();
}

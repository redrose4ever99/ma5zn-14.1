import 'package:flutter/material.dart';
import 'package:com.makzan.eco/data/model/response/base/api_response.dart';
import 'package:com.makzan.eco/data/model/response/category.dart';
import 'package:com.makzan.eco/data/repository/category_repo.dart';
import 'package:com.makzan.eco/helper/api_checker.dart';
import 'package:com.makzan.eco/main.dart';
import 'package:com.makzan.eco/provider/brand_provider.dart';
import 'package:com.makzan.eco/provider/product_provider.dart';
import 'package:provider/provider.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepo? categoryRepo;

  CategoryProvider({required this.categoryRepo});

  final List<Category> _categoryList = [];
  int? _categorySelectedIndex;

  List<Category> get categoryList => _categoryList;
  int? get categorySelectedIndex => _categorySelectedIndex;

  Future<void> getCategoryList(bool reload) async {
    if (_categoryList.isEmpty || reload) {
      ApiResponse apiResponse = await categoryRepo!.getCategoryList();
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        _categoryList.clear();
        apiResponse.response!.data.forEach(
            (category) => _categoryList.add(Category.fromJson(category)));
        _categorySelectedIndex = 0;
      } else {
        ApiChecker.checkApi(apiResponse);
      }
      notifyListeners();
    }
  }

  Future<void> getSellerWiseCategoryList(int sellerId) async {
    ApiResponse apiResponse =
        await categoryRepo!.getSellerWiseCategoryList(sellerId);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _categoryList.clear();
      apiResponse.response!.data.forEach(
          (category) => _categoryList.add(Category.fromJson(category)));
      _categorySelectedIndex = 0;
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  List<int> selectedCategoryIds = [];
  void checkedToggleCategory(int index) {
    _categoryList[index].isSelected = !_categoryList[index].isSelected!;
    notifyListeners();
  }

  void checkedToggleSubCategory(int index, int subCategoryIndex) {
    _categoryList[index].subCategories![subCategoryIndex].isSelected =
        !_categoryList[index].subCategories![subCategoryIndex].isSelected!;
    notifyListeners();
  }

  void resetChecked(int? id, bool fromShop) {
    if (fromShop) {
      getSellerWiseCategoryList(id!);
      Provider.of<BrandProvider>(Get.context!, listen: false)
          .getSellerWiseBrandList(id);
      Provider.of<ProductProvider>(Get.context!, listen: false)
          .getSellerProductList(id.toString(), 1, Get.context!);
    } else {
      getCategoryList(true);
      Provider.of<BrandProvider>(Get.context!, listen: false)
          .getBrandList(true);
    }
  }

  void changeSelectedIndex(int selectedIndex) {
    _categorySelectedIndex = selectedIndex;
    notifyListeners();
  }
}

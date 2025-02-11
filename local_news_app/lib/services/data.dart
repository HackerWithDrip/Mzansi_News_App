import 'package:local_news_app/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = <CategoryModel>[];
  CategoryModel categoryModel = new CategoryModel();

  categoryModel.categoryName = "Business";
  categoryModel.imageUrl = "images/business.png";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "entertainment";
  categoryModel.imageUrl = "images/business.png";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "general";
  categoryModel.imageUrl = "images/business.png";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "health";
  categoryModel.imageUrl = "images/business.png";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "science";
  categoryModel.imageUrl = "images/business.png";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "sports";
  categoryModel.imageUrl = "images/business.png";
  category.add(categoryModel);

  return category;
}

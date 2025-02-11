import 'package:local_news_app/models/slider_model.dart';

List<sliderModel> getSliders() {
  List<sliderModel> slider = [];
  sliderModel categoryModel = new sliderModel();

  categoryModel.name = "Inside the business";
  categoryModel.image = "images/business.jpg";
  slider.add(categoryModel);
  categoryModel = new sliderModel();

  categoryModel.name = "Inside the business";
  categoryModel.image = "images/health.jpg";
  slider.add(categoryModel);
  categoryModel = new sliderModel();

  categoryModel.name = "Inside the business";
  categoryModel.image = "images/science.jpg";
  slider.add(categoryModel);
  categoryModel = new sliderModel();

  return slider;
}

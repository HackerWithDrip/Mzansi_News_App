import 'package:local_news_app/services/slider_data.dart';

class SliderModel {
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  //String? publishedAt;
  String? content;
  String? author;

  SliderModel(
      {this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.content,
      this.author});
}

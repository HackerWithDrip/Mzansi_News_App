import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:local_news_app/models/show_category.dart';
import 'package:local_news_app/models/slider_model.dart';

class ShowCategoryNews {
  List<ShowCategoryModel> categories = [];

  Future<void> getCategoriesNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=a3577513e7714e469a73d2cd493daaf3";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      for (var element in jsonData["articles"]) {
        String? imageUrl = element["urlToImage"];
        if (imageUrl != null && element["description"] != null) {
          bool isImageValid = await _isValidImage(imageUrl);
          if (isImageValid) {
            ShowCategoryModel categoryModel = ShowCategoryModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: imageUrl,
              content: element['content'],
              author: element['author'],
            );
            categories.add(categoryModel);
          }
        }
      }
    }
  }

  /// Helper function to check if an image URL is valid
  Future<bool> _isValidImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Check if the response is actually an image
        String contentType = response.headers['content-type'] ?? '';
        if (contentType.startsWith('image/')) {
          return true;
        }
      }
    } catch (e) {
      print("Error validating image: $e");
    }
    return false;
  }
}

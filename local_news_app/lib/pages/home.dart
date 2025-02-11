// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:local_news_app/models/category_model.dart';
import 'package:local_news_app/services/data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];

  @override
  void initState() {
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Mzansi"),
            Text("News",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    image: categories[index].imageUrl,
                    categoryName: categories[index].categoryName,
                    isFirstItem: index == 0,
                  );
                }),
          )
        ],
      ),
    );
  }
}

// List of categories
class CategoryTile extends StatelessWidget {
  final image, categoryName;
  final bool isFirstItem;
  CategoryTile({this.image, this.categoryName, this.isFirstItem = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: isFirstItem ? 10.0 : 0.0, right: 10.0),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.asset(
                image,
                width: 310.0,
                height: 60,
                fit: BoxFit.cover,
              )),
          Container(
              width: 310.0,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.black38),
              child: Center(
                child: Text(
                  categoryName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    );
  }
}

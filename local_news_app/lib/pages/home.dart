// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:local_news_app/models/category_model.dart';
import 'package:local_news_app/services/data.dart';
import 'package:local_news_app/models/slider_model.dart';
import 'package:local_news_app/services/slider_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<sliderModel> sliders = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    categories = getCategories();
    sliders = getSliders();
    super.initState();
  }

  void _scrollToIndex(int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = 310.0 + 10.0; // Item width + right margin

    // Calculate the target offset
    final targetOffset =
        (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

    _scrollController.animateTo(
      targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
          Container(
            height: 70.0,
            child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _scrollToIndex(index),
                    child: CategoryTile(
                      image: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                      isFirstItem: index == 0,
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 15.0,
          ),
          CarouselSlider.builder(
              itemCount: sliders.length,
              itemBuilder: (context, index, realIndex) {
                String? res = sliders[index].image;
                String? res1 = sliders[index].name;
                return buildImage(res!, index, res1!);
              },
              options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Add this
    super.dispose();
  }

  Widget buildImage(String image, int index, String name) => Container(
        child: Image.asset(
          image,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ),
      );
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

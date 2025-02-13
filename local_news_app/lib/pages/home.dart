// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:local_news_app/models/article_model.dart';
import 'package:local_news_app/models/category_model.dart';
import 'package:local_news_app/services/data.dart';
import 'package:local_news_app/models/slider_model.dart';
import 'package:local_news_app/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:local_news_app/services/news.dart';
import 'package:local_news_app/pages/article_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<sliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true;
  ScrollController _scrollController = ScrollController();
  int activeIndex = 0;

  @override
  void initState() {
    categories = getCategories();
    sliders = getSliders();
    getNews();
    super.initState();
  }

  getNews() async {
    News news = News();
    await news.getNews();
    articles = news.news;
    setState(() {
      _loading = false;
    });
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
        automaticallyImplyLeading: false,
        title: Container(
          width: double.infinity, // Ensures full width
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max, // Ensures full width usage
            children: [
              Text("Trendy"),
              Text(
                "News",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        centerTitle: true, // Ensures correct centering
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Breaking News!",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w900)),
                        Text("View All",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
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
                          height: 220.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          })),
                  SizedBox(
                    height: 15.0,
                  ),
                  Center(child: buildIndicator()),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Trending News",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        Text("View All",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return BlogTile(
                              url: articles[index].url!,
                              imageUrl: articles[index].urlToImage!,
                              title: articles[index].title!,
                              desc: articles[index].description!);
                        }),
                  )
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Add this
    super.dispose();
  }

  Widget buildImage(String image, int index, String name) => Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
            height: 300.0,
            padding: EdgeInsets.only(top: 20.0),
            margin: EdgeInsets.only(top: 150.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0))),
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ))
      ]));

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: sliders.length,
        effect: WormEffect(
            dotWidth: 17.5, dotHeight: 10, activeDotColor: Colors.blue),
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

class BlogTile extends StatelessWidget {
  String imageUrl, title, desc, url;
  BlogTile(
      {required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width) / 1.8,
                        child: Text(
                            maxLines: 2,
                            title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width) / 1.8,
                        child: Text(
                            maxLines: 3,
                            desc,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

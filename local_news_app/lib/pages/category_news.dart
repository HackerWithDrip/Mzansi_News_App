import 'package:flutter/material.dart';

class CategoryNews extends StatefulWidget {
  const CategoryNews({super.key});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
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
      body: Container(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'home.dart'; // Import your home page
import 'package:get/get.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: [
            Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(30.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  "images/building.jpg",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.5,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: "Welcome to Mzansi",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: "News",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "     Your number one source for news in Mzansi \n     context, keeping you updated with the latest",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "news. Azishe ke!",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 40.0),
            InkWell(
              onTap: () {
                Get.to(() => Home(),
                    transition: Transition.circularReveal,
                    duration: Duration(seconds: 2));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Material(
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 5.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Center(
                      child: Text(
                        "Get started",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

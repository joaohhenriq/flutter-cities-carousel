import 'package:flutter/material.dart';

final imageList = [
  "assets/images/dubai.jpg",
  "assets/images/new-york.jpg",
  "assets/images/rio-de-janeiro.jpg",
  "assets/images/sidney.jpg",
  "assets/images/tokyo.jpg",
];

final colorList = [
  Colors.redAccent.shade100,
  Colors.blueAccent.shade100,
  Colors.amber.shade50
];

class CityExplorerPage extends StatefulWidget {
  @override
  _CityExplorerPageState createState() => _CityExplorerPageState();
}

class _CityExplorerPageState extends State<CityExplorerPage> {
  int currentPage = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.8,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          itemBuilder: (context, index) {
            return itemBuilder(index);
          },
          controller: _pageController,
          pageSnapping: true,
          onPageChanged: _onPageChanged,
          itemCount: 5,
          physics: ClampingScrollPhysics(),
        ),
      ),
    );
  }

  Widget itemBuilder(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child){
        double value = 1;
        if(_pageController.position.haveDimensions){
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.1)).clamp(0.0, 1.0);
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
              height: Curves.easeIn.transform(value) * 450,
              child: child,
            ),
          );

        } else {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
              height: Curves.easeIn.transform(index == 0 ? value : value * 0.5) * 450,
              child: child,
            ),
          );
        }
      },
      child: Material(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Image.asset(
              imageList[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  _onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }
}

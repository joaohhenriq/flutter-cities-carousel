import 'package:flutter/material.dart';
import 'package:flutter_cities_carousel/model/city_model.dart';

final imageList = [
  "assets/images/dubai.jpg",
  "assets/images/new-york.jpg",
  "assets/images/rio-de-janeiro.jpg",
  "assets/images/sidney.jpg",
  "assets/images/tokyo.jpg",
];

final colorList = [
  Colors.grey[200],
  Colors.purple[50],
  Colors.orange[50],
  Colors.blue[50],
  Colors.blue[100],
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
        child: Stack(
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              color: colorList[currentPage],
            ),
            Column(
              children: <Widget>[
                Container(
                  height: 450,
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
                _detailsBuilder(currentPage),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailsBuilder(index){
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child){
        double value = 1;
        if(_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.1)).clamp(0.0, 1.0);
        }
        return Expanded(
          child: Transform.translate(
            offset: Offset(0.0, 100 + (-value * 100)),
            child: Opacity(
              opacity: value,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 16),
                child: Column(
                  children: <Widget>[
                    Text(
                      detailsList[index].title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        fontFamily: "LibreCaslonDisplay",
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      detailsList[index].description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "LibreCaslonDisplay",
                        color: Colors.grey[700],
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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

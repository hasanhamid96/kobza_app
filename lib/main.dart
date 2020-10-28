import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import 'search_screen.dart';
import 'main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: Color(0xffEDD5A9),
          backgroundColor: Color(0xffB49A7F),


          // primarySwatch: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: ThemeData.dark().textTheme.copyWith(
            headline1: TextStyle(
                fontFamily: 'HacenFreehand',
                fontSize: 37,
                color: Color(0xff604140)),
            headline2: TextStyle(
                fontFamily: 'HacenFreehand',
                fontSize: 25,
                color: Color(0xffffffff)),
            headline3: TextStyle(
                fontFamily: 'HacenFreehand',
                fontSize: 15,
                color: Color(0xff604140)),
            headline4: TextStyle(
                fontFamily: 'HacenFreehand',
                fontSize: 20,
                color: Color(0xff604140)),
            headline5: TextStyle(
                fontFamily: 'HacenFreehand',
                fontSize: 15,
                color: Color(0xffEDD5A9)),

          )),


      home:First(),
      routes: {
        MainScreen.routeName: (ctx) => BottomNavBar(),
        PageViews.routeName: (ctx) => PageViews(),
        Search.routeName:(ctx)=>Search()
      },
    );
  }
}

class First extends StatefulWidget {

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  bool isFirstTme = false;

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');
    if (firstTime != null && !firstTime) {
      setState(() {
        isFirstTme = false;
      }); // Not first time
      return navigationPageHome(context);
    } else {
      // First time
      prefs.setBool('first_time', false);
      setState(() {
        isFirstTme = true;
      });
      return navigationPageWel(context);
    }
  }

  void navigationPageHome(BuildContext context) {
    Navigator.pushReplacementNamed(context,MainScreen.routeName);
  }

  void navigationPageWel(BuildContext context) {
    Navigator.pushReplacementNamed(context,PageViews.routeName);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return  !isFirstTme ? BottomNavBar() : PageViews();
  }
}



class PageViews extends StatefulWidget {
  static var routeName = 'page-View';

  @override
  _PageViewsState createState() => _PageViewsState();
}

class _PageViewsState extends State<PageViews> {
  PageController pageController = PageController(initialPage: 0);

  Widget Pages(int count, String imageFile) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageFile),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Positioned(
                  bottom: 65,
                  right: 69,
                  child: Opacity(
                    opacity: 0.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (count <= 2) {
                          pageController.animateToPage(count,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.ease);
                        } else
                          Navigator.of(context).pushNamed(MainScreen.routeName);
                      },
                      padding:
                      EdgeInsets.symmetric(horizontal: 70.5, vertical: 7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(width: 1.5, color: Colors.white)),
                      child: new Text(
                        "تخطي",
                        style: TextStyle(fontSize: 30, color: Colors.pink),
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }


  @override
  Widget build(BuildContext context) {
    return PageView(
      pageSnapping: true,
      allowImplicitScrolling: true,
      controller: pageController,
      children: [
        Pages(1, 'assets/images/1_intro.jpg'),
        Pages(2, 'assets/images/2_intro.jpg'),
        Pages(3, 'assets/images/3_intro.jpg')
      ],
    );
  }
}

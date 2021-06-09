import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _sliding = 0;

  PageController _c = PageController(
    initialPage: 0
  );

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Color(0xfff1f1f1),
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible (
              flex: 4,
              child: Banner()
            ),
            Expanded (
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 15),
                decoration: BoxDecoration (
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Color(0xffe4e5e7)
                ),
                child: Stack(
                  children: [
                    GestureDetector(
                      onHorizontalDragUpdate: (DragUpdateDetails details) {
                        var change;
                        if (details.globalPosition.dx > (width / 2)) {
                          change = 1;
                        }
                        if (details.globalPosition.dx < (width / 2)) {
                          change = 0;
                        }
                        if (change != _sliding) {
                          setState(() {
                            _sliding = change;
                            _c.animateToPage(
                              _sliding, 
                              duration: Duration(milliseconds: 1200), 
                              curve: Curves.easeInOut
                            );
                          });
                        }
                      },
                      child: AnimatedContainer(
                        width: (width / 2) - 20,
                        height: double.infinity - 5,
                        margin: EdgeInsets.fromLTRB(_sliding == 0 ? 2.5 : (width / 2) - 20, 2.5, 2.5, 2.5),
                        decoration: BoxDecoration (
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Colors.white
                        ), 
                        duration: Duration(milliseconds: 200),
                      ),
                    ),
                    Container (
                      width: double.infinity,
                      height: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text (
                            "EVENTS",
                            style: TextStyle (
                              color: _sliding == 0 ? Color(0xff7eb5f3) : Color(0xffbabec9)
                            )
                          ),
                          Text(
                            "ABOUT",
                            style: TextStyle (
                              color: _sliding == 1 ? Color(0xff7eb5f3) : Color(0xffbabec9)
                            )
                          )
                        ],
                      )
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _sliding = _sliding == 0 ? 1 : 0;
                          _c.animateToPage(
                            _sliding, 
                            duration: Duration(milliseconds: 1200), 
                            curve: Curves.easeInOut
                          );
                        });
                      },
                      child: AnimatedContainer(
                        width: (width / 2) - 20,
                        height: double.infinity - 5,
                        margin: EdgeInsets.fromLTRB(_sliding == 1 ? 2.5 : 168, 2.5, 2.5, 2.5),
                        decoration: BoxDecoration (
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Colors.transparent
                        ), 
                        duration: Duration(seconds: 3),
                      ),
                    ),
                  ],
                )
              ),
            ),
            Flexible(
              flex: 4,
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: PageView (
                  physics: NeverScrollableScrollPhysics(),
                  controller: _c,
                  children: [
                    PageOne(),
                    PageTwo()
                  ],
                )
              )
            )
          ],
        ),
      )
    );
  }
}

class Banner extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container (
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 50, left: 30),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/banner.jpg"),
          fit: BoxFit.cover
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(
              3.0,
              3.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 5.0,
          ),
        ]
      ),
      child: Column (
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Metallica Worldwired Tour \n2020",
            style: TextStyle (
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white
            )
          ),
          Row (
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.white30,
                padding: EdgeInsets.fromLTRB(3, 1, 3, 1),
                child: Text(
                  "HEAVY METAL",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white
                  ),
                )
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                color: Colors.white30,
                padding: EdgeInsets.fromLTRB(3, 1, 3, 1),
                child: Text(
                  "TRASH METAL",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white
                  ),
                )
              )
            ],
          )
        ]
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container (
      margin: EdgeInsets.only(bottom: 40, right: 20),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About the event", 
            style: TextStyle(
              color: Color(0xffd0d1d4),
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(
            height: 10
          ),
          Text(
            "Metallica Worldwired", 
            style: TextStyle(
              color: Color(0xff6f7883),
              fontWeight: FontWeight.w700,
              fontSize: 23
            ),
          ),
          SizedBox(
            height: 15
          ),
          Text(
            "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora.",
            textAlign: TextAlign.left,
            style: TextStyle (
              color: Color(0xffbbbac0),
            )
          )
        ],
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container (
      margin: EdgeInsets.only(bottom: 30, right: 20),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "2 Upcoming Events", 
            style: TextStyle(
              color: Color(0xffd0d1d4),
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            "United Kingdom", 
            style: TextStyle(
              color: Color(0xff6f7883),
              fontWeight: FontWeight.w700,
              fontSize: 23
            ),
          ),
          Expanded (
            flex: 7,
            child: Container(
              height: double.maxFinite,
              width: double.infinity,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)
                ),
                child: ListView(
                  cacheExtent: 190,
                  children: [
                    Events(),
                    SizedBox(
                      height: 10
                    ),
                    Events(),
                    SizedBox(
                      height: 10
                    ),
                    Events(),
                    SizedBox(
                      height: 10
                    ),
                    Events(),
                    SizedBox(
                      height: 10
                    ),
                    Events(),
                    SizedBox(
                      height: 10
                    ),
                  ],
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}

class Events extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Row (
        children: [
          Expanded (
            flex: 3,
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "May 25",
                  style: TextStyle(
                    color: Color(0xff6f7883),
                    fontWeight: FontWeight.w700
                  ),
                ),
                Text(
                  "Thu",
                  style: TextStyle(
                    color: Color(0xffd0d1d4),
                    fontWeight: FontWeight.w500
                  ),
                )
              ]
            )
          ),
          Expanded (
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "4:30",
                  style: TextStyle(
                    color: Color(0xff6f7883),
                    fontWeight: FontWeight.w700
                  ),
                ),
                Text(
                  "PM",
                  style: TextStyle(
                    color: Color(0xffd0d1d4),
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            )
          ),
          Expanded (
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Manchester",
                  style: TextStyle(
                    color: Color(0xff6f7883),
                    fontWeight: FontWeight.w700
                  ),
                ),
                 Text(
                  "Etihad Stadium",
                  style: TextStyle(
                    color: Color(0xffd0d1d4),
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            )
          ),
          Expanded(
            flex: 1,
            child: Icon(
              Icons.navigate_next,
              color: Colors.blue
            )
          )
        ]  
      )
    );
  }
}
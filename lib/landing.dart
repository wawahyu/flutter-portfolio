import 'dart:html' as html;
import 'dart:math';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mycv/color.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool _darkMode = false;

  Widget circle({double height, double width}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: height ?? 0,
      width: width ?? 0,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(500),
        boxShadow: [
          BoxShadow(
            color:
                _darkMode ? lightShadeYellowColor : blueColor.withOpacity(0.1),
            offset: Offset(1, -3),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }

  Widget background() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Center(
            child: circle(
              height: 200 + MediaQuery.of(context).size.width * 10 / 100,
              width: 200 + MediaQuery.of(context).size.width * 10 / 100,
            ),
          ),
          Positioned(
            left: 60,
            bottom: 16,
            child: circle(
              height: 50,
              width: 50,
            ),
          ),
          Positioned(
            left: 50,
            top: MediaQuery.of(context).size.height * 45 / 100,
            child: circle(
              height: 30,
              width: 30,
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 35 / 100,
            top: MediaQuery.of(context).size.height * 70 / 100,
            child: circle(
              height: 15,
              width: 15,
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 80 / 100,
            top: MediaQuery.of(context).size.height * 60 / 100,
            child: circle(
              height: 70,
              width: 70,
            ),
          ),
        ],
      ),
    );
  }

  Widget greeting() {
    return Container(
      width: 132 + MediaQuery.of(context).size.width * 8 / 100,
      height: 82,
      child: Bubble(
        padding: BubbleEdges.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        elevation: 10,
        shadowColor: blueColor.withOpacity(0.2),

        // nip: BubbleNip.rightTop,
        color: Colors.white,
        child: Container(
          height: 50,
          width: 100 + MediaQuery.of(context).size.width * 8 / 100,
          child: Row(
            children: [
              Container(
                child: Image.asset(
                  'assets/icons/emojione-v1_waving-hand.png',
                  height: 45,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, I am',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(height: 4),
                      FittedBox(
                        child: Text(
                          'Wahyudin',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget picture() {
    return Container(
      height: 100 + MediaQuery.of(context).size.height * 50 / 100,
      width: 200,
      // color: Colors.blue.withOpacity(0.25),
      child: Image.asset(
        'assets/images/me2ex.png',
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget education() {
    List<Map<String, String>> educations = [
      {
        'logo': 'assets/icons/sttbandung.png',
        'name': 'Sekolah Tinggi Teknologi Bandung',
        'years': '2020 - PRESENT',
      },
      {
        'logo': 'assets/icons/smkn4.png',
        'name': 'Vocational High School 4 Bandung',
        'years': '2016 - 2019',
      },
    ];
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder<int>(
                stream: Stream.periodic(Duration(seconds: 5), (i) {
                  Random random = Random();
                  return random.nextInt(educations.length);
                }),
                builder: (context, snapshot) {
                  int index = 0;
                  if (snapshot.hasData && snapshot.data != null) {
                    index = snapshot.data;
                  }
                  return Stack(
                    overflow: Overflow.visible,
                    children: List.generate(educations.length, (i) {
                      return AnimatedPositioned(
                        top: _tabController.index == 2 && index == i
                            ? MediaQuery.of(context).size.width * 10 / 100
                            : -MediaQuery.of(context).size.height,
                        right: _tabController.index == 2
                            ? MediaQuery.of(context).size.width > 450
                                ? MediaQuery.of(context).size.width * 8 / 100
                                : 0
                            : -MediaQuery.of(context).size.width,
                        duration: Duration(milliseconds: 300),
                        child: Container(
                          width: MediaQuery.of(context).size.width > 450
                              ? 250 +
                                  MediaQuery.of(context).size.width * 10 / 100
                              : MediaQuery.of(context).size.width,
                          constraints: BoxConstraints(
                            minHeight: 60,
                            maxHeight: 100,
                          ),
                          child: Bubble(
                            // alignment: Alignment.topLeft,
                            padding: BubbleEdges.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            margin: BubbleEdges.only(top: 10),
                            elevation: 10,
                            shadowColor: blueColor.withOpacity(0.2),
                            color: Colors.white,
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Image.asset(
                                      educations[i]['logo'],
                                      height: 45,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              educations[i]['years'],
                                              style: TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                educations[i]['name'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget talk() {
    List<String> talk = [
      'Programmer can absolutely move without any reason.\nAnd so can I?',
      'Run the program again, and run again... \n#ah wait I almost saw the problem solving..arrgh\nOK try again.',
      "Talking about my dream? won't fit on this variable.",
      "Fullstack Developer, whether it's a program or a life. \nRemember this, can't do code if there's no life.",
      "Study has a long way of story and dream.",
      "Search, copy, paste and edit.\nSimple but still got error? that's problem."
    ];
    return StreamBuilder<int>(
      stream: Stream.periodic(Duration(seconds: 5), (i) {
        Random random = Random();
        return random.nextInt(talk.length);
      }),
      builder: (context, snapshot) {
        int index = 0;
        if (snapshot.hasData && snapshot.data != null) {
          index = snapshot.data;
        }
        return Container(
          width: MediaQuery.of(context).size.width > 450
              ? 450
              : MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.bottomCenter,
            children: List.generate(talk.length, (i) {
              return AnimatedPositioned(
                top: _tabController.index == 0 && index == i ? 50 : -450,
                duration: Duration(milliseconds: 300),
                child: Bubble(
                  elevation: 10,
                  shadowColor: blueColor.withOpacity(0.2),
                  color: Colors.white,
                  margin: BubbleEdges.only(top: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width > 300
                        ? 300
                        : MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width > 300
                          ? 300
                          : MediaQuery.of(context).size.width - 20,
                      maxWidth: MediaQuery.of(context).size.width > 450
                          ? 450
                          : MediaQuery.of(context).size.width,
                    ),
                    child: Text(talk[i]),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Widget profile() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          if (MediaQuery.of(context).size.height > 400)
            Positioned(
              top: 50,
              child: Container(
                height: MediaQuery.of(context).size.height * 25 / 100,
                child: talk(),
              ),
            ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 75 / 100,
              width: MediaQuery.of(context).size.width,
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    child: greeting(),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: picture(),
                  ),
                  Flexible(
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget social() {
    return Container(
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 45,
            width: 45,
            child: InkWell(
              onTap: () {
                launch('https://www.facebook.com/yuudinwah/');
              },
              child: Icon(
                FontAwesome5Brands.facebook,
                color: !_darkMode ? Colors.grey[700] : lightShadeYellowColor,
              ),
            ),
          ),
          Container(
            height: 45,
            width: 45,
            child: InkWell(
              onTap: () {
                launch('https://www.instagram.com/yuudinwah/');
              },
              child: Icon(
                FontAwesome5Brands.instagram,
                color: !_darkMode ? Colors.grey[700] : lightShadeYellowColor,
              ),
            ),
          ),
          Container(
            height: 45,
            width: 45,
            child: InkWell(
              onTap: () {
                launch('https://twitter.com/yuudinwah');
              },
              child: Icon(
                FontAwesome5Brands.twitter,
                color: !_darkMode ? Colors.grey[700] : lightShadeYellowColor,
              ),
            ),
          ),
          Container(
            height: 45,
            width: 45,
            child: InkWell(
              onTap: () {
                launch('https://github.com/yuudinwah');
              },
              child: Icon(
                FontAwesome5Brands.github,
                color: !_darkMode ? Colors.grey[700] : lightShadeYellowColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    if (DateTime.now().isAfter(DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 18, 0, 0)) ||
        DateTime.now().isBefore(DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 6, 0, 0))) {
      _darkMode = true;
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          color: _darkMode ? Colors.grey[700] : lightShadeYellowColor,
          child: Column(
            children: [
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  onTap: (index) {
                    setState(() {});
                  },
                  labelColor: blueColor,
                  indicatorColor: blueColor,
                  unselectedLabelColor: blueColor.withOpacity(0.75),
                  tabs: [
                    Tab(
                      text: 'About Me',
                    ),
                    Tab(
                      text: 'Skill',
                    ),
                    Tab(
                      text: 'Education',
                    ),
                    // Tab(
                    //   text: 'Trainings',
                    // ),
                    // Tab(
                    //   text: 'Experience',
                    // ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      background(),
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: _tabController.index == 1
                            ? 0
                            : MediaQuery.of(context).size.height,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                right: MediaQuery.of(context).size.width *
                                    20 /
                                    100,
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  height: 150,
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Image(
                                    image: AssetImage(
                                      'assets/icons/Android_Robot.png',
                                    ),
                                    height: 80,
                                    width: 80,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(120),
                                    color: _darkMode
                                        ? Colors.grey[700]
                                        : lightShadeYellowColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue[100],
                                        offset: Offset(1, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.width *
                                    10 /
                                    100,
                                right:
                                    MediaQuery.of(context).size.width * 4 / 100,
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  height: MediaQuery.of(context).size.width *
                                      18 /
                                      100,
                                  width: MediaQuery.of(context).size.width *
                                      18 /
                                      100,
                                  constraints: BoxConstraints(
                                    maxHeight: 150,
                                    maxWidth: 150,
                                    minWidth: 120,
                                    minHeight: 120,
                                  ),
                                  alignment: Alignment.center,
                                  child: FlutterLogo(
                                    size: 60,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(120),
                                    color: _darkMode
                                        ? Colors.grey[700]
                                        : lightShadeYellowColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue[100],
                                        offset: Offset(1, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: MediaQuery.of(context).size.height *
                                    23 /
                                    100,
                                right: 80 +
                                    MediaQuery.of(context).size.width *
                                        25 /
                                        100,
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  height: 120,
                                  width: 120,
                                  alignment: Alignment.center,
                                  child: Image(
                                    image: AssetImage(
                                      'assets/icons/bi_code-slash.png',
                                    ),
                                    height: 60,
                                    width: 60,
                                    color: _darkMode
                                        ? lightShadeYellowColor
                                        : Colors.grey[700],
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(120),
                                    color: _darkMode
                                        ? Colors.grey[700]
                                        : lightShadeYellowColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue[100],
                                        offset: Offset(1, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: _tabController.index == 2
                            ? 0
                            : -MediaQuery.of(context).size.height,
                        child: education(),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: profile(),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: social(),
                      ),
                      Positioned(
                        top: 0,
                        right: 20,
                        child: InkWell(
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              _darkMode = !_darkMode;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            height: 60,
                            width: 60,
                            child: Icon(
                              _darkMode
                                  ? Icons.nightlight_round
                                  : Icons.wb_sunny,
                              color: _darkMode
                                  ? lightShadeYellowColor
                                  : Colors.grey[400],
                            ),
                            decoration: BoxDecoration(
                              color: _darkMode
                                  ? Colors.grey[700]
                                  : lightShadeYellowColor,
                              borderRadius: BorderRadius.circular(200),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[100],
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   child: Stack(
              //     children: [

              //       AnimatedPositioned(
              //         duration: Duration(milliseconds: 300),
              //         top: 0,
              //         child: Container(
              //           height: MediaQuery.of(context).size.height,
              //           width: MediaQuery.of(context).size.width,
              //           child: Row(
              //             children: [
              //               Expanded(
              //                 child: Container(
              //                   child: Stack(
              //                     overflow: Overflow.visible,
              //                     alignment: Alignment.center,
              //                     children: [
              //                       Positioned(
              //                         right: -50,
              //                         child: Container(
              //                           constraints: BoxConstraints(
              //                             maxWidth:
              //                                 ((MediaQuery.of(context).size.width -
              //                                             450) /
              //                                         2) -
              //                                     20,
              //                                     minWidth: 120,
              //                           ),

              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               Container(
              //                 width: 450,
              //                 padding: EdgeInsets.only(
              //                   bottom: 450,
              //                 ),
              //                 height: MediaQuery.of(context).size.height,
              //                 child: Stack(
              //                   alignment: Alignment.center,
              //                   children: [],
              //                 ),
              //               ),
              //               Expanded(
              //                 child: Container(
              //                   child: Stack(
              //                     overflow: Overflow.visible,
              //                     alignment: Alignment.center,
              //                     children: [],
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),

              //       Positioned(
              //         bottom: 0,
              //         child: Container(
              //           width: MediaQuery.of(context).size.width,
              //           child: Center(

              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import '../constants/string_constants.dart';
import '../widgets/text_widget.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<dynamic> fetchData() async {
    final response = await http.get(
      Uri.parse(
        'https://www.randomnumberapi.com/api/v1.0/random?min=100&max=1000&count=1',
      ),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('No Data');
    }
  }

  double value = 0;
  @override
  void initState() {
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        setState(
          () {
            fetchData();
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/baby_picture.jpg'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextWidget(
                  StringConstants.title,
                  Colors.white,
                  14,
                  FontWeight.bold,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 32,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/person_two.jpeg'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextWidget(
                        "War and Peace",
                        Colors.white,
                        14,
                        FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                const Card(
                  color: Colors.grey,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Card(
              color: Colors.orangeAccent,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        TextWidget(
                          "PROGRESS",
                          Colors.black,
                          14,
                          FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.menu_book,
                          size: 32,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FutureBuilder<dynamic>(
                          future: fetchData(),
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              value = snapshot.data[0].toDouble();
                            }
                            if (snapshot.hasData) {
                              return TextWidget(
                                "${snapshot.data[0]}",
                                Colors.black,
                                32,
                                FontWeight.bold,
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              TextWidget(
                                "Out of 1225 pages",
                                null,
                                null,
                                null,
                              ),
                              TextWidget(
                                "#5 among friends",
                                Colors.black,
                                null,
                                FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  GFProgressBar(
                    percentage: value == null ? 0 : (value / 1225),
                    backgroundColor: Colors.white,
                    progressBarColor: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        imageWidget("assets/images/baby_picture.jpg"),
                        imageWidget("assets/images/person_two.jpeg"),
                        imageWidget("assets/images/person_three.jpeg"),
                        imageWidget("assets/images/person_four.jpeg"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                cardWidget(
                    "6:24",
                    const Icon(Icons.lock_clock),
                    "Global avg. read time for your progress 7:28 23 percent faster",
                    Colors.deepOrange[400]),
                const SizedBox(
                  width: 10,
                ),
                cardWidget(
                    "7",
                    const Icon(Icons.account_tree),
                    "Day streak, come back tomorrow to keep it up: 90 percent more consistent",
                    Colors.lightGreen),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                cardWidget(
                    "2",
                    const Icon(Icons.ac_unit_outlined),
                    "145 reader points to level up factorial top 5 percent for all this book",
                    Colors.purple[200]),
                const SizedBox(
                  width: 10,
                ),
                cardWidgetIcons(
                  Colors.lightBlueAccent,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextWidget(
                              "Add friends",
                              Colors.white,
                              null,
                              FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Card(
                  color: Colors.grey,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.upload,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget cardWidget(String time, Icon icon, String data, Color? color) {
    return Expanded(
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    'Time',
                    Colors.black,
                    12,
                    FontWeight.bold,
                  ),
                  Card(
                    color: color,
                    elevation: 2,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.upload,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  icon,
                  const SizedBox(
                    width: 8,
                  ),
                  TextWidget(
                    time,
                    Colors.black,
                    32,
                    FontWeight.bold,
                  ),
                ],
              ),
              TextWidget(
                data,
                null,
                10,
                null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardWidgetIcons(Color? color) {
    return Expanded(
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    'Time',
                    Colors.black,
                    12,
                    FontWeight.bold,
                  ),
                  Card(
                    color: color,
                    elevation: 2,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.upload,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.add_alarm_rounded),
                    Icon(Icons.check_circle_outline),
                    Icon(Icons.ac_unit),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.sim_card_download_outlined),
                    Icon(Icons.menu_book),
                    Icon(Icons.badge_rounded),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageWidget(String imageUrl) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.fill,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}

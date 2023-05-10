import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Information extends StatefulWidget {
  final String link;

  const Information({
    required this.link,
    Key? key,
  }) : super(key: key);

  @override
  State<Information> createState() => _InformationState(link);
}

class _InformationState extends State<Information> {
  String link = '';
  double sizeImage = 60;

  List<dynamic> info = [];

  getInfo() async {
    Response response = await get(
      Uri.parse('https://test.alnefely.tk/match?url=$link'),
    );
    var jsonResponse = jsonDecode(response.body);

    setState(() {
      info.addAll(jsonResponse);
    });
  }

  Color stateColor(val) {
    if (val == "مباشر") {
      return Colors.red;
    }
    if (val == "بعد قليل") {
      return const Color(0xff01a3a4);
    }
    if (val == "انتهت") {
      return const Color(0xff341f97);
    }
    return Colors.grey;
  }

  @override
  void initState() {
    // TODO: implement initState
    getInfo();
    super.initState();
  }

  _InformationState(this.link);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(),
          body: RefreshIndicator(
            child: info.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.95,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff273c75),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            child: Text(
                              info[0]['name'],
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.95,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 5, color: Colors.black12)
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15),
                                                child: Image.network(
                                                  info[0]['team_a_img'],
                                                  height: sizeImage,
                                                  width: sizeImage,
                                                ),
                                              ),
                                              Text(
                                                info[0]['team_a_name'],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(children: [
                                            Container(
                                              // color: Color.fromARGB(250, 197, 25, 97),
                                              color:
                                                  stateColor(info[0]['status']),
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.all(8),

                                              child: Text(
                                                info[0]['status'],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '${info[0]["team_a_score"]} : ${info[0]["team_b_score"]}',
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.teal),
                                                ),
                                              ],
                                            )
                                          ]),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15),
                                                child: Image.network(
                                                  info[0]['team_b_img'],
                                                  height: sizeImage,
                                                  width: sizeImage,
                                                ),
                                              ),
                                              Text(
                                                info[0]['team_b_name'],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      decoration: const BoxDecoration(
                                        color: Colors.black12,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              info[0]['team_a_coach'],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                              flex: 1, child: Text('')),
                                          // const Expanded(flex: 1, child: Text('')),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              info[0]['team_b_coach'],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      color: Colors.black12,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                for (var goalA in info[0]
                                                    ['team_a_results'])
                                                  Text(
                                                    goalA,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.indigo,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                for (var goalB in info[0]
                                                    ['team_b_results'])
                                                  Text(
                                                    goalB,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.indigo,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      padding: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          for (var info in info[0]['info'])
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: Text(
                                                info,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.teal),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
            onRefresh: () {
              setState(() {
                info.clear();
              });
              return getInfo();
            },
          )),
    );
  }
}

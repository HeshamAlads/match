// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:match/information.dart';

class Matchs extends StatefulWidget {
  const Matchs({Key? key}) : super(key: key);

  @override
  State<Matchs> createState() => _MatchsState();
}

class _MatchsState extends State<Matchs> {
  double sizeImage = 60;
  DateTime selectedDate = DateTime.now();

  List<dynamic> data = [];

  getMyData() async {
    Response response = await get(
      Uri.parse('https://test.alnefely.tk/matches?date=$selectedDate'),
    );
    var jsonResponse = jsonDecode(response.body);
    data.clear();
    setState(() {
      data.addAll(jsonResponse);
    });
  }

  Color stateColor(val) {
    if (val == "مباشر") {
      return Colors.red;
    }
    if (val == "بعد قليل") {
      return Color(0xff01a3a4);
    }
    if (val == "انتهت") {
      return Color(0xff341f97);
    }
    return Colors.grey;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        data.clear();
        selectedDate = picked;
        getMyData();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getMyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff222f3e),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _selectDate(context);
          },
          icon: Icon(Icons.access_alarm_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _selectDate(context);
            },
            icon: Icon(Icons.access_alarm_outlined),
          ),
        ],
        title: Text(
          'جدول مباريات ${selectedDate.toString().substring(0, 10)}',
        ),
        centerTitle: true,
      ),

      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            data.clear();
          });

          return getMyData();
        },
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: data.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      valueColor: AlwaysStoppedAnimation(
                        Colors.purple,
                      ),
                      backgroundColor: Colors.teal,
                    ),
                  )
                : ListView.builder(
                    // physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          FractionallySizedBox(
                            widthFactor: 0.95,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff273c75),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Text(
                                data[index]['name'],
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          for (var card in data[index]['matches'])
                            InkWell(
                              onTap: () {
                                debugPrint(card["link"]);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        Information(link: card["link"])));
                              },
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
                                              blurRadius: 5,
                                              color: Colors.black12)
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
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: Image.network(
                                                        card['team_a_img'],
                                                        height: sizeImage,
                                                        width: sizeImage,
                                                      ),
                                                    ),
                                                    Text(
                                                      card['team_a_name'],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(children: [
                                                  Container(
                                                    // color: Color.fromARGB(250, 197, 25, 97),
                                                    color: stateColor(
                                                        card['status']),
                                                    padding: EdgeInsets.all(8),
                                                    margin: EdgeInsets.all(8),

                                                    child: Text(
                                                      card['status'],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        '${card["team_a_score"]} : ${card["team_b_score"]}',
                                                        style: TextStyle(
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
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: Image.network(
                                                        card['team_b_img'],
                                                        height: sizeImage,
                                                        width: sizeImage,
                                                      ),
                                                    ),
                                                    Text(
                                                      card['team_b_name'],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            padding: EdgeInsets.all(10),
                                            width: double.infinity,
                                            child: Text(
                                              card['time'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.teal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
          ),
        ),
      ),
    );
  }
}

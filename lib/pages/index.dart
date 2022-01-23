import 'dart:convert';
import 'package:app/model/data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int currentPage = 1;
  List<JakeData> dataList = [];
  @override
  void initState() {
    super.initState();
    this.getJakeData();
  }

  Future<bool> getJakeData() async {
    print("fetching....");
    var url = Uri.parse(
        "https://api.github.com/users/JakeWharton/repos?page=1&per_page=15");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final result = jakeDataFromJson(response.body.toString());
      print(response.body);
      dataList = result;
      currentPage++;
      return true;
    } else {
      print("false");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Jake's Git"),
      ),
      body: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 0),
          itemBuilder: (context, index) {
            final data = dataList[index];
            bool lang = true;
            if (data.language == null) {
              print("object");
              data.language = "";
              lang = false;
            }
            if (data.watchersCount == null) {
              data.watchersCount = 0;
            }
            if (data.openIssues == null) {
              data.openIssues = 0;
            }
            return Card(
              child: ListTile(
                title: Row(
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 17),
                        child: Icon(
                          FontAwesomeIcons.solidBookmark,
                          color: Colors.white,
                          //textDirection: TextDirection.ltr,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 260,
                          child: Text(
                            data.name!,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 260,
                          child: Text(
                            data.description!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible: lang,
                              child: Row(
                                children: [
                                  Icon(FontAwesomeIcons.exchangeAlt, size: 18),
                                  Text(data.language!),
                                ],
                              ),
                            ),
                            SizedBox(width: 35),
                            Icon(FontAwesomeIcons.bug, size: 18),
                            Text(data.openIssues.toString()),
                            SizedBox(width: 35),
                            Icon(FontAwesomeIcons.userAlt, size: 18),
                            Text(data.openIssues.toString()),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: dataList.length),
    );
  }

  // Widget getBody() {
  //   List items = ["1", "2"];
  //   return ListView.builder(
  //       itemCount: dataList.length,
  //       itemBuilder: (context, index) {
  //         return getCard(index);
  //       });
  // }

  // Widget getCard(index) {
  //   var fullName = index['name'];
  //   var description = index['description'];
  //   var language = index['language'];
  //   var watchersCount = index['watchers_count'];
  //   var forksCount = index['open_issues'];
  //   bool lang = true;
  //   if (language == null) {
  //     language = "";
  //     lang = false;
  //   }
  //   if (watchersCount == null) {
  //     watchersCount = 0;
  //   }
  //   if (forksCount == null) {
  //     forksCount = 0;
  //   }
  //   return Card(
  //     child: ListTile(
  //       title: Row(
  //         children: <Widget>[
  //           Container(
  //             width: 40,
  //             height: 50,
  //             decoration: BoxDecoration(
  //               color: Colors.black,
  //               borderRadius: BorderRadius.all(Radius.circular(4.0)),
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.fromLTRB(0, 0, 15, 17),
  //               child: Icon(
  //                 FontAwesomeIcons.solidBookmark,
  //                 color: Colors.white,
  //                 //textDirection: TextDirection.ltr,
  //                 size: 20,
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             width: 10,
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Container(
  //                 width: 260,
  //                 child: Text(
  //                   fullName,
  //                   overflow: TextOverflow.visible,
  //                   style: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Container(
  //                 width: 260,
  //                 child: Text(
  //                   description,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: TextStyle(
  //                     color: Colors.grey,
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Row(
  //                 children: [
  //                   Visibility(
  //                     visible: lang,
  //                     child: Row(
  //                       children: [
  //                         Icon(FontAwesomeIcons.exchangeAlt, size: 18),
  //                         Text(language),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(width: 35),
  //                   Icon(FontAwesomeIcons.bug, size: 18),
  //                   Text("8"),
  //                   SizedBox(width: 35),
  //                   Icon(FontAwesomeIcons.userAlt, size: 18),
  //                   Text("10"),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  //}
}

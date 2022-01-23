import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List users = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    print("fetching....");
    var url = Uri.parse(
        "https://api.github.com/users/JakeWharton/repos?page=1&per_page=15");
    var response = await http.get(url as Uri);
    if (response.statusCode == 200) {
      var items = json.decode(response.body) as List;
      setState(() {
        users = items;
      });
      print(items);
    } else {
      setState(() {
        users = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Jake's Git"),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    List items = ["1", "2"];
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return getCard(users[index]);
        });
  }

  Widget getCard(index) {
    var fullName = index['name'];
    var description = index['description'];
    var language = index['language'];
    var watchersCount = index['watchers_count'];
    var forksCount = index['open_issues'];
    bool lang = true;
    if (language == null) {
      language = "";
      lang = false;
    }
    if (watchersCount == null) {
      watchersCount = 0;
    }
    if (forksCount == null) {
      forksCount = 0;
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
                    fullName,
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
                    description,
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
                          Text(language),
                        ],
                      ),
                    ),
                    SizedBox(width: 35),
                    Icon(FontAwesomeIcons.bug, size: 18),
                    Text("8"),
                    SizedBox(width: 35),
                    Icon(FontAwesomeIcons.userAlt, size: 18),
                    Text("10"),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

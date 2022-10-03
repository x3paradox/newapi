import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newapi/Model/userlist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserList> userList = [];
  Future<List<UserList>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (dynamic i in data) {
        userList.add(UserList.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: (context, AsyncSnapshot<List<UserList>> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ReRaw(
                                      titel: 'Name',
                                      value: (snapshot.data![index].name
                                          .toString())),
                                  ReRaw(
                                      titel: 'UserName',
                                      value: (snapshot.data![index].username
                                          .toString())),
                                  ReRaw(
                                      titel: 'UserName',
                                      value: (snapshot.data![index].email
                                          .toString())),
                                  ReRaw(
                                      titel: 'Address',
                                      value: (snapshot
                                          .data![index].address!.geo!.lat
                                          .toString()))
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class ReRaw extends StatelessWidget {
  String titel, value;
  ReRaw({Key? key, required this.titel, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(titel), Text(value)],
      ),
    );
  }
}

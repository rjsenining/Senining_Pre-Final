import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/profile.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
final String baseUrl = "https://jsonplaceholder.typicode.com/todos";

class _HomeScreenState extends State<HomeScreen> {
  Model model;
  BuildContext context;
  deleteTodo(var object) async {
    var url = Uri.parse('$baseUrl/${object["id"]}');
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Successfully deleted ToDo: ${object["title"]} ID: ${object["id"]}');
    } else {
      return null;
    }
  }
  Future<List<dynamic>> getData() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);

    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Parse the data and build the UI
            List<dynamic> data = snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('UserId: ${data[index]['userId']}',
                    ),
                    Text('Id: ${data[index]['id']}',
                    ),
                    Text('Title: ${data[index]['title']}',
                    ),
                    Text('Body: ${data[index]['body']}',
                    ),
                    Text('Completed: ${data[index]['completed']}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Warning"),
                                    content: Text("Are you sure want to delete data profile ${data[index]['title']}?"),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: Text("Yes"),
                                        onPressed: () {
                                          setState(() {
                                            deleteTodo(data[index]);
                                            data.removeAt(index);
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ElevatedButton(
                                        child: Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            // Show an error message
            return Text("${snapshot.error}");
          }
          // Show a loading indicator while the data is being fetched
          return CircularProgressIndicator();
        },
      )
    );
  }
}

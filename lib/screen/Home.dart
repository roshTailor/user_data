import 'package:flutter/material.dart';
import 'package:user_data/services/http_services.dart';
import 'package:user_data/util/apiUtil.dart';

import '../model/user_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HttpService httpService = HttpService();

  @override
  void initState() {
    // TODO: implement initState
    httpService.getMultipleData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random User Data"),
      ),
      body: Column(
        children: [
          FutureBuilder<List<Result>>(
              future: httpService.getMultipleData(),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  List<Result> data = snapShot.data!;
                  return Column(
                    children: [
                      TextFormField(
                        controller: ApiString.user,
                        onChanged: (val) {
                          ApiString.user.text = val;
                        },
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text("${data[index].name!.title} ${data[index].name!.first} ${data[index].name!.last}"),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage("${data[index].picture!.thumbnail}"),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }
}

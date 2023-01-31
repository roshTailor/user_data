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
        backgroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                hintText: "Enter number of user here",
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xff777777),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.all(12),
                fillColor: Colors.white,

              ),

              onChanged: (val){
                setState(() {
                  ApiString.user = val;
                });
              },
            ),
            Expanded(
              child: FutureBuilder<List<Result>>(
                  future: httpService.getMultipleData(),
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      List<Result> data = snapShot.data!;
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      title: Text("Name : ${data[index].name!.title} ${data[index].name!.first} ${data[index].name!.last}"),
                                      subtitle: Text("Email : ${data[index].email!}"),
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage("${data[index].picture!.thumbnail}"),
                                      ),
                                      onTap: (){
                                        Navigator.pushNamed(context,'userDetails',arguments: data);
                                      },
                                      tileColor: Colors.white,
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white70,
    );
  }
}

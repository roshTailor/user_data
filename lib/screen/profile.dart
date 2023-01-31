import 'package:flutter/material.dart';

import '../model/multi_data.dart';
import '../services/http_services.dart';
import '../util/apiUtil.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final HttpService httpService = HttpService();
@override
  void initState() {
    // TODO: implement initState
    httpService.getMultipleData();
  }
  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(
        children: [
          FutureBuilder<List<Result>>(
            //future: httpService.getMultipleData(),
            builder: (context,snapShot){
              if(snapShot.hasData){
                return Text("${snapShot.data![index].name!.first}");
              }
                else
                  {
                    return const CircularProgressIndicator();
                  }
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:jomhack/services/api_service.dart';
import 'package:jomhack/services/auth_service.dart';
import 'package:jomhack/templates/custom_widgets.dart';
import 'package:provider/provider.dart';

import '../../models/provider.dart';
import '../../models/user.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(4, 9, 35, 1),
                Color.fromRGBO(39, 105, 171, 1),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                    ],
                  ),

                  Text(
                    'My Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                    ),
                  ),

                  SizedBox(
                    height: 22,
                  ),

                  Container(
                    height: height * 0.6,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: innerHeight * 1,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [

                                    FutureBuilder<Map>(
                                    future: APIService.getUserData(),
                                      builder: (context,snapshot) {
                                      print(snapshot.data);
                                      if(snapshot.hasData) {
                                        return Container(
                                        height: 300,
                                        child: new ListView.builder(
                                        itemCount: snapshot.data?.length,
                                        itemBuilder: (BuildContext context, int index) {
                                        String key = snapshot.data?.keys.elementAt(index);

                                        return new Column(
                                        children: <Widget>[
                                        new ListTile(
                                        title: new Text("$key"),
                                        subtitle: new Text("${snapshot.data?[key]}"),
                                        ),
                                        new Divider(
                                        height: 2.0,
                                        ),
                                          ],
                                        );
                                        },
                                        ),
                                        );
} else {
    return const Center(
    child: Text('No Data Found'),
    );


    };})],
                                ),
                              ),
                            ),

                          ],
                        );
                      },
                    ),
                  ),

                  customTextButton(
                    label: 'Logout',
                      onPressed: () {
                    AuthService auth = Provider.of(context, listen: false);

                    auth.logout();
                      },
                      ),


                ],
              ),
            ),
          ),
        )
      ],
    );

  }
}


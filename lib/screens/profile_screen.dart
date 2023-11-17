import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfilePage createState() => ProfilePage();
}

class ProfilePage extends State<Profile> {
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final User? user1 = auth.currentUser;
    debugPrint(user1.toString());
    setState(() {
      // user = user1!;
    });
    return user;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(
          'profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: width / 6,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Flexible(
                              child: Padding(
                            padding: EdgeInsets.only(
                              left: width / 70,
                            ),
                            child: Icon(Icons.account_circle_rounded),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: width / 1.7,
                        height: height / 12,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Flexible(
                            child: Column(children: [
                              Text(
                                user!.displayName.toString(),
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              Text(user!.email.toString(),
                                  style:
                                      Theme.of(context).textTheme.displayMedium)
                            ]),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width / 6,
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Flexible(
                              child: Padding(
                                  padding: EdgeInsets.only(right: width * .001),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(IconData(0xe21a,
                                        fontFamily: 'MaterialIcons')),
                                  )),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

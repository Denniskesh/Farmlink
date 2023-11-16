import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfilePage createState() => ProfilePage();
}

class ProfilePage extends State<Profile> {
  late User user;
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user1 = auth.currentUser;
    debugPrint(user.toString());
    setState(() {
      user = user1!;
    });
    return user;
  }

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.account_circle_rounded),
                    Text(user.displayName.toString())
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

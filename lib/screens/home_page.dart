import 'package:farmlink/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  //final GoogleMapController googleMapController;
  const HomePage({
    super.key,

    ///required this.googleMapController,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController googleMapController;
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  //set an initial location of the Map
  final CameraPosition _initialCameraPosition =
      const CameraPosition(target: LatLng(20.5937, 78.9629));

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser!;

    return Container(
      height: height,
      width: width,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Welcome Back: ${user.email!}',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: signOut,
              icon: const Icon(Icons.account_circle_rounded),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: _initialCameraPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController c) {
                // to control the camera position of the map
                googleMapController = c;
              },
            ),
          ],
        ),
        //body: IndexedStack(index: widget.currentTab, children: pages),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor:
              Theme.of(context).textSelectionTheme.selectionColor,
          //currentIndex: widget.currentTab,
          onTap: (index) {
            //Provider.of<AppStateManager>(context, listen: false).goToTab(index);
            // context.goNamed(
            // 'home',
            //  pathParameters: {
            //  'tab': '$index',
            // },
            // );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'My Equipment',
            ),
          ],
        ),
      ),
    );
  }

  Widget profileButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            'assets/profile_pics/person_stef.jpeg',
          ),
        ),
        onTap: () {
          //context.goNamed(
          //  'profile',
          // pathParameters: {
          // 'tab': '$currentTab',
        },
      ),
    );
  }
}

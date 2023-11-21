import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlink/models/equipment_model.dart';
import 'package:farmlink/screens/bookings_screen.dart';
import 'package:farmlink/screens/imgs.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:farmlink/screens/equipment_list_screen.dart';
import 'package:farmlink/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'profile_screen.dart';

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
  static const List<String> choices = <String>[
    'Profile',
    'Logout',
  ];
  static const String prefSearchKey = 'previousSearches';

  late TextEditingController searchTextController;
  final ScrollController _scrollController = ScrollController();
  late GoogleMapController mapController;
  //List<APIHits> currentSearchList = [];
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 20;
  int pageCount = 20;
  bool hasMore = false;
  bool loading = false;
  bool inErrorState = false;
  List<String> previousSearches = <String>[];

  @override
  void initState() {
    super.initState();
    getPreviousSearches();

    searchTextController = TextEditingController(text: '');
    _scrollController.addListener(() {
      final triggerFetchMoreSize =
          0.7 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        if (hasMore &&
            currentEndPosition < currentCount &&
            !loading &&
            !inErrorState) {
          setState(() {
            loading = true;
            currentStartPosition = currentEndPosition;
          });
        }
      }
    });
  }

  Future<QuerySnapshot> getImages() {
    return FirebaseFirestore.instance.collection("equipment").get();
  }

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  void savePreviousSearches() async {
    //final prefs = await SharedPreferences.getInstance();
    // prefs.setStringList(prefSearchKey, previousSearches);
  }

  void getPreviousSearches() async {
    // final prefs = await SharedPreferences.getInstance();
    // if (prefs.containsKey(prefSearchKey)) {
    //// final searches = prefs.getStringList(prefSearchKey);
    //  if (searches != null) {
    //   previousSearches = searches;
    //  } else {
    ////   previousSearches = <String>[];
//}
  }

  //set an initial location of the Map
  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(-1.286389, 36.817223),
    zoom: 6.0,
  );
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  // Add a Set to hold markers on the map
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser!;

    _markers.add(
      const Marker(
        markerId: MarkerId("Nairobi"),
        position: LatLng(-1.286389, 36.817223),
        infoWindow: InfoWindow(title: "Nairobi, Kenya"),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    return SizedBox(
      height: height,
      width: width,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Welcome Back',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            PopupMenuButton<String>(
                icon: const Icon(
                  Icons.account_circle_rounded,
                  size: 30,
                ),
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return choices.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: const Icon(Icons.message),
          onPressed: () {
            dynamic conversationObject = {
              'appId': '1fb033be681109b15377676f20730a3c9',
            };
            KommunicateFlutterPlugin.buildConversation(conversationObject)
                .then((clientConversationId) {
              print("Conversation builder success : " +
                  clientConversationId.toString());
            }).catchError((error) {
              print("Conversation builder error : " + error.toString());
            });
          },
        ),
        body: Stack(
          children: <Widget>[
            Expanded(
              child: GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  mapType: MapType.normal,
                  zoomGesturesEnabled: true,
                  markers: _markers,
                  zoomControlsEnabled: true,
                  onCameraMove: (CameraPosition position) {
                    // Constrain the camera position to keep the view within Kenya's boundaries
                    if (position.target.latitude < -4.6751 ||
                        position.target.latitude > 4.6225 ||
                        position.target.longitude < 33.9072 ||
                        position.target.longitude > 41.8994) {
                      mapController.animateCamera(
                          CameraUpdate.newLatLng(LatLng(-1.286389, 36.817223)));
                    }
                  },
                  onMapCreated: _onMapCreated),
            ),
            _buildSearchCard(),
            _buildEquipmentLoader(context),
            Positioned(
                bottom: MediaQuery.of(context).size.height / 3,
                right: 10,
                left: 10,
                child: _buildHireButton()),
            // Positioned(
            //  top: 200,
            // left: 10,
            // right: 10,
            // child: ElevatedButton(
            // onPressed: () {
            //  Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (context) {
            //   return const EquipmentListPage();
            //  }));
            //},
            // child: const Text('explore')),
            //),
            Positioned(bottom: 0, child: buildExploreCard()),
          ],
        ),
      ),
    );
  }

  Widget buildExploreCard() {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Explore',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const EquipmentListPage();
                      }));
                    },
                    child: const Text('See All',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
                  )
                ],
              ),
              FutureBuilder(
                  future: getImages(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        final orders = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs
                              .length, // Replace with the actual length of your image list
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(
                                  8.0), // Adjust spacing as needed
                              child: Image.network(
                                orders.docs[index].get('imageUrl'),
                                fit: BoxFit
                                    .fill, // Replace with the actual URL from Firebase for your image
                                width: 100, // Adjust the width as needed
                                height: 100, // Adjust the height as needed
                              ),
                            );
                          },
                        );
                      }
                    }
                    return const CircularProgressIndicator();
                  }),
            ],
          ),
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

  Widget _buildHireButton() {
    var width = MediaQuery.of(context).size.width;
    return Center(
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const Images();
          }));
          // await Navigator.push(context, MaterialPageRoute(builder: (_) {
          //   return const BookingsPage();
          // }));
        },
        child: Container(
          width: width,
          padding: const EdgeInsets.all(10),
          // height: 50,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Text(
              'Hire Equipment',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                startSearch(searchTextController.text);
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            ),
            const SizedBox(
              width: 6.0,
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                    ),
                    autofocus: false,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      startSearch(searchTextController.text);
                    },
                    controller: searchTextController,
                  )),
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    onSelected: (String value) {
                      searchTextController.text = value;
                      startSearch(searchTextController.text);
                    },
                    itemBuilder: (BuildContext context) {
                      return List.empty();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startSearch(String value) {
    setState(() {
      //currentSearchList.clear();
      currentCount = 0;
      currentEndPosition = pageCount;
      currentStartPosition = 0;
      hasMore = true;
      value = value.trim();
      if (!previousSearches.contains(value)) {
        previousSearches.add(value);
        savePreviousSearches();
      }
    });
  }

  Widget _buildEquipmentLoader(BuildContext context) {
    if (searchTextController.text.length < 3) {
      return Container();
    }
    return const Placeholder();
  }

  void choiceAction(String value) async {
    if (value == 'Logout') {
      signOut();
    } else if (value == 'Profile') {
      await Navigator.push(context, MaterialPageRoute(builder: (_) {
        return const Profile();
      }));
    }
  }
}

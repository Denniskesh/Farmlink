import 'package:farmlink/components/my_button.dart';
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

  static const String prefSearchKey = 'previousSearches';

  late TextEditingController searchTextController;
  final ScrollController _scrollController = ScrollController();
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
  final CameraPosition _initialCameraPosition =
      const CameraPosition(target: LatLng(-1.286389, 36.817223));

  // Add a Set to hold markers on the map
  Set<Marker> _markers = Set();

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

    return Container(
      height: height,
      width: width,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Welcome Back',
            style: Theme.of(context).textTheme.titleLarge,
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
            Expanded(
              child: GoogleMap(
                initialCameraPosition: _initialCameraPosition,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                zoomGesturesEnabled: true,
                markers: _markers,
                zoomControlsEnabled: true,
                onMapCreated: (GoogleMapController c) {
                  // to control the camera position of the map
                  googleMapController = c;
                },
              ),
            ),
            _buildSearchCard(),
            _buildEquipmentLoader(context),
            Positioned(
                top: 250, right: 10, left: 10, child: _buildHireButton()),
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

  Widget _buildHireButton() {
    var width = MediaQuery.of(context).size.width;
    return Center(
      child: GestureDetector(
        onTap: () {},
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
}

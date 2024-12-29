import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:neuroTrack/data/participants.dart';
import 'package:neuroTrack/theme/colors.dart';
import 'package:neuroTrack/widgets/dashboardWidgets/accountFrame.dart';
import 'package:neuroTrack/widgets/participants/addNewParticipant.dart';
import 'package:neuroTrack/widgets/participants/participant_entension_tile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _searchController = TextEditingController();
  final storage = const FlutterSecureStorage();
  late Future<List<ParticipantData>> _participantsFuture;
  List<ParticipantData> _allParticipants = [];
  String userRole = '';
  String userName = ''; // Store the logged-in user's name

  @override
  void initState() {
    super.initState();
    _participantsFuture = Future.value([]); // Initialize with an empty list
    _fetchRole(); // Fetch the role of the logged-in user
    _fetchUserData(); // Fetch the logged-in participant's name if the role is participant
    _refreshParticipants(); // Fetch participants data
  }

  // Fetch logged-in user's name
  Future<void> _fetchUserData() async {
    String? name =
        await storage.read(key: 'name'); // Fetch name from secure storage
    setState(() {
      userName = name ?? ''; // Store the name in state
      print("Logged-in User's Name: $userName"); // Log the user name
    });
  }

  // Fetch participants from API
  Future<List<ParticipantData>> _fetchParticipants() async {
    List<ParticipantData> participantsList = [];
    String? userToken = await storage.read(key: 'userToken');
    String? userRole = await storage.read(key: 'role');
    String? userName = await storage.read(key: 'name');
    // Capture the search input

    try {
      // Validate required parameters
      if (userRole == null ||
          userRole.isEmpty ||
          userName == null ||
          userName.isEmpty) {
        print("Invalid query parameters: role or name is missing");
        return [];
      }

      var url = Uri.parse(
          'https://stress-bee.onrender.com/api/participants?role=${Uri.encodeComponent(userRole)}&name=${Uri.encodeComponent(userName)}');
      print('Request URL: $url');

      print("Sending request to URL: $url");

      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $userToken'},
      ).timeout(const Duration(seconds: 20)); // Add timeout to handle delays

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonResponse['success']) {
        var data = jsonResponse['data'] as List;
        participantsList = data
            .map<ParticipantData>((json) => ParticipantData.fromJson(json))
            .toList()
            .reversed
            .toList();
      } else {
        print('Failed to fetch participants: ${jsonResponse['error']}');
      }
    } catch (e) {
      print('Error fetching participants: $e');
    }
    return participantsList;
  }

  // Filter participants based on role and name

  void _filterParticipants() {
    String searchQuery = _searchController.text.toLowerCase();
    List<ParticipantData> filteredParticipants;
    if (searchQuery.isNotEmpty) {
      filteredParticipants = _allParticipants
          .where((participant) =>
              participant.name.toLowerCase().contains(searchQuery))
          .toList();
    } else {
      filteredParticipants =
          List.from(_allParticipants); // Show all when search is empty
    }
    setState(() {
      _participantsFuture = Future.value(filteredParticipants);
    });
  }

  Future<void> _refreshParticipants() async {
    List<ParticipantData> participants = await _fetchParticipants();
    setState(() {
      _allParticipants = participants; // Store the fetched participants
      _participantsFuture =
          Future.value(participants); // Display fetched participants initially
    });
  }

  Future<void> _fetchRole() async {
    String? role = await storage.read(key: 'role');
    setState(() {
      userRole = role ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                const AccountWidget(),
                const SizedBox(height: 10),
                _participantsHeader(context),
                Expanded(
                  child: FutureBuilder<List<ParticipantData>>(
                    future: _participantsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else if (snapshot.hasData) {
                        return RefreshIndicator(
                          onRefresh: _refreshParticipants,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ParticipantExpansionTile(
                                participant: snapshot.data![index],
                                participantsList: const [],
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(
                            child: Text("No participants found"));
                      }
                    },
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ));
  }

  // Search field widget
  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: SizedBox(
        height: 35,
        child: TextField(
          controller: _searchController,

          decoration: InputDecoration(
            labelStyle: const TextStyle(color: AppColor.blue),
            iconColor: AppColor.blue,
            labelText: 'Search Member',
          prefixIconColor: AppColor.blue,
            prefixIcon: const Icon(Icons.search),
            contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
           onChanged: (query) {
            _filterParticipants(); // Filter participants on text change
          },
        ),
      ),
    );
  }

  // Header widget
  Widget _participantsHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "Members",
            style: TextStyle(
              color: AppColor.gray,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildSearchField(),
              ),
              if (userRole == 'supervisor')
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => AddParticipantScreen()),
                    );
                  },
                  child: const Text(
                      style: TextStyle(color: AppColor.blue), 'Add New Member'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

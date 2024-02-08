import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_fizi_app/data/participants.dart';
import 'package:my_fizi_app/widgets/dashboardWidgets/Table/tabTable.dart';
import 'package:my_fizi_app/widgets/dashboardWidgets/accountFrame.dart';
import 'package:my_fizi_app/widgets/dashboardWidgets/bottomNavigation.dart';
import 'package:my_fizi_app/widgets/participants/addNewParticipant.dart';
import 'package:my_fizi_app/widgets/participants/participant.dart';
import 'package:http/http.dart' as http;
import 'package:my_fizi_app/widgets/participants/participant_entension_tile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _searchController = TextEditingController();
  final storage = const FlutterSecureStorage();
  late Future<List<ParticipantData>> _participantsFuture;
  List<ParticipantData> _allParticipants = [];
  String userRole = '';

  @override
  void initState() {
    super.initState();
    _participantsFuture = Future.value([]); // Initialize with an empty list
    _refreshParticipants(); // Then immediately call to fetch actual data
    _fetchRole();
  }

  Future<List<ParticipantData>> _fetchParticipants() async {
    List<ParticipantData> participantsList = [];
    String? userToken = await storage.read(key: 'userToken');
    try {
      var url = Uri.parse('https://stresslysis.onrender.com/api/participants');
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $userToken'},
      );
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse['success']) {
          var data = jsonResponse['data'] as List;
          // participantsList = data
          //     .map<ParticipantData>((json) => ParticipantData.fromJson(json))
          //     .toList()
          //     .reversed
          //     .toList();
          _allParticipants = data
              .map<ParticipantData>((json) => ParticipantData.fromJson(json))
              .toList()
              .reversed
              .toList();
          return _allParticipants;
        } else {
          print('API returned success: false');
        }
      } else {
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching participants: $e');
    }
    return participantsList;
  }

  void _filterParticipants() {
    String searchQuery = _searchController.text.toLowerCase();
    List<ParticipantData> filteredParticipants;
    if (searchQuery.isNotEmpty) {
      filteredParticipants = _allParticipants
          .where((participant) =>
              participant.name.toLowerCase().contains(searchQuery))
          .toList();
    } else {
      filteredParticipants = List.from(
          _allParticipants);
    }
    setState(() {
      _participantsFuture = Future.value(
          filteredParticipants); 
    });
  }

  Future<void> _refreshParticipants() async {
    setState(() {
      _participantsFuture = _fetchParticipants();
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
    return Scaffold(
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
                            participantsList: [],
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: Text("No participants found"));
                  }
                },
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: SizedBox(
        height: 35,
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: 'Search Participants',
            hintText: 'Enter participant name',
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
            _filterParticipants();
          },
        ),
      ),
    );
  }

  Widget _participantsHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "Participant",
            style: TextStyle(
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
                  child: const Text('Add New Participant'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

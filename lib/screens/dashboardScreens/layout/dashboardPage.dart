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
  final storage = FlutterSecureStorage();
  late Future<List<ParticipantData>> _participantsFuture;

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
      var nd = jsonResponse['data'];
      // var rd = nd['episodes'];

      if (response.statusCode == 200) {
        if (jsonResponse['success']) {
          var data = jsonResponse['data'] as List;
          participantsList = data
              .map<ParticipantData>((json) => ParticipantData.fromJson(json))
              .toList();
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
                    return Center(child: CircularProgressIndicator());
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
                    return Center(child: Text("No participants found"));
                  }
                },
              ),
            ),
            const Divider(),
          ],
        ),
      ),
      // bottomNavigationBar: const BottomNavigation()
    );
  }

  Widget _participantsHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Text(
              'Participants',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
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
    );
  }
}

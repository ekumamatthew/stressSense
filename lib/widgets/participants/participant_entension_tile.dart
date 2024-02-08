// file: lib/widgets/participant_expansion_tile.dart
import 'package:flutter/material.dart';
import 'package:my_fizi_app/data/participants.dart';
import 'package:my_fizi_app/theme/colors.dart';
import 'package:my_fizi_app/widgets/participants/participantDetails.dart';
import 'package:my_fizi_app/widgets/speedometer/speedometer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ParticipantExpansionTile extends StatefulWidget {
  final ParticipantData participant;

  const ParticipantExpansionTile(
      {Key? key,
      required this.participant,
      required List<ParticipantData> participantsList})
      : super(key: key);

  @override
  _ParticipantExpansionTileState createState() =>
      _ParticipantExpansionTileState();
}

class _ParticipantExpansionTileState extends State<ParticipantExpansionTile> {
  double calculateAverageNASA(List<EpisodeData> episodes) {
    final total =
        episodes.fold<double>(0, (sum, episode) => sum + episode.nasa);
    return total / episodes.length;
  }

  String userRole = '';

  @override
  void initState() {
    super.initState();
    _fetchRole();
    // Other initializations
  }

  Future<void> _fetchRole() async {
    final storage = FlutterSecureStorage();
    String? role = await storage.read(key: 'role');
    setState(() {
      userRole = role ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    double averageNASA = calculateAverageNASA(widget.participant.episodes);

    return Card(
      child: ExpansionTile(
        title: Text(widget.participant.name),
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                    height: 100,
                    width: 200,
                    child: SpeedometerWidget(averageNASA: averageNASA)),
                Text(
                  'Your average stress level Is: ${averageNASA.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColor.blue2,
                  ),
                ),
                Text(
                  averageNASA >= 80
                      ? 'High Stress'
                      : averageNASA >= 50
                          ? 'Elevated Stress'
                          : averageNASA >= 30
                              ? 'Mildly Elevated Stress'
                              : averageNASA >= 10
                                  ? 'Moderate Stress'
                                  : 'Minimal Stress',
                  // Additional styling can be applied here
                ),
                if (userRole == 'supervisor')
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ParticipantDetailScreen(
                                participant: widget.participant),
                          ),
                        );
                      },
                      child: const Text('View Details')),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

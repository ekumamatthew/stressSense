// file: lib/widgets/participant_expansion_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stressSense_lab/data/participants.dart';
import 'package:stressSense_lab/theme/colors.dart';
import 'package:stressSense_lab/widgets/comments/comment.dart';
import 'package:stressSense_lab/widgets/participants/participantDetails.dart';
import 'package:stressSense_lab/widgets/speedometer/speedometer.dart';

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
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly, // Adjust spacing as needed
                  children: [
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
                        child: const Text('View Details'),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CommentDetailScreen(
                              userId: widget.participant.id,
                              userName: widget.participant.name,
                            ),
                          ),
                        );
                      }, // Function to show modal
                      child: Text(userRole == 'supervisor'
                          ? 'Add Comment'
                          : 'View Comments'),
                    ),
                  ],
                ),
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

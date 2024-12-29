// file: lib/widgets/participant_expansion_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:neuroTrack/data/participants.dart';
import 'package:neuroTrack/theme/colors.dart';
import 'package:neuroTrack/widgets/comments/comment.dart';
import 'package:neuroTrack/widgets/participants/participantDetails.dart';
import 'package:neuroTrack/widgets/speedometer/speedometer.dart';

class ParticipantExpansionTile extends StatefulWidget {
  final ParticipantData participant;

  const ParticipantExpansionTile(
      {super.key,
      required this.participant,
      required List<ParticipantData> participantsList});

  @override
  _ParticipantExpansionTileState createState() =>
      _ParticipantExpansionTileState();
}

class _ParticipantExpansionTileState extends State<ParticipantExpansionTile> {
  double calculateAverageValue(List<EpisodeData> episodes) {
    final total =
        episodes.fold<double>(0, (sum, episode) => sum + episode.FINAL_STRESS);
    return total / episodes.length;
  }

  double calculateInitialAverageValue(List<EpisodeData> episodes) {
    final total = episodes.fold<double>(
        0, (sum, episode) => sum + episode.INITIAL_STRESS);
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
    const storage = FlutterSecureStorage();
    String? role = await storage.read(key: 'role');
    setState(() {
      userRole = role ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    double initalAverageValue =
        calculateInitialAverageValue(widget.participant.episodes);
    double finalAverageValue =
        calculateAverageValue(widget.participant.episodes);

    return Card(
      child: ExpansionTile(
        title: Text(
          widget.participant.name,
          style: TextStyle(color: AppColor.black),
        ),
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SpeedometerWidget(
                    initalAverageValue: initalAverageValue,
                    finalAverageValue: finalAverageValue,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Center align items horizontally
                    children: [
                      Text(
                        finalAverageValue.isFinite
                            ? finalAverageValue >= 80
                                ? 'High Stress'
                                : finalAverageValue >= 50
                                    ? 'Elevated Stress'
                                    : finalAverageValue >= 30
                                        ? 'Mildly Elevated Stress'
                                        : finalAverageValue >= 10
                                            ? 'Moderate Stress'
                                            : 'Minimal Stress'
                            : 'No Stress Data Available',
                        style: const TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10), // Add spacing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (userRole == 'supervisor') // Conditional rendering
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ParticipantDetailScreen(
                                      participant: widget.participant,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'View Details',
                                style: TextStyle(color: AppColor.blue),
                              ),
                            ),
                          const SizedBox(width: 10), // Spacing between buttons
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
                            },
                            child: Text(
                              userRole == 'supervisor'
                                  ? 'Add Comment'
                                  : 'View Comments',
                              style: TextStyle(color: AppColor.blue),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10), // Add spacing at the bottom
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

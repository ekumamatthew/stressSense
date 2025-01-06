/**
 * This holds the participant dropdwon that shows the average value of a participant stress record in the speedometer clock
 * the function for showing the average stress level >50 , >20  and minimal is here on line 89
 */

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stressSense/data/participants.dart';
import 'package:stressSense/theme/colors.dart';
import 'package:stressSense/widgets/comments/comment.dart';
import 'package:stressSense/widgets/participants/participantDetails.dart';
import 'package:stressSense/widgets/speedometer/speedometer.dart';

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
                        finalAverageValue >= 80
                            ? 'High Stress'
                            : finalAverageValue >= 50
                                ? 'Moderate Stress'
                                : 'Low Stress',
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

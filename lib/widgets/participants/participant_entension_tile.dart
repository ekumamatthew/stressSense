import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stressSense/data/participants.dart';
import 'package:stressSense/theme/colors.dart';
import 'package:stressSense/widgets/comments/comment.dart';
import 'package:stressSense/widgets/participants/participantDetails.dart';
import 'package:stressSense/widgets/participants/stress_suggestion_screen.dart';
import 'package:stressSense/widgets/participants/suggestion_helper.dart';
import 'package:stressSense/widgets/speedometer/speedometer.dart';

class ParticipantExpansionTile extends StatefulWidget {
  final ParticipantData participant;

  const ParticipantExpansionTile({
    super.key,
    required this.participant,
    required List<ParticipantData> participantsList,
  });

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
                SpeedometerWidget(
                  initalAverageValue: initalAverageValue,
                  finalAverageValue: finalAverageValue,
                ),
                const SizedBox(height: 10),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (userRole == 'supervisor')
                            _smallButton(
                              label: 'View Details',
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ParticipantDetailScreen(
                                    participant: widget.participant,
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(width: 5), // tighter gap
                          _smallButton(
                            label: 'Suggested Actions',
                            onPressed: () {
                              final suggestion = buildSuggestion(
                                  finalAverageValue); // helper from suggestion_helper.dart
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => StressSuggestionScreen(
                                    suggestion: suggestion,
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(width: 5),
                          _smallButton(
                            label: userRole == 'supervisor'
                                ? 'Add Comment'
                                : 'View Comments',
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CommentDetailScreen(
                                  userId: widget.participant.id,
                                  userName: widget.participant.name,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _smallButton({
  required String label,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: 8, // default is 16 — cut in half
        vertical: 10, // tweak as needed
      ),
      minimumSize: Size.zero, // lets the padding truly dictate size
      tapTargetSize: MaterialTapTargetSize.shrinkWrap, // shrinks hit test area
    ),
    onPressed: onPressed,
    child: Text(
      label,
      style: const TextStyle(color: AppColor.blue, fontSize: 14),
    ),
  );
}

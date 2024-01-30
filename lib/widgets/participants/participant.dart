import 'package:flutter/material.dart';
import 'package:my_fizi_app/data/participants.dart';
import 'package:my_fizi_app/widgets/participants/participant_entension_tile.dart';

class ParticipantsListWidget extends StatelessWidget {
  final List<ParticipantData> participantsList;
  const ParticipantsListWidget({Key? key, required this.participantsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (participantsList.isEmpty) {
      return const Center(child: Text('No participants data available'));
    }
    return ListView.builder(
      itemCount: participantsList.length,
      itemBuilder: (context, index) {
        return ParticipantExpansionTile(
          participant: participantsList[index],
          participantsList: [],
        );
      },
    );
  }
}

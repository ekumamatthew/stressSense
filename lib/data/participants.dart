int getSafeInt(dynamic value, [int defaultValue = 0]) {
  if (value is int) {
    return value;
  }
  return defaultValue;
}

class ParticipantData {
  final String id;
  final String name;
  final List<EpisodeData> episodes;

  ParticipantData(
      {required this.id, required this.name, required this.episodes});

  factory ParticipantData.fromJson(Map<String, dynamic> json) {
    var episodesList = json['episodes'] as List<dynamic>? ?? [];
    List<EpisodeData> episodes =
        episodesList.map((e) => EpisodeData.fromJson(e)).toList();

    return ParticipantData(
      id: json['_id'] as String,
      name: json['name'] as String,
      episodes: episodes,
    );
  }
}

class EpisodeData {
  final double stai;
  final double nasa;
  final int episodeNumber;

  EpisodeData(
      {required this.episodeNumber, required this.stai, required this.nasa});

  factory EpisodeData.fromJson(Map<String, dynamic> json) {
    return EpisodeData(
      episodeNumber: getSafeInt(json['episodeNumber']),
      stai: (json['STAI'] as num?)?.toDouble() ?? 0.0,
      nasa: (json['NASA'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

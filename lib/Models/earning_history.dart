class EarningHistory {
  EarningHistory({
    required this.completedChallenges,
  });
  late final List<CompletedChallenges> completedChallenges;

  EarningHistory.fromJson(Map<String, dynamic> json) {
    completedChallenges = List.from(json['completedChallenges'])
        .map((e) => CompletedChallenges.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['completedChallenges'] =
        completedChallenges.map((e) => e.toJson()).toList();
    return _data;
  }
}

class CompletedChallenges {
  CompletedChallenges({
    required this.challengeId,
    required this.title,
    required this.description,
    required this.pointsEarned,
  });
  late final String challengeId;
  late final String title;
  late final String description;
  late final int pointsEarned;

  CompletedChallenges.fromJson(Map<String, dynamic> json) {
    challengeId = json['challengeId'];
    title = json['title'];
    description = json['description'];
    pointsEarned = json['pointsEarned'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['challengeId'] = challengeId;
    _data['title'] = title;
    _data['description'] = description;
    _data['pointsEarned'] = pointsEarned;
    return _data;
  }
}

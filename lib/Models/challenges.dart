class ChallengesModel {
  final List<Challenges>? challenges;

  ChallengesModel({
    this.challenges,
  });

  ChallengesModel.fromJson(Map<String, dynamic> json)
      : challenges = (json['challenges'] as List?)
            ?.map((dynamic e) => Challenges.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'challenges': challenges?.map((e) => e.toJson()).toList()};
}

class Challenges {
  final ChallengeAgeLimit? challengeAgeLimit;
  final String? id;
  final String? title;
  final String? tag;
  final String? description;
  final int? challengeDistance;
  final int? challengePoints;
  final String? transportType;
  final String? challengeImage;
  final String? lastDateToComplete;
  final List<Users>? users;
  final int? v;

  Challenges({
    this.challengeAgeLimit,
    this.id,
    this.title,
    this.tag,
    this.description,
    this.challengeDistance,
    this.challengePoints,
    this.transportType,
    this.challengeImage,
    this.lastDateToComplete,
    this.users,
    this.v,
  });

  Challenges.fromJson(Map<String, dynamic> json)
      : challengeAgeLimit =
            (json['challengeAgeLimit'] as Map<String, dynamic>?) != null
                ? ChallengeAgeLimit.fromJson(
                    json['challengeAgeLimit'] as Map<String, dynamic>)
                : null,
        id = json['_id'] as String?,
        title = json['title'] as String?,
        tag = json['tag'] as String?,
        description = json['description'] as String?,
        challengeDistance = json['challenge_distance'] as int?,
        challengePoints = json['challenge_points'] as int?,
        transportType = json['transportType'] as String?,
        challengeImage = json['challengeImage'] as String?,
        lastDateToComplete = json['lastDateToComplete'] as String?,
        users = (json['users'] as List?)
            ?.map((dynamic e) => Users.fromJson(e as Map<String, dynamic>))
            .toList(),
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
        'challengeAgeLimit': challengeAgeLimit?.toJson(),
        '_id': id,
        'title': title,
        'tag': tag,
        'description': description,
        'challenge_distance': challengeDistance,
        'challenge_points': challengePoints,
        'transportType': transportType,
        'challengeImage': challengeImage,
        'lastDateToComplete': lastDateToComplete,
        'users': users?.map((e) => e.toJson()).toList(),
        '__v': v
      };
}

class ChallengeAgeLimit {
  final int? min;
  final int? max;

  ChallengeAgeLimit({
    this.min,
    this.max,
  });

  ChallengeAgeLimit.fromJson(Map<String, dynamic> json)
      : min = json['min'] as int?,
        max = json['max'] as int?;

  Map<String, dynamic> toJson() => {'min': min, 'max': max};
}

class Users {
  final String? userId;
  final bool? completed;
  final String? completionDate;
  final String? id;

  Users({
    this.userId,
    this.completed,
    this.completionDate,
    this.id,
  });

  Users.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as String?,
        completed = json['completed'] as bool?,
        completionDate = json['completionDate'] as String?,
        id = json['_id'] as String?;

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'completed': completed,
        'completionDate': completionDate,
        '_id': id
      };
}

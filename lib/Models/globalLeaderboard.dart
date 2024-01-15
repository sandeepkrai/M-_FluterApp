class GlobalLeaderBoardModel {
  final List<GlobalLeaderboard>? globalLeaderboard;
  final AgeRange? ageRange;

  GlobalLeaderBoardModel({
    this.globalLeaderboard,
    this.ageRange,
  });

  GlobalLeaderBoardModel.fromJson(Map<String, dynamic> json)
      : globalLeaderboard = (json['globalLeaderboard'] as List?)
            ?.map((dynamic e) =>
                GlobalLeaderboard.fromJson(e as Map<String, dynamic>))
            .toList(),
        ageRange = (json['ageRange'] as Map<String, dynamic>?) != null
            ? AgeRange.fromJson(json['ageRange'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'globalLeaderboard': globalLeaderboard?.map((e) => e.toJson()).toList(),
        'ageRange': ageRange?.toJson()
      };
}

class GlobalLeaderboard {
  final Profile? profile;
  final Rewards? rewards;
  final String? id;
  final String? username;
  final String? email;
  final String? passwordHash;
  final List<Trips>? trips;
  final List<Challenges>? challenges;
  final String? jwtToken;
  final int? v;

  GlobalLeaderboard({
    this.profile,
    this.rewards,
    this.id,
    this.username,
    this.email,
    this.passwordHash,
    this.trips,
    this.challenges,
    this.jwtToken,
    this.v,
  });

  GlobalLeaderboard.fromJson(Map<String, dynamic> json)
      : profile = (json['profile'] as Map<String, dynamic>?) != null
            ? Profile.fromJson(json['profile'] as Map<String, dynamic>)
            : null,
        rewards = (json['rewards'] as Map<String, dynamic>?) != null
            ? Rewards.fromJson(json['rewards'] as Map<String, dynamic>)
            : null,
        id = json['_id'] as String?,
        username = json['username'] as String?,
        email = json['email'] as String?,
        passwordHash = json['passwordHash'] as String?,
        trips = (json['trips'] as List?)
            ?.map((dynamic e) => Trips.fromJson(e as Map<String, dynamic>))
            .toList(),
        challenges = (json['challenges'] as List?)
            ?.map((dynamic e) => Challenges.fromJson(e as Map<String, dynamic>))
            .toList(),
        jwtToken = json['jwtToken'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
        'profile': profile?.toJson(),
        'rewards': rewards?.toJson(),
        '_id': id,
        'username': username,
        'email': email,
        'passwordHash': passwordHash,
        'trips': trips?.map((e) => e.toJson()).toList(),
        'challenges': challenges?.map((e) => e.toJson()).toList(),
        'jwtToken': jwtToken,
        '__v': v
      };
}

class Profile {
  final Progress? progress;
  final String? name;
  final String? residentLocation;
  final int? age;
  final String? industry;
  final bool? isDisabled;
  final dynamic disabilityName;
  final dynamic disabilityIdCard;
  final bool? isExServiceman;
  final dynamic servicemanIdCard;
  final List<dynamic>? socialMedia;
  final List<dynamic>? achievements;
  final double? totalCarbonEmission;
  final List<dynamic>? userDislike;
  final List<dynamic>? userLikes;
  final bool? isdisabledverify;
  final bool? isServicemanVerify;

  Profile({
    this.progress,
    this.name,
    this.residentLocation,
    this.age,
    this.industry,
    this.isDisabled,
    this.disabilityName,
    this.disabilityIdCard,
    this.isExServiceman,
    this.servicemanIdCard,
    this.socialMedia,
    this.achievements,
    this.totalCarbonEmission,
    this.userDislike,
    this.userLikes,
    this.isdisabledverify,
    this.isServicemanVerify,
  });

  Profile.fromJson(Map<String, dynamic> json)
      : progress = (json['progress'] as Map<String, dynamic>?) != null
            ? Progress.fromJson(json['progress'] as Map<String, dynamic>)
            : null,
        name = json['name'] as String?,
        residentLocation = json['resident_location'] as String?,
        age = json['age'] as int?,
        industry = json['industry'] as String?,
        isDisabled = json['isDisabled'] as bool?,
        disabilityName = json['disabilityName'],
        disabilityIdCard = json['disabilityIdCard'],
        isExServiceman = json['isExServiceman'] as bool?,
        servicemanIdCard = json['servicemanIdCard'],
        socialMedia = json['socialMedia'] as List?,
        achievements = json['achievements'] as List?,
        totalCarbonEmission = json['totalCarbonEmission'] as double?,
        userDislike = json['user_dislike'] as List?,
        userLikes = json['user_likes'] as List?,
        isdisabledverify = json['isdisabledverify'] as bool?,
        isServicemanVerify = json['isServicemanVerify'] as bool?;

  Map<String, dynamic> toJson() => {
        'progress': progress?.toJson(),
        'name': name,
        'resident_location': residentLocation,
        'age': age,
        'industry': industry,
        'isDisabled': isDisabled,
        'disabilityName': disabilityName,
        'disabilityIdCard': disabilityIdCard,
        'isExServiceman': isExServiceman,
        'servicemanIdCard': servicemanIdCard,
        'socialMedia': socialMedia,
        'achievements': achievements,
        'totalCarbonEmission': totalCarbonEmission,
        'user_dislike': userDislike,
        'user_likes': userLikes,
        'isdisabledverify': isdisabledverify,
        'isServicemanVerify': isServicemanVerify
      };
}

class Progress {
  final int? totalPoints;
  final String? experience;

  Progress({
    this.totalPoints,
    this.experience,
  });

  Progress.fromJson(Map<String, dynamic> json)
      : totalPoints = json['totalPoints'] as int?,
        experience = json['experience'] as String?;

  Map<String, dynamic> toJson() =>
      {'totalPoints': totalPoints, 'experience': experience};
}

class Rewards {
  final int? points;

  Rewards({
    this.points,
  });

  Rewards.fromJson(Map<String, dynamic> json) : points = json['points'] as int?;

  Map<String, dynamic> toJson() => {'points': points};
}

class Trips {
  final String? tripId;
  final String? id;

  Trips({
    this.tripId,
    this.id,
  });

  Trips.fromJson(Map<String, dynamic> json)
      : tripId = json['tripId'] as String?,
        id = json['_id'] as String?;

  Map<String, dynamic> toJson() => {'tripId': tripId, '_id': id};
}

class Challenges {
  final String? challengeId;
  final String? id;

  Challenges({
    this.challengeId,
    this.id,
  });

  Challenges.fromJson(Map<String, dynamic> json)
      : challengeId = json['challengeId'] as String?,
        id = json['_id'] as String?;

  Map<String, dynamic> toJson() => {'challengeId': challengeId, '_id': id};
}

class AgeRange {
  final int? min;
  final int? max;

  AgeRange({
    this.min,
    this.max,
  });

  AgeRange.fromJson(Map<String, dynamic> json)
      : min = json['min'] as int?,
        max = json['max'] as int?;

  Map<String, dynamic> toJson() => {'min': min, 'max': max};
}

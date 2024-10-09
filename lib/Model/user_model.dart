class User {
  final int id;
  final String username;
  final String email;
  final int trainerLevel;
  final String region;
  final int badges;
  final String joinDate;
  final String lastLogin;
  final List<Achievement> achievements;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.trainerLevel,
    required this.region,
    required this.badges,
    required this.joinDate,
    required this.lastLogin,
    required this.achievements,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var achievementList = json['achievements'] as List;
    List<Achievement> achievements =
        achievementList.map((i) => Achievement.fromJson(i)).toList();

    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      trainerLevel: json['trainerLevel'],
      region: json['region'],
      badges: json['badges'],
      joinDate: json['joinDate'],
      lastLogin: json['lastLogin'],
      achievements: achievements,
    );
  }
}

class Achievement {
  final int achievementId;
  final String name;
  final String dateEarned;

  Achievement({
    required this.achievementId,
    required this.name,
    required this.dateEarned,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      achievementId: json['achievementId'],
      name: json['name'],
      dateEarned: json['dateEarned'],
    );
  }
}

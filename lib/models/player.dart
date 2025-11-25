class Player {
  final String name;
  final String club;
  final String position;
  final String positionGroup;
  final int age;
  final double predictedScore;

  Player({
    required this.name,
    required this.club,
    required this.position,
    required this.positionGroup,
    required this.age,
    required this.predictedScore,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        name: json['Name'] ?? json['name'] ?? 'Unknown',
        club: json['Club'] ?? 'Unknown',
        position: json['Position'] ?? 'Unknown',
        positionGroup: json['PositionGroup'] ?? 'Other',
        age: ((json['Age'] ?? 0) is int) ? (json['Age'] ?? 0) as int : (json['Age'] ?? 0).toInt(),
        predictedScore: (json['PredictedScore'] ?? json['PredictedScore'] ?? 0).toDouble(),
      );
}

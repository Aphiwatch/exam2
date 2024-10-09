class Pokemon {
  final int id;
  final String num;
  final String name;
  final String img;
  final List<String> type;
  final String height;
  final String weight;
  final String candy;
  final String egg;
  final List<double>? multipliers;
  final List<String> weaknesses;
  final int? candyCount;
  final String spawnChance;
  final String avgSpawns;
  final String spawnTime;
  final List<dynamic> prevEvolution;
  final List<dynamic> nextEvolution;

  Pokemon({
    required this.id,
    required this.num,
    required this.name,
    required this.img,
    required this.type,
    required this.height,
    required this.weight,
    required this.candy,
    required this.egg,
    required this.multipliers,
    required this.weaknesses,
    required this.candyCount,
    required this.spawnChance,
    required this.avgSpawns,
    required this.spawnTime,
    required this.prevEvolution,
    required this.nextEvolution,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      num: json['num'],
      name: json['name'],
      img: json['img'],
      type: List<String>.from(json['type']),
      height: json['height'],
      weight: json['weight'],
      candy: json['candy'],
      egg: json['egg'],
      multipliers: json['multipliers'] != null
          ? List<double>.from(json['multipliers'])
          : null,
      weaknesses: List<String>.from(json['weaknesses']),
      candyCount: json['candy_count'],
      spawnChance: json['spawn_chance'],
      avgSpawns: json['avg_spawns'],
      spawnTime: json['spawn_time'],
      prevEvolution: json['prev_evolution'] != null
        ? List<dynamic>.from(json['prev_evolution'])
        : [],
    nextEvolution: json['next_evolution'] != null
        ? List<dynamic>.from(json['next_evolution'])
        : [],
    );
  }
}

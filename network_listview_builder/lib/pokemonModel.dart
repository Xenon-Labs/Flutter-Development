class Pokemon {
  Pokemon(
      {this.id,
      this.name,
      this.abilities,
      this.height,
      this.stats,
      this.defaultImage});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        id: json['id'],
        name: json['name'],
        abilities: json['abilities'],
        height: json['height'],
        stats: json['stats'],
        defaultImage: json['sprites']['back_default']);
  }

  final int id;
  final String name;
  final List<dynamic> abilities;
  final int height;
  final List<dynamic> stats;
  final String defaultImage;
}

class Team {
  final String? name;
  final String? imageUrl;
  final String? id;

  Team({
    required this.name,
    required this.imageUrl,
    required this.id,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      name: json['name'],
      imageUrl: json['imageUrl'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'id': id,
    };
  }
}

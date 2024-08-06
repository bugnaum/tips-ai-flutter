class {{moduleName}}Entity {
  final String name;

  {{moduleName}}Entity({
    required this.name,
  });

  factory {{moduleName}}Entity.fromJson(Map<String, dynamic> json) {
    return {{moduleName}}Entity(
      name: json['name'],
    );
  }
}


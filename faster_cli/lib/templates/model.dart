class {{moduleName}}Model {
  final String name;

  {{moduleName}}Model({
    required this.name,
  });

  factory {{moduleName}}Model.fromJson(Map<String, dynamic> json) {
    return {{moduleName}}Model(
      name: json['name'],
    );
  }
}
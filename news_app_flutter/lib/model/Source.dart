class Source {
  final String? id;
  final String name;

  Source({this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
        id: json['id'] ?? 'No Source ID', 
        name: json['name']);
  }
}

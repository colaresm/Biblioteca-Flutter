class PublishingCompany {
  final String id;
  final String name;

  const PublishingCompany({
    required this.id,
    required this.name,
  });

  factory PublishingCompany.fromJson(Map<String, dynamic> json) {
    return PublishingCompany(
      id: json['id'],
      name: json['name'],
    );
  }
}

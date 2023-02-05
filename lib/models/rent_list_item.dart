class Rent {
  final String id;
  final Object book;
  final Object client;
  final String returnDate;
  final String rentStatus;

  const Rent(
      {required this.id,
      required this.book,
      required this.client,
      required this.returnDate,
      required this.rentStatus});

  factory Rent.fromJson(Map<String, dynamic> json) {
    return Rent(
        id: json['id'],
        book: json['book']['title'],
        client: json['client']['name'],
        returnDate: json['returnDate'],
        rentStatus: json['rentStatus']);
  }
}

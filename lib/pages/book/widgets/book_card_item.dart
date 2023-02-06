import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/book_controller.dart';
import 'book_cards_list.dart';

class BookCardItem extends StatefulWidget {
  final String patientId;

  const BookCardItem({required this.patientId});

  @override
  State<BookCardItem> createState() => _BookCardItemState();
}

class _BookCardItemState extends State<BookCardItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BookController.getBooks(widget.patientId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Não há livros cadastrados",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                itemBuilder: (context, index) {
                  final book = snapshot.data?[index];
                  return BookCard(
                    id: book.id,
                    title: book.title,
                    author: book.author,
                    color: Colors.black,
                  );
                },
              );
            }
        }
      },
    );
  }
}

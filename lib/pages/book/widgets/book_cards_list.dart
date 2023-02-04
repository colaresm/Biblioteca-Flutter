import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/utils/utf8_decode.dart';
import 'package:intl/intl.dart';

class BookCard extends StatelessWidget {
  BookCard({
    super.key,
    required this.id,
    required this.title,
    required this.author,
    required this.color,
  });
  final String id;
  final String title;
  final String author;
  final Color color;

  DecodeUTF8 decodeUTF8 = new DecodeUTF8();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.11,
      child: Card(
        elevation: 0,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              trailing: const Icon(
                Icons.book,
                color: Color.fromARGB(255, 255, 255, 255),
                size: 35,
              ),
              title: Text(
                decodeUTF8.decodeString(title),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              textColor: const Color.fromARGB(255, 255, 255, 255),
              subtitle: Text(
                decodeUTF8.decodeString(author),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(
                        'book-details',
                        {
                          "id": id,
                          "title": decodeUTF8.decodeString(title),
                          "author": decodeUTF8.decodeString(author),
                        },
                        1),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

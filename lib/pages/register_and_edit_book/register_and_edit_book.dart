import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/register_and_edit_book/widgets/book_form.dart';

class RegisterAndEditBook extends StatefulWidget {
  const RegisterAndEditBook({super.key});

  @override
  State<RegisterAndEditBook> createState() => _RegisterAndEditBookState();
}

class _RegisterAndEditBookState extends State<RegisterAndEditBook> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Container(
      child: BookForm(() {
        print('object');
      }),
    ));
  }
}

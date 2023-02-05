import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/utils/utf8_decode.dart';

class PublishingCompanyCard extends StatefulWidget {
  String id;
  String name;
  PublishingCompanyCard(this.id, this.name);

  @override
  State<PublishingCompanyCard> createState() =>
      _PublishingCompanyCardState(this.id, this.name);
}

class _PublishingCompanyCardState extends State<PublishingCompanyCard> {
  String id;
  String name;
  _PublishingCompanyCardState(this.id, this.name);
  DecodeUTF8 decodeUTF8 = new DecodeUTF8();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.11,
      child: Card(
        elevation: 0,
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              trailing: const Icon(
                Icons.edit_note_sharp,
                color: Color.fromARGB(255, 255, 255, 255),
                size: 35,
              ),
              title: Text(
                decodeUTF8.decodeString(name),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              textColor: const Color.fromARGB(255, 255, 255, 255),
              subtitle: Text(
                decodeUTF8.decodeString(''),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                //   Navigator.push(
                //   context,
                // MaterialPageRoute(
                // builder: (context) => MainPage(
                //   'book-details',
                // {
                // "id": 'id',
                //"title": decodeUTF8.decodeString('title'),
                ///"author": decodeUTF8.decodeString('author'),
                //},
                //1),
                //),
                //);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/publishing_company_controller.dart';
import 'package:libraryWDA/pages/book/widgets/book_cards_list.dart';
import 'package:libraryWDA/pages/publishing_company/widgets/publishingCompanyCard.dart';

class PublishingCompanyCardItem extends StatefulWidget {
  const PublishingCompanyCardItem({super.key});

  @override
  State<PublishingCompanyCardItem> createState() =>
      _PublishingCompanyCardItemState();
}

class _PublishingCompanyCardItemState extends State<PublishingCompanyCardItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PublishingCompanyController.getCompanys(),
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
                  "Não há editoras cadastradas",
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
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                itemBuilder: (context, index) {
                  final publishingCompany = snapshot.data?[index];
                  return PublishingCompanyCard(
                      publishingCompany.id, publishingCompany.name);
                },
              );
            }
        }
      },
    );
  }
}

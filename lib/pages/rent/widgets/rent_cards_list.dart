import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/rent_controller.dart';
import 'package:libraryWDA/models/rent_list_item.dart';
import 'package:libraryWDA/pages/rent/widgets/rent_card_item.dart';

class RentCardItem extends StatefulWidget {
  const RentCardItem({super.key});

  @override
  State<RentCardItem> createState() => _RentCardItemState();
}

class _RentCardItemState extends State<RentCardItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RentController.getRents(),
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
                  "Não há alugéis cadastrados",
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
                  final rent = snapshot.data?[index];
                  return RentCard(
                    rent.id,
                    rent.book,
                    rent.client,
                    rent.rentStatus,
                    rent.returnDate,
                  );
                },
              );
            }
        }
      },
    );
  }
}

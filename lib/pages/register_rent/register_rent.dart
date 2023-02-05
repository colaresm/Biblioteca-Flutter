import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/register_rent/widgets/rent_form.dart';

class RegisterRent extends StatefulWidget {
  var params;
  RegisterRent(this.params);

  @override
  State<RegisterRent> createState() => _RegisterRentState(this.params);
}

class _RegisterRentState extends State<RegisterRent> {
  var params;
  _RegisterRentState(this.params);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      child: RentForm(params),
    ));
  }
}

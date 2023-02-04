import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/register-and-edit-publishing-company/widgets/publishing_company_form.dart';

class RegisterandEditPublishingCompany extends StatefulWidget {
  const RegisterandEditPublishingCompany({super.key});

  @override
  State<RegisterandEditPublishingCompany> createState() =>
      _RegisterandEditPublishingCompanyState();
}

class _RegisterandEditPublishingCompanyState
    extends State<RegisterandEditPublishingCompany> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      child: PublishingCompanyForm(),
    ));
  }
}

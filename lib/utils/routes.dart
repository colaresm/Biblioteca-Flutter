import 'package:flutter/cupertino.dart';
import 'package:libraryWDA/pages/book/books_list_page.dart';
import 'package:libraryWDA/pages/exam_details/exam_details_page.dart';
import 'package:libraryWDA/pages/exams/exams_list_page.dart';
import 'package:libraryWDA/pages/home/home_page.dart';
import 'package:libraryWDA/pages/publishing_company/publishing_comapanys_list.dart';
import 'package:libraryWDA/pages/book_details/book_details.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/pages/message_notifications/message_view.dart';
import 'package:libraryWDA/pages/patient_doctors/patient_doctors_list_page.dart';
import 'package:libraryWDA/pages/doctors_list/doctors_page_list.dart';
import 'package:libraryWDA/pages/message_notification_detail/widgets/detail_message_view.dart';
import 'package:libraryWDA/pages/register-and-edit-publishing-company/register-and-edit-publishing-company.dart';
import 'package:libraryWDA/pages/register_and_edit_book/register_and_edit_book.dart';
import 'package:libraryWDA/pages/register_rent/register_rent.dart';
import 'package:libraryWDA/pages/rent/rents_list_page.dart';
import 'package:libraryWDA/pages/specialties/specialites_list_page.dart';
import 'package:libraryWDA/pages/doctor_details/doctor_details_page.dart';
import 'package:libraryWDA/pages/patient_settings/patient_settings_page.dart';

class Routes {
  Widget getPage(String routeName, Object params) {
    List<Widget> pages = [
      HomePage(),
      PublishingCompanyList(),
      BookPageList(),
      RentList(),
      BookDetails(params),
      RegisterAndEditBook(),
      RegisterandEditPublishingCompany(),
      RegisterRent(params)
    ];
    return pages[getPageIndex(routeName)];
  }

  getPageIndex(String routeName) {
    switch (routeName) {
      case 'home':
        return 0;
      case 'publishing-company-list':
        return 1;
      case 'books-list':
        return 2;
      case 'rents-list':
        return 3;
      case 'book-details':
        return 4;
      case 'register-and-edit-book':
        return 5;
      case 'register-and-edit-publishing-company':
        return 6;
      case 'register-rent':
        return 7;
      default:
        return 0;
    }
  }

  getPageToIndex(int indexPage) {
    switch (indexPage) {
      case 0:
        return 'home';
      case 1:
        return 'publishing-company-list';
      case 2:
        return 'books-list';
      case 3:
        return 'rents-list';
      case 4:
        return 'register-and-edit-book';
      case 5:
        return 'book-details';
      case 6:
        return 'register-and-edit-publishing-company';
      case 7:
        return 'register-rent';
      default:
        return 0;
    }
  }

  getIndexNavBar(String routeName) {
    List baseLabels = ['queries', 'exams', 'doctors'];
    List baseIndex = [1, 2, 3];
    for (var i = 0; i < baseLabels.length; i++) {
      if (routeName.contains(baseLabels[i])) {
        return baseIndex[i];
      }
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:libraryWDA/pages/book/books_list_page.dart';
import 'package:libraryWDA/pages/exam_details/exam_details_page.dart';
import 'package:libraryWDA/pages/exams/exams_list_page.dart';
import 'package:libraryWDA/pages/home/home_page.dart';
import 'package:libraryWDA/pages/queries_details/book_details.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/pages/message_notifications/message_view.dart';
import 'package:libraryWDA/pages/patient_doctors/patient_doctors_list_page.dart';
import 'package:libraryWDA/pages/doctors_list/doctors_page_list.dart';
import 'package:libraryWDA/pages/message_notification_detail/widgets/detail_message_view.dart';
import 'package:libraryWDA/pages/register_and_edit_book/register_and_edit_book.dart';
import 'package:libraryWDA/pages/specialties/specialites_list_page.dart';
import 'package:libraryWDA/pages/doctor_details/doctor_details_page.dart';
import 'package:libraryWDA/pages/patient_settings/patient_settings_page.dart';

class Routes {
  Widget getPage(String routeName, Object params) {
    List<Widget> pages = [
      HomePage(),
      BookPageList(),
      const ExamsPageList(),
      const PatietsDoctorsList(),
      BookDetails(params),
      RegisterAndEditBook(),
      ExamDetailsPage(params),
      WidgetDetailMessageView(params),
      DoctorsList(params),
      const SpecialtiesList(),
      DoctorDetails(params),
      PatientSettings()
    ];
    return pages[getPageIndex(routeName)];
  }

  getPageIndex(String routeName) {
    switch (routeName) {
      case 'home':
        return 0;
      case 'books-list':
        return 1;
      case 'exams-list':
        return 2;
      case 'patient-doctors-list':
        return 3;
      case 'book-details':
        return 4;
      case 'register-and-edit-book':
        return 5;
      case 'exam-details':
        return 6;
      case 'messages-details':
        return 7;
      case 'doctors-list':
        return 8;
      case 'specialites-list':
        return 9;
      case 'doctor-details':
        return 10;
      case 'patient-settings':
        return 11;
      default:
        return 0;
    }
  }

  getPageToIndex(int indexPage) {
    switch (indexPage) {
      case 0:
        return 'home';
      case 1:
        return 'books-list';
      case 2:
        return 'exams-list';
      case 3:
        return 'patient-doctors-list';
      case 4:
        return 'book-details';
      case 5:
        return 'register-and-edit-book';
      case 6:
        return 'exam-details';
      case 7:
        return 'messages-details';
      case 8:
        return 'doctors-list';
      case 9:
        return 'specialites-list';
      case 10:
        return 'doctor-details';
      case 11:
        return 'patient-settings';
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

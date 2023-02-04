import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/widgets/back_button.dart';
import 'package:libraryWDA/utils/IBGElocationsAccess.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/utils/speciality_enum.dart';

class SpecialtiesList extends StatefulWidget {
  const SpecialtiesList({super.key});

  @override
  State<SpecialtiesList> createState() => _SpecialtiesListState();
}

IBGElocationsAccess iBGElocationsAccess = new IBGElocationsAccess();

class _SpecialtiesListState extends State<SpecialtiesList> {
  getLocation() {
    iBGElocationsAccess.getCities(selectedState).then(
      (response) {
        setState(() {
          selectedCity = response.first;
        });
      },
    );
    return selectedCity;
  }

  String? selectedState = "Ceará";
  String? selectedCity = "Fortaleza";

  @override
  final SpecialityEnum specialityEnum = new SpecialityEnum();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(3, 0, 10, 5),
              child: Backbutton("patient-doctors-list", ""),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Estado: ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1)),
                        child: FutureBuilder(
                          future: iBGElocationsAccess.getStates(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return snapshot.hasData
                                ? Container(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      underline: Container(),
                                      alignment: Alignment.bottomCenter,
                                      elevation: 0,
                                      borderRadius: BorderRadius.circular(5),
                                      hint: Text(selectedState ?? 'Ceará'),
                                      items: snapshot.data
                                          .map<DropdownMenuItem<String>>(
                                              (item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedState = value;

                                          iBGElocationsAccess
                                              .getCities(selectedState)
                                              .then(
                                            (response) {
                                              selectedCity = response.first;
                                            },
                                          );
                                        });
                                      },
                                    ),
                                  )
                                : Container(
                                    child: Center(
                                      child: Text('Carregando estados...'),
                                    ),
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Text('Cidade: ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Container(
                          child: FutureBuilder(
                            future:
                                iBGElocationsAccess.getCities(selectedState),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              return snapshot.hasData
                                  ? Container(
                                      height: 20,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(width: 1)),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        underline: Container(),
                                        alignment: Alignment.bottomCenter,
                                        elevation: 0,
                                        borderRadius: BorderRadius.circular(5),
                                        hint: Text(selectedCity ?? 'Fortaleza'),
                                        items: snapshot.data
                                            .map<DropdownMenuItem<String>>(
                                                (item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedCity = value;
                                          });
                                        },
                                      ),
                                    )
                                  : Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(25, 25, 25, 5),
              child: Text('Selecione a especialidade',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              itemCount: specialityEnum.getspecialitesList().length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: Card(
                    elevation: 0,
                    color: Color.fromRGBO(0, 191, 166, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          trailing: const Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 255, 255, 255),
                            size: 35,
                          ),
                          title: Text(
                            specialityEnum.specialityValue(
                                specialityEnum.getspecialitesList()[index]),
                            style: const TextStyle(
                              fontFamily: 'Fredoka',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          textColor: const Color.fromARGB(255, 255, 255, 255),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainPage(
                                    "doctors-list",
                                    {
                                      "speciality": specialityEnum
                                          .getspecialitesList()[index],
                                      "state": selectedState,
                                      "city": getLocation(),
                                    },
                                    3),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ])),
    );
  }
}

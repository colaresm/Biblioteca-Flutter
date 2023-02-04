import 'package:http/http.dart' as http;
import 'dart:convert';

class IBGElocationsAccess {
  getStates() async {
    List<String> states = [];
    var data = await http.get(Uri.parse(
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados'));
    var response = json.decode(data.body);

    for (var i = 0; i < response.length; i++) states.add(response[i]['nome']);

    return states;
  }

  getCities(state) async {
    var data = await http.get(Uri.parse(
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados'));
    var response = json.decode(data.body);

    var stateId;
    for (var i = 0; i < response.length; i++) {
      if (response[i]['nome'] == state) {
        stateId = response[i]['id'];
      }
    }

    var loadedContent = await http.get(Uri.parse(
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados/${stateId}/municipios'));
    var responseCities = json.decode(loadedContent.body);
    List<String> cities = [];
    for (var i = 0; i < responseCities.length; i++) {
      cities.add(responseCities[i]['nome']);
    }

    return cities;
  }
}

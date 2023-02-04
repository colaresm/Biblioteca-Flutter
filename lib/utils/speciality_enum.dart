class SpecialityEnum {
  var _specialitiesValues = {
    'DERMATOLOGIST': 'Dermatologista',
    'NUTRITIONIST': 'Nutricionista',
    'NEUROLOGIST': 'Neurologista',
    'PSYCHOLOGIST': 'Psicólogo',
    'PSYCHIATRIST': 'Psiquiátra',
    'CARDIOLOGIST': 'Cardiologista',
    'UROLOGIST': 'Urologista',
    'GYNECOLOGIST': 'Ginecologista',
    'IMMUNOLOGIST': 'Imunologista',
    'OPHTHALMOLOGIST': 'Oftalmologista',
    'PEDIATRICIAN': 'Pediatra'
  };
  specialityValue(String speciality) {
    if (_specialitiesValues.containsKey(speciality))
      return _specialitiesValues[speciality];
    else
      return 'Outra especialidade';
  }

  getspecialitesList() {
    return _specialitiesValues.keys.toList();
  }
}

enum ProfessorCargo {
  CONCURSADO_EFEITVO,
  TEMPORARIO,
  TERCEIRIZADO,
  CLT,
}

extension ProfessorCargoExtensions on ProfessorCargo {
  int get id {
    return index + 1;
  }

  String get name {
    switch (this) {
      case ProfessorCargo.CONCURSADO_EFEITVO:
        return "Concursado/Efetivo";
      case ProfessorCargo.TEMPORARIO:
        return "Temporário";
      case ProfessorCargo.TERCEIRIZADO:
        return "Terceirizado";
      case ProfessorCargo.CLT:
        return "CLT";
    }
  }
}

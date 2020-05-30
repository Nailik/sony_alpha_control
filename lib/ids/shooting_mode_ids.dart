enum ShootingModeId {
  //01 00 - M
  M,
  //02 00 - P
  P,
  //03 00 - A
  A,
  //04 00 - S
  S,
  //07 00 - SCN
  SCN,
//11 80 - Moving objects? (running person icon)
  SCN_MOO,
//15 80 - Flower icon
  SCN_F,
//14 80 - Mountains icon
  SCN_M,
//12 80 - Sun icon?
  SCN_S,
//13 80 - Moon icon
  SCN_MOON,
//17 80 - Moon icon with person
  SCN_MOON_P,
  //00 80 - AUTO
  AUTO,
  //50 80 - Movie (P)
  Movie_P,
  //51 80 - Movie (A)
  Movie_A,
  //52 80 - Movie (S)
  Movie_S,
  //53 80 - Movie (M)
  Movie_M,
  //84 80 - S&Q (P)
  SQ_P,
  //85 80 - S&Q (A)
  SQ_A,
  //86 80 - S&Q (S)
  SQ_S,
  //87 80 - S&Q (M)
  SQ_M,
  Unknown
}

extension ShootingModeIdExtension on ShootingModeId {
  String get name => toString().split('.')[1];

  int get value {
    switch (this) {
      case ShootingModeId.M:
        return 0x0001;
      case ShootingModeId.P:
        return 0x0002;
      case ShootingModeId.A:
        return 0x0003;
      case ShootingModeId.S:
        return 0x0004;
      case ShootingModeId.SCN:
        return 0x0007;
      case ShootingModeId.SCN_MOO:
        return 0x8011;
      case ShootingModeId.SCN_F:
        return 0x8015;
      case ShootingModeId.SCN_M:
        return 0x8014;
      case ShootingModeId.SCN_S:
        return 0x8012;
      case ShootingModeId.SCN_MOON:
        return 0x8013;
      case ShootingModeId.SCN_MOON_P:
        return 0x8017;
      case ShootingModeId.AUTO:
        return 0x8000;
      case ShootingModeId.Movie_P:
        return 0x8050;
      case ShootingModeId.Movie_A:
        return 0x8051;
      case ShootingModeId.Movie_S:
        return 0x8052;
      case ShootingModeId.Movie_M:
        return 0x8053;
      case ShootingModeId.SQ_P:
        return 0x8084;
      case ShootingModeId.SQ_A:
        return 0x8085;
      case ShootingModeId.SQ_S:
        return 0x8086;
      case ShootingModeId.SQ_M:
        return 0x8087;
      case ShootingModeId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}

ShootingModeId getShootingModeId(int value) {
  return ShootingModeId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => ShootingModeId.Unknown);
}

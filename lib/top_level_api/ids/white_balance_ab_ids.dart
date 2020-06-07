///
/// Warmth bias used by AB (amber-blue)
///
enum WhiteBalanceAbId {
  B70,
  B65,
  B60,
  B55,
  B50,
  B45,
  B40,
  B35,
  B30,
  B25,
  B20,
  B15,
  B10,
  B05,
  Zero,
  A05,
  A10,
  A15,
  A20,
  A25,
  A30,
  A35,
  A40,
  A45,
  A50,
  A55,
  A60,
  A65,
  A70,
  Unknown
}

extension WhiteBalanceAbIdExtension on WhiteBalanceAbId {
  String get name => toString().split('.')[1];

  int get value {
    switch (this) {
      case WhiteBalanceAbId.B70:
        return 0xA4;
      case WhiteBalanceAbId.B65:
        return 0xA6;
      case WhiteBalanceAbId.B60:
        return 0xA8;
      case WhiteBalanceAbId.B55:
        return 0xAA;
      case WhiteBalanceAbId.B50:
        return 0xAC;
      case WhiteBalanceAbId.B45:
        return 0xAE;
      case WhiteBalanceAbId.B40:
        return 0xB0;
      case WhiteBalanceAbId.B35:
        return 0xB2;
      case WhiteBalanceAbId.B30:
        return 0xB4;
      case WhiteBalanceAbId.B25:
        return 0xB6;
      case WhiteBalanceAbId.B20:
        return 0xB8;
      case WhiteBalanceAbId.B15:
        return 0xBA;
      case WhiteBalanceAbId.B10:
        return 0xBC;
      case WhiteBalanceAbId.B05:
        return 0xBE;
      case WhiteBalanceAbId.Zero:
        return 0xC0;
      case WhiteBalanceAbId.A05:
        return 0xC2;
      case WhiteBalanceAbId.A10:
        return 0xC4;
      case WhiteBalanceAbId.A15:
        return 0xC6;
      case WhiteBalanceAbId.A20:
        return 0xC8;
      case WhiteBalanceAbId.A25:
        return 0xCA;
      case WhiteBalanceAbId.A30:
        return 0xCC;
      case WhiteBalanceAbId.A35:
        return 0xCE;
      case WhiteBalanceAbId.A40:
        return 0xD0;
      case WhiteBalanceAbId.A45:
        return 0xD2;
      case WhiteBalanceAbId.A50:
        return 0xD4;
      case WhiteBalanceAbId.A55:
        return 0xD6;
      case WhiteBalanceAbId.A60:
        return 0xD8;
      case WhiteBalanceAbId.A65:
        return 0xDA;
      case WhiteBalanceAbId.A70:
        return 0xDC;
      case WhiteBalanceAbId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}

WhiteBalanceAbId getWhiteBalanceAbId(int value) {
  return WhiteBalanceAbId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => WhiteBalanceAbId.Unknown);
}

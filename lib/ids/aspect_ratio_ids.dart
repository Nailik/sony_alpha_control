enum AspectRatioId { Ar3_2, Ar16_9, Unknown }

extension AspectRatioIdExtension on AspectRatioId {
  String get name => toString().split('.')[1];

  int get value {
    switch (this) {
      case AspectRatioId.Ar3_2:
        return 1;
      case AspectRatioId.Ar16_9:
        return 2;
      case AspectRatioId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}

AspectRatioId getAspectRatioId(int value) {
  return AspectRatioId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => AspectRatioId.Unknown);
}

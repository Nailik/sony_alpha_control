extension AutoFocusStateIdExtension on AutoFocusStateId {
  String get name => toString().split('.')[1];

  int get value {
    switch (this) {
      case AutoFocusStateId.Inactive:
        return 1;
      case AutoFocusStateId.Focused:
        return 2;
      case AutoFocusStateId.FocusFailed:
        return 3;
      case AutoFocusStateId.Searching:
        return 5;
      case AutoFocusStateId.FocusedAndSearching:
        return 6;
      case AutoFocusStateId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}

AutoFocusStateId getAutoFocusStateId(int value) {
  return AutoFocusStateId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => AutoFocusStateId.Unknown);
}


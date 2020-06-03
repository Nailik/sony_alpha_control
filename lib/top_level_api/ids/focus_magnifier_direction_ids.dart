
enum FocusMagnifierDirectionId { Left, Right, Up, Down, Unknown }

extension FocusMagnifierDirectionIdExtension on FocusMagnifierDirectionId {
  String get name => toString().split('.')[1];
  int get value {
    switch (this) {
      case FocusMagnifierDirectionId.Left:
        return 0;
      case FocusMagnifierDirectionId.Right:
        return 1;
      case FocusMagnifierDirectionId.Up:
        return 2;
      case FocusMagnifierDirectionId.Down:
        return 3;
      case FocusMagnifierDirectionId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}

FocusMagnifierDirectionId geFocusMagnifierDirectionId(int value) {
  return FocusMagnifierDirectionId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => FocusMagnifierDirectionId.Unknown);
}
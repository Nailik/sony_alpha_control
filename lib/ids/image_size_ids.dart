enum ImageSizeId { Large, Medium, Small, Unknown }

extension ImageSizeIdExtension on ImageSizeId {
  String get name => toString().split('.')[1];

  int get value {
    switch (this) {
      case ImageSizeId.Large:
        return 1;
      case ImageSizeId.Medium:
        return 2;
      case ImageSizeId.Small:
        return 3;
      case ImageSizeId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}

ImageSizeId getImageSizeId(int value) {
  return ImageSizeId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => ImageSizeId.Unknown);
}
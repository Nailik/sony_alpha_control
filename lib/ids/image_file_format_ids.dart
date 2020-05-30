enum ImageFileFormatId { JpegStandard, JpegFine, JpegXFine, Raw, Raw_JPEG, Unknown }

extension ImageFileFormatIdExtension on ImageFileFormatId {
  String get name => toString().split('.')[1];

  int get value {
    switch (this) {
      case ImageFileFormatId.JpegStandard:
        return 0x02;
      case ImageFileFormatId.JpegFine:
        return 0x03;
      case ImageFileFormatId.JpegXFine:
        return 0x04;
      case ImageFileFormatId.Raw:
        return 0x10;
      case ImageFileFormatId.Raw_JPEG:
        return 0x13;
      case ImageFileFormatId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}

ImageFileFormatId getImageFileFormatId(int value) {
  return ImageFileFormatId.values.firstWhere(
      (element) => element.value == value,
      orElse: () => ImageFileFormatId.Unknown);
}

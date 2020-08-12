class SpecVersion {
  String major;
  String minor;

  SpecVersion(this.major, this.minor);

  factory SpecVersion.fromJson(Map<String, dynamic> json) => SpecVersion(
        json['major'] as String,
        json['minor'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'major': this.major,
        'minor': this.minor,
      };
}

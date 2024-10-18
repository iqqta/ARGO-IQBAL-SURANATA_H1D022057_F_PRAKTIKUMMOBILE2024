class PemantauanTidur {
  int? id;
  String? sleepQuality;
  int? sleepHours;
  String? sleepDisorders;

  PemantauanTidur({
    this.id,
    this.sleepQuality,
    this.sleepHours,
    this.sleepDisorders,
  });

  factory PemantauanTidur.fromJson(Map<String, dynamic> json) {
    return PemantauanTidur(
      id: json['id'],
      sleepQuality: json['sleep_quality'],
      sleepHours: json['sleep_hours'],
      sleepDisorders: json['sleep_disorders'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sleep_quality': sleepQuality,
      'sleep_hours': sleepHours,
      'sleep_disorders': sleepDisorders,
    };
  }
}

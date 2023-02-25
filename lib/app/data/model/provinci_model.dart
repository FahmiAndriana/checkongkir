class Provinci {
  String? provinceId;
  String? province;

  Provinci({this.provinceId, this.province});

  Provinci.fromJson(Map<String, dynamic> json) {
    provinceId = json['province_id'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['province_id'] = provinceId;
    data['province'] = province;
    return data;
  }

  static List<Provinci> fromJSONList(List<dynamic>? data) {
    if (data!.isEmpty) return [];
    return data.map((e) => Provinci.fromJson(e)).toList();
  }

  @override
  String toString() => province!;
}

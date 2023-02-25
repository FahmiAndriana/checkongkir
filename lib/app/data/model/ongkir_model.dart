class OngkirModel {
  String? service;
  String? description;
  List<Cost>? cost;

  OngkirModel({this.service, this.description, this.cost});

  OngkirModel.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    description = json['description'];
    if (json['cost'] != null) {
      cost = <Cost>[];
      json['cost'].forEach((v) {
        cost!.add(new Cost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service'] = this.service;
    data['description'] = this.description;
    if (this.cost != null) {
      data['cost'] = this.cost!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<OngkirModel> fromJSONList(List<dynamic>? data) {
    if (data!.isEmpty) return [];
    return data.map((e) => OngkirModel.fromJson(e)).toList();
  }
}

class Cost {
  int? value;
  dynamic etd;
  String? note;

  Cost({this.value, this.etd, this.note});

  Cost.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    etd = json['etd'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['etd'] = this.etd;
    data['note'] = this.note;
    return data;
  }
}

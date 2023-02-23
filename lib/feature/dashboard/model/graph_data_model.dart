class MonthlyStats {
  String? sums;
  int? year;
  String? month;
  int? day;

  MonthlyStats({this.sums, this.year, this.month, this.day});

  MonthlyStats.fromJson(Map<String, dynamic> json) {
    sums = json['sums'].toString();
    year = int.parse(json['year'].toString());
    month = json['month'].toString();
    day = int.parse(json['day'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sums'] = this.sums;
    data['year'] = this.year;
    data['month'] = this.month;
    data['day'] = this.day;
    return data;
  }
}

class YearlyStats {
  String? sums;
  int? year;
  String? month;

  YearlyStats({this.sums, this.year, this.month});

  YearlyStats.fromJson(Map<String, dynamic> json) {
    sums = json['sums'].toString();
    year = int.parse(json['year'].toString());
    month = json['month'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sums'] = this.sums;
    data['year'] = this.year;
    data['month'] = this.month;
    return data;
  }
}


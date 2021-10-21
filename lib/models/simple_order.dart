class SimpleOrder {
  var iD;
  var value;
  var status;
  var date;

  SimpleOrder({this.iD, this.value, this.status, this.date});

  SimpleOrder.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    value = json['Value'];
    status = json['Status'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Value'] = this.value;
    data['Status'] = this.status;
    data['Date'] = this.date;
    return data;
  }
}
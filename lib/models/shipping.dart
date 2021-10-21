class Shipping {
  var firstName;
  var lastName;
  var company;
  var address1;
  var address2;
  var city;
  var postcode;
  var country;
  var state;

  Shipping(
      {this.firstName,
        this.lastName,
        this.company,
        this.address1,
        this.address2,
        this.city,
        this.postcode,
        this.country,
        this.state});

  Shipping.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'] ??"";
    lastName = json['last_name'] ??"";
    company = json['company'] ??"";
    address1 = json['address_1'] ??"";
    address2 = json['address_2'] ??"";
    city = json['city'] ??"";
    postcode = json['postcode'] ??"";
    country = json['country'] ??"";
    state = json['state'] ??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName ??"";
    data['last_name'] = this.lastName ??"";
    data['company'] = this.company ??"";
    data['address_1'] = this.address1 ??"";
    data['address_2'] = this.address2 ??"";
    data['city'] = this.city ??"";
    data['postcode'] = this.postcode ??"";
    data['country'] = this.country ??"";
    data['state'] = this.state ??"";
    return data;
  }
}
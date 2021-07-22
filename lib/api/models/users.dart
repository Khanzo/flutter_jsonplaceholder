// @dart=2.0

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of api;

//Users
//все поля в один объект
class User extends Equatable {
  const User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.website,
    this.addressStreet,
    this.addressSuite,
    this.addressCity,
    this.addressZipcode,
    this.addressGeoLat,
    this.addressGeoLng,
    this.companyName,
    this.companyCatchPhrase,
    this.companyBs,
  });

  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final String addressStreet;
  final String addressSuite;
  final String addressCity;
  final String addressZipcode;
  final String addressGeoLat;
  final String addressGeoLng;
  final String companyName;
  final String companyCatchPhrase;
  final String companyBs;

  @override
  List<Object> get props => [
        id,
        name,
        username,
        email,
        phone,
        website,
        addressStreet,
        addressSuite,
        addressCity,
        addressZipcode,
        addressGeoLat,
        addressGeoLng,
        companyName,
        companyCatchPhrase,
        companyBs,
      ];

  User copyWith({
    int id,
    String name,
    String username,
    String email,
    String phone,
    String website,
    String addressStreet,
    String addressSuite,
    String addressCity,
    String addressZipcode,
    String addressGeoLat,
    String addressGeoLng,
    String companyName,
    String companyCatchPhrase,
    String companyBs,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      addressStreet: addressStreet ?? this.addressStreet,
      addressSuite: addressSuite ?? this.addressSuite,
      addressCity: addressCity ?? this.addressCity,
      addressZipcode: addressZipcode ?? this.addressZipcode,
      addressGeoLat: addressGeoLat ?? this.addressGeoLat,
      addressGeoLng: addressGeoLng ?? this.addressGeoLng,
      companyName: companyName ?? this.companyName,
      companyCatchPhrase: companyCatchPhrase ?? this.companyCatchPhrase,
      companyBs: companyBs ?? this.companyBs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
      'address_street': addressStreet,
      'address_suite': addressSuite,
      'address_city': addressCity,
      'address_zipcode': addressZipcode,
      'address_geo_lat': addressGeoLat,
      'address_geo_lng': addressGeoLng,
      'company_name': companyName,
      'company_catchPhrase': companyCatchPhrase,
      'company_bs': companyBs,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      website: map['website'],
      addressStreet: map['address']['street'],
      addressSuite: map['address']['suite'],
      addressCity: map['address']['city'],
      addressZipcode: map['address']['zipcode'],
      addressGeoLat: map['address']['geo']['lat'],
      addressGeoLng: map['address']['geo']['lng'],
      companyName: map['company']['name'],
      companyCatchPhrase: map['company']['catchPhrase'],
      companyBs: map['company']['bs'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

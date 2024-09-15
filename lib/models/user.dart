import 'dart:convert';

class User {
  final String id;

  final String fullName;

  final String email;

  final String state;

  final String city;

  final String locality;

  final String password;

  final String token;

  User({
    required this.id,
    required this.password,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.token,
  });

//serilaization:convert user object to map

//Map:A map is a collection of key- vaule pairs

// why converting to a map is an intermidate step that make it easier to serilaze

// the object to formats likes json for storage or transemission

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
      'token': token,
    };
  }

//Serialization:Coonvert Map to a Json String
// This method directly encodes the data from the Map into a json String

  // The json.encode() function converts a dart object
  // into a json String reprsentation, making it sutable for communcation
  // between different systems
  String toJson() => json.encode(toMap());

// Deserlization:Convert a Map to User object
// pupose- Mainpulation and user:once the data is converted to a User object
// it can easy mainpulated and use within the application .For example
// we might want to display the user's full name ,email ect on the Ui.or we might
//want to save user data locally.

// the factory constructor takes a Map(usually from a json object)
  /// and convert it into a user object.if the filed is not present in the Map,
  /// it dfaults to an epty String.

  // fromMap :this constructor take a Map<String,dynamic> and convers it into user object
  //.its usefull when you already have the data in Map format
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String? ?? "",
      fullName: map['fullName'] as String? ?? "",
      email: map['email'] as String? ?? "",
      state: map['state'] as String? ?? "",
      city: map['city'] as String? ?? "",
      locality: map['locality'] as String? ?? "",
      password: map['password'] as String? ?? "",
      token: map['token'] as String? ?? "",
    );
  }

// from json:this cattory constructor take Json String , and decodes into a Map<String,dynamic>
// and then uses fromMap to conver tha  Map into user object.

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}

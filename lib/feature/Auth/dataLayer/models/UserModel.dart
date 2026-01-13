class Usermodel {
  final String? id;
  final String? name;
  final String? email;
  final int? phone;

  Usermodel({this.id, this.name, this.email, this.phone});

  Map<String, dynamic> tojson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
  };

  factory Usermodel.fromjson(Map<String, dynamic> json) {
    return Usermodel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

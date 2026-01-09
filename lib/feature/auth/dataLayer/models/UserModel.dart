class Usermodel {
  final String? id;
  final String? name;
  final String? email;

  Usermodel({this.id, this.name, this.email});

  Map<String, dynamic> tojson() => {"id": id, "name": name, "email": email};

  factory Usermodel.fromjson(Map<String, dynamic> json) {
    return Usermodel(id: json['id'], name: json['name'], email: json['email']);
  }
}

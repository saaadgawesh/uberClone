class Usermodel {
  final String id;
  final String name;
  final String email;

  Usermodel({required this.id, required this.name, required this.email});

  Map<String, dynamic> tojson() => {"id": id, "name": name, "email": email};

  Usermodel.fromjson(Map<String, dynamic> json)
    : this(id: json['id'], name: json['name'], email: json['email']);
}

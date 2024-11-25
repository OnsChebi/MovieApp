class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? confirmpassword;
  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.confirmpassword});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    confirmpassword = json['confirmpassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = confirmpassword;
    data['password'] = password;
    data['confirmpassword'] = confirmpassword;
    return data;
  }
}
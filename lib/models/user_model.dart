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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.confirmpassword;
    data['password'] = this.password;
    data['confirmpassword'] = this.confirmpassword;
    return data;
  }
}
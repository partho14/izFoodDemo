class UserModel {

  final int id;
  final String name;
  final String email;
  final String password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });


  Map<String,dynamic> toJson() =>{
    "user_id": id.toString(),
    "user_name": name.toString(),
    "user_email": email.toString(),
    "user_password": password.toString(),

  };
}

class UserModel {
  int id;
  String uid;
  String phone;
  String name;
  String email;
  String gender;
  double balance;

  UserModel(
      {this.id = 0,
      required this.phone,
      required this.uid,
      required this.name,
      required this.email,
      required this.gender,
      required this.balance});

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'uid': uid,
        'name': name,
        'email': email,
        'gender': gender,
        'balance': balance
      };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
      phone: json['phone'],
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      balance: json["balance"]);
}

UserModel userProfile = UserModel(
    phone: "", uid: "", name: "", email: "", gender: "", balance: 0.0);

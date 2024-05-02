class UserModel {
  String uid;
  String phone;
  String name;
  String avatarUrl;
  String email;
  String gender;
  double balance;

  UserModel(
      {required this.phone,
      required this.uid,
      required this.name,
      required this.avatarUrl,
      required this.email,
      required this.gender,
      required this.balance});

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'uid': uid,
        'name': name,
        'avatarUrl': avatarUrl,
        'email': email,
        'gender': gender,
        'balance': balance
      };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
      phone: json['phone'],
      uid: json['uid'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      email: json['email'],
      gender: json['gender'],
      balance: json["balance"]);
}

UserModel userProfile = UserModel(
    phone: "",
    uid: "",
    name: "",
    avatarUrl: "",
    email: "",
    gender: "",
    balance: 0.0);

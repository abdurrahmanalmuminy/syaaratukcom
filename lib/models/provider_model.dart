class ProviderModel {
  String uid;
  String? identity;
  String phone;
  String name;
  String service;
  String avatarUrl;
  double balance;

  ProviderModel(
      {required this.uid,
      required this.phone,
      required this.identity,
      required this.name,
      required this.service,
      required this.balance,
      required this.avatarUrl});

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'phone': phone,
        'identity': identity,
        'name': name,
        'service': service,
        'avatarUrl': avatarUrl,
        'balance': balance
      };

  static ProviderModel fromJson(Map<String, dynamic> json) => ProviderModel(
      uid: json['uid'],
      phone: json['phone'],
      identity: json['identity'],
      name: json['name'],
      service: json['service'],
      avatarUrl: json["avatarUrl"],
      balance: json["balance"]);
}

ProviderModel providerProfile = ProviderModel(
    uid: "",
    phone: "",
    identity: "",
    name: "",
    service: "",
    avatarUrl: "",
    balance: 0.0);

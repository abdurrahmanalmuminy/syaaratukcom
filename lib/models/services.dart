class ServiceModel {
  final String label;
  final String description;
  final String asset;

  ServiceModel(
      {required this.label, required this.description, required this.asset});

  Map<String, dynamic> toJson() => {'label': label, 'asset': asset};

  static ServiceModel fromJson(Map<String, dynamic> json) => ServiceModel(
        label: json["label"],
        asset: json["asset"],
        description: json["description"],
      );
}

final List<ServiceModel> services = [
  ServiceModel(
      label: "فحص",
      description: "ما تدري وش بالسيارة؟",
      asset: "assets/images/services/examine.png"),
  ServiceModel(
      label: "إطارات",
      description: "كفرك مبنشر او فيه مشكلة؟",
      asset: "assets/images/services/tires.png"),
  ServiceModel(
      label: "سطحة",
      description: "تحتاج تنقل سيارتك لأي مكان؟",
      asset: "assets/images/services/transport.png"),
  ServiceModel(
      label: "المفاتيح",
      description: "مضيع المفتاح أو ناسيه بالسيارة؟",
      asset: "assets/images/services/keys.png"),
  ServiceModel(
      label: "غسيل",
      description: "تبي تنظف سيارتك وتغسلها؟",
      asset: "assets/images/services/wash.png"),
  ServiceModel(
      label: "ورشة",
      description: "تحتاج ورشة تجيك لعندك؟",
      asset: "assets/images/services/workshop.png"),
];

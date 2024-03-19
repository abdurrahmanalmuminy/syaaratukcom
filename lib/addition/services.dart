class ServiceItem {
  final String label;
  final String description;
  final String asset;

  ServiceItem(
      {required this.label, required this.description, required this.asset});
}

final List<ServiceItem> services = [
  ServiceItem(
      label: "فحص",
      description: "ما تدري وش بالسيارة؟",
      asset: "assets/images/services/examine.png"),
  ServiceItem(
      label: "إطارات",
      description: "كفرك مبنشر او فيه مشكلة؟",
      asset: "assets/images/services/tires.png"),
  ServiceItem(
      label: "سطحة",
      description: "تحتاج تنقل سيارتك لأي مكان؟",
      asset: "assets/images/services/transport.png"),
  ServiceItem(
      label: "المفاتيح",
      description: "مضيع المفتاح أو ناسيه بالسيارة؟",
      asset: "assets/images/services/keys.png"),
  ServiceItem(
      label: "غسيل", description: "تبي تنظف سيارتك وتغسلها؟", asset: "assets/images/services/wash.png"),
  ServiceItem(
      label: "ورشة",
      description: "تحتاج ورشة تجيك لعندك؟",
      asset: "assets/images/services/workshop.png"),
];

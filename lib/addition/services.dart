class ServiceItem {
  final String label;
  final String asset;

  ServiceItem({required this.label, required this.asset});
}

final List<ServiceItem> services = [
  ServiceItem(label: "فحص", asset: "assets/images/services/examine.png"),
  ServiceItem(label: "إطارات", asset: "assets/images/services/tires.png"),
  ServiceItem(label: "سطحة", asset: "assets/images/services/transport.png"),
  ServiceItem(label: "المفاتيح", asset: "assets/images/services/keys.png"),
  ServiceItem(label: "غسيل", asset: "assets/images/services/wash.png"),
  ServiceItem(label: "ورشة", asset: "assets/images/services/workshop.png"),
];

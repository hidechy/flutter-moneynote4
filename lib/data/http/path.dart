enum APIPath {
  amazonPurchase,
}

extension APIPathExtension on APIPath {
  String? get value {
    switch (this) {
      case APIPath.amazonPurchase:
        return 'amazonPurchaseList';
    }
  }
}

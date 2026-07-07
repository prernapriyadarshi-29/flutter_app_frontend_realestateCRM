String formatPrice(int price) {
  String priceString = price.toString();

  if (priceString.length <= 3) {
    return 'Rs. $priceString';
  }

  String lastThree =
      priceString.substring(priceString.length - 3);

  String remaining =
      priceString.substring(0, priceString.length - 3);

  List<String> parts = [];

  while (remaining.length > 2) {
    parts.insert(
      0,
      remaining.substring(remaining.length - 2),
    );

    remaining =
        remaining.substring(0, remaining.length - 2);
  }

  if (remaining.isNotEmpty) {
    parts.insert(0, remaining);
  }

  return 'Rs. ${parts.join(',')},$lastThree';
}
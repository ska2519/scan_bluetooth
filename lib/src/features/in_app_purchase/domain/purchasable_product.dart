import 'dart:math';

import 'package:in_app_purchase/in_app_purchase.dart';

String fruit() => fruits[Random().nextInt(fruits.length)];

const fruits = [
  '🍇',
  '🍈',
  '🍉',
  '🍊',
  '🍋',
  '🍌',
  '🍍',
  '🥭',
  '🍎',
  '🍏',
  '🍐',
  '🍑',
  '🍒',
  '🍓',
  '🥝',
  '🍅',
  '🥥'
];

enum ProductStatus {
  purchasable,
  purchased,
  pending,
}

class PurchasableProduct {
  PurchasableProduct(this.productDetails) : status = ProductStatus.purchasable;
  String get id => productDetails.id;

  String get title => productDetails.title;
  set title(String title) => title;
  String get description => productDetails.description;
  String get price => productDetails.price;
  ProductStatus status;
  ProductDetails productDetails;
}

import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String image;

  const Category({
    required this.name,
    required this.image,
  });

  @override
  List<Object> get props => [name, image];

  static List<Category> categories = const [
    Category(
      name: 'Burger %30 OFF',
      image: "assets/images/burger_discount.png",
    ),
    Category(
      name: '2 Coffee & 1 Cake',
      image: "assets/images/coffee_discount.png",
    ),
    Category(
      name: 'We Are Renewed',
      image: 'assets/images/weAreRenewed_image.png',
    ),
    Category(
      name: 'New Meal',
      image: 'assets/images/newProduct_image.png',
    ),
  ];
}

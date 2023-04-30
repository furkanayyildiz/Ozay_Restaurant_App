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
      name: 'Pizza',
      image:
          'https://www.unileverfoodsolutions.com.tr/dam/global-ufs/mcos/TURKEY/calcmenu/recipes/TR-recipes/desserts-&-bakery/karışık-pizza/main-header.jpg',
    ),
    Category(
      name: 'Burger',
      image:
          "https://cdn.yemek.com/uploads/2023/03/burger-king-menu-fiyatlari-2023-3.jpg",
    ),
    Category(
      name: 'Kebap',
      image:
          'https://cdn.yemek.com/mnresize/940/940/uploads/2016/05/adana-kebap-one-cikan.jpg',
    ),
    Category(
      name: 'Salad',
      image:
          'https://d17wu0fn6x6rgz.cloudfront.net/img/w/tarif/ogt/beyaz-peynirli-akdeniz-salatasi.webp',
    ),
  ];
}

import 'package:flutter/material.dart';

//page imports
import './admin_panel_items_model.dart';

final List<AdminPanelItemsModel> adminPanelItems = [
  AdminPanelItemsModel(
    id: "1",
    title: "Users",
    icon: Icons.person,
    route: "/adminPanelUsers",
  ),
  AdminPanelItemsModel(
    id: "2",
    title: "Orders",
    icon: Icons.shopping_cart,
    route: "/adminPanelOrders",
  ),
  AdminPanelItemsModel(
    id: "3",
    title: "Products",
    icon: Icons.fastfood,
    route: "/adminPanelProductsCategories",
  ),
  AdminPanelItemsModel(
    id: "4",
    title: "Categories",
    icon: Icons.category,
    route: "/adminPanelCategories",
  ),
  AdminPanelItemsModel(
    id: "5",
    title: "User Advices",
    icon: Icons.comment,
    route: "/adminPanelWishesAndComplaints",
  ),
];

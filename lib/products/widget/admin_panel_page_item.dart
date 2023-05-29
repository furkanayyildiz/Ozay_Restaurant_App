import 'package:flutter/material.dart';
import '../../core/admin_panel_items_model.dart';

class AdminPanelPageItem extends StatelessWidget {
  final AdminPanelItemsModel adminPanelItemsModel;

  AdminPanelPageItem(this.adminPanelItemsModel);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(adminPanelItemsModel.route);
      },
      splashColor: Colors.amber,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[
              Color.fromARGB(255, 160, 160, 160),
              Color.fromARGB(255, 224, 224, 224),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Text(
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              adminPanelItemsModel.title,
            ),
            Icon(adminPanelItemsModel.icon),
          ],
        ),
      ),
    );
  }
}

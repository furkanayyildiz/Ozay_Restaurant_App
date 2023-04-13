import 'package:flutter/material.dart';
import 'package:ozay_restaurant_app/products/widget/bottom_bar.dart';
import 'package:ozay_restaurant_app/products/widget/pop_appbar.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});
  static const String routeName = "/contact";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PopAppbar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.2,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Image.asset(
                  "assets/images/restaurant_picture.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const Text(
              "Contact Us",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SFProTex',
                  color: Colors.black54),
            ),
            _buildContactInfo(
                "Information Number", "05314991212", Icons.phone, context),
            _buildContactInfo(
                "Resepcition Number", "05314991212", Icons.phone, context),
            _buildContactInfo("E-Mail", "ozay_restaurant@gmail.com",
                Icons.email_sharp, context),
            _buildContactInfo(
                "Address",
                "Ataturk Street, No: 1923, Besiktas Istanbul",
                Icons.location_on,
                context),
            const Text(
              "Follow Us From Social Media",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SFProTex',
                  color: Colors.black54),
            ),
            _socialMediabuild(),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Row _socialMediabuild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 60,
          icon: Image.network(
            "https://www.mburaks.com/wp-content/uploads/2018/02/facebook-logo.png",
          ),
          onPressed: () {},
        ),
        IconButton(
          iconSize: 60,
          icon: Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/Instagram-Icon.png/1200px-Instagram-Icon.png"),
          onPressed: () {},
        ),
        IconButton(
          iconSize: 60,
          icon: Image.network(
              "https://productimages.hepsiburada.net/s/54/1500/11175563067442.jpg"),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildContactInfo(
      String title, String info, IconData icon, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'SFProTex',
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.secondary),
                const SizedBox(width: 10),
                Text(
                  info,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'SFProTex',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

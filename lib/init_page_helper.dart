part of "init_page.dart";

abstract class InitPageHelper {
  final List<BlocProvider> blocProviders = [
    BlocProvider<HomePageBloc>(create: (context) => HomePageBloc()),
  ];

  final Map<String, Widget Function(BuildContext)> routes = {
    '/home': (context) => HomePage(),
    // '/menu': (context) => MenuPage(),
    // '/sepet': (context) => SepetPage(),
    // '/contact': (context) => ContactPage(),
    '/profile': (context) => ProfilePage(),
  };

  final ThemeData themeData = ThemeData();
}

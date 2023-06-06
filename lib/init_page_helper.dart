part of "init_page.dart";

mixin InitPageHelper {
  final List<BlocProvider> blocProviders = [
    BlocProvider<UserBloc>(create: (context) => UserBloc()),
  ];

  final Map<String, Widget Function(BuildContext)> routes = {
    '/home': (context) => const HomePage(),
    '/menu': (context) => MenuPage(),
    '/contact': (context) => const ContactPage(),
    '/profile': (context) => ProfilePage(),
    '/login': (context) => LoginView(),
    "/cart": (context) => CartPage(),
    "/adminPanelUsers": (context) => const AdminPanelUsers(),
    "/adminPanelCategories": (context) => const AdminPanelCategories(),
    "/adminPanelProductsCategories": (context) =>
        const AdminPanelProductsCategories(),
    "/adminPanelProductsList": (context) => const AdminPanelProductsList(),
    // "/adminPanelProductEdit": (context) => AdminPanelProductEdit(),
  };

  final ThemeData themeData = ThemeData(
    // listTileTheme: ListTileThemeData(
    //   selectedColor: Colors.black54,
    //   selectedTileColor: Colors.grey.shade300,
    // ),
    // textTheme: TextTheme(
    //   headlineSmall: const TextStyle(
    //     color: Colors.black38,
    //     fontSize: 10,
    //     fontFamily: 'SFProTex',
    //   ),
    //   headlineMedium: const TextStyle(
    //     color: Colors.black54,
    //     fontSize: 12,
    //     fontFamily: 'SFProTex',
    //   ),
    //   headlineLarge: const TextStyle(
    //     color: Colors.black,
    //     fontSize: 16,
    //     fontFamily: 'SFProTex',
    //   ),
    //   titleSmall: TextStyle(
    //     color: Colors.red.shade900,
    //     fontSize: 12,
    //     fontWeight: FontWeight.bold,
    //   ),
    //   titleMedium: TextStyle(
    //     color: Colors.red.shade900,
    //     fontSize: 14,
    //     fontWeight: FontWeight.bold,
    //   ),
    //   titleLarge: TextStyle(
    //     color: Colors.red.shade900,
    //     fontSize: 20,
    //     fontWeight: FontWeight.bold,
    //   ),
    // ),
    colorScheme: ColorScheme(
      primary: Colors.red.shade800,
      secondary: Colors.blue.shade300,
      tertiary: Colors.redAccent.shade400,
      surface: Colors.white70,
      background: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.indigo.shade900,
      onBackground: Colors.indigo.shade900,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
  );
}

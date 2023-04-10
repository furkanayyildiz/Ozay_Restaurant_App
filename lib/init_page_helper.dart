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

  final ThemeData themeData = ThemeData(
    listTileTheme: ListTileThemeData(
      selectedColor: Colors.black54,
      selectedTileColor: Colors.grey.shade300,
    ),
    textTheme: TextTheme(
      bodySmall: const TextStyle(
        color: Colors.black38,
        fontSize: 14,
        fontFamily: 'SFProTex',
      ),
      bodyMedium: const TextStyle(
        color: Colors.black54,
        fontSize: 16,
        fontFamily: 'SFProTex',
      ),
      bodyLarge: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: 'SFProTex',
      ),
      titleSmall: TextStyle(
        color: Colors.red.shade900,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Colors.red.shade900,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: Colors.red.shade900,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: ColorScheme(
      primary: Colors.red.shade900,
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

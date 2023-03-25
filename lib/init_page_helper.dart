part of "init_page.dart";

abstract class InitPageHelper {
  final List<BlocProvider> blocProviders = [
    BlocProvider<HomePageBloc>(create: (context) => HomePageBloc()),
  ];

  final Map<String, Widget Function(BuildContext)> routes = {};

  final ThemeData themeData = ThemeData();
}

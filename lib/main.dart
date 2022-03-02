import 'package:cryptotracker/local_storage/local_storage.dart';
import 'package:cryptotracker/notifier/crypto_notifier.dart';
import 'package:cryptotracker/notifier/theme_notifier.dart';
import 'package:cryptotracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'helper/strings.dart';

class CryptoTrackerApp extends StatelessWidget {
  final String currentTheme;

  const CryptoTrackerApp({Key? key, required this.currentTheme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CryptoNotifier>(
          create: (context) => CryptoNotifier(),
        ),
        ChangeNotifierProvider<ThemeNotifier>(
          create: (context) => ThemeNotifier(currentTheme),
        )
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, child) {
          return MaterialApp(
            theme: theme.themeData,
            debugShowCheckedModeBanner: false,
            title: Strings.title,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}/*
class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(40),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Center(
              child: Text(r"$",style: TextStyle(fontSize: 300,color: Colors.white),)),
        ),
      ),
    );
  }
}
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String currentTheme = await LocalStorage.getTheme() ?? "light";
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(CryptoTrackerApp(currentTheme: currentTheme)));
}

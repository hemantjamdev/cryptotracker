import 'package:cryptotracker/notifier/crypto_notifier.dart';
import 'package:cryptotracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'helper/strings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const CryptoTrackerApp()));
}

class CryptoTrackerApp extends StatelessWidget {
  const CryptoTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CryptoNotifier(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Strings.title,
        home:  HomePage(),
      ),
    );
  }
}

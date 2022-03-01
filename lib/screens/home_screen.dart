import 'package:cryptotracker/notifier/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorite.dart';
import 'market.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome To",
                style: TextStyle(fontSize: 24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Crypto Tracker", style: TextStyle(fontSize: 42)),
                  Consumer<ThemeNotifier>(
                    builder: (context, theme, child) {
                      //   print("theme icon button");
                      return IconButton(
                        onPressed: () => theme.toggleTheme(),
                        icon: Icon(
                          theme.themeData == theme.lightTheme
                              ? Icons.nights_stay
                              : Icons.wb_sunny,
                        ),
                      );
                    },
                  )
                ],
              ),
              TabBar(
                controller: tabController,
                tabs: [
                  Tab(
                    child: Text(
                      'Markets',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Favorites',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    Market(),
                    Favorite(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_state_managements/feature/travel/view/travel_view.dart';

enum _TravelPages { home, bookmark, notification, profile }

class TravelTabView extends StatelessWidget {
  const TravelTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _TravelPages.values.length,
      child: Scaffold(
          bottomNavigationBar: const BottomAppBar(
            child: TabBar(tabs: [
              Tab(icon: Icon(Icons.show_chart)),
              Tab(icon: Icon(Icons.access_alarms)),
              Tab(icon: Icon(Icons.access_alarms)),
              Tab(icon: Icon(Icons.access_alarms)),
            ]),
          ),
          body: TabBarView(
            children: [
              TravelView(),
              SizedBox(),
              SizedBox(),
              SizedBox(),
            ],
          )),
    );
  }
}

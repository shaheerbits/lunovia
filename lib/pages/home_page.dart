import 'package:flutter/material.dart';
import 'package:lunovia/pages/songs_page.dart';
import 'package:lunovia/widgets/dot_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(48, 51, 54, 1),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                child: Text(
                    'LUNOVIA', style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                )),
              ),

              TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  unselectedLabelColor: Color.fromRGBO(138, 144, 156, 1),
                  labelColor: Color.fromRGBO(227, 227, 227, 1),
                  labelPadding: EdgeInsets.only(left: 24.0, right: 24),
                  indicator: DotIndicator(color: Color.fromRGBO(227, 227, 227, 1), radius: 4),
                  dividerHeight: 0,
                  splashBorderRadius: BorderRadius.circular(30),
                  splashFactory: NoSplash.splashFactory,
                  tabs: [
                    Tab(
                      child: Text(
                          'Songs',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                      ),
                    ),

                    Tab(
                      child: Text(
                        'Favorites',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ]
              ),

              Expanded(
                child: TabBarView(
                  children: [
                    SongsPage(),

                    Center(
                      child: Text('Favorites Page'),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multicamp_haberler_projesi/model/news_item_model.dart';
import 'package:multicamp_haberler_projesi/utils/constants.dart';
import 'package:multicamp_haberler_projesi/view/news_view/navigation_categories.dart';
import 'package:multicamp_haberler_projesi/view/news_view/navigator_home.dart';
import 'package:multicamp_haberler_projesi/view/setting_view/setting_view.dart';
import 'package:multicamp_haberler_projesi/widget/drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreenView extends StatefulWidget {
  final User user;
  HomeScreenView(this.user);

  @override
  _HomeScreenViewState createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  int _selectedIndex = 0;

  sayfalariGoster(index) {
    if (index == 0) {
      return RefreshIndicator(
        child: NavigatorHome(),
        onRefresh: () async {
          await verileriAl();
        },
      );
    } else if (index == 1) {
      return RefreshIndicator(
        child: NavigationCategories(),
        onRefresh: () async {
          await verileriAl();
        },
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    verileriAl();
  }

  verileriAl() {
    Provider.of<NewsItemModel>(context, listen: false).haberleriAl();
    Provider.of<NewsItemModel>(context, listen: false)
        .categoryHaberleriAl('all');
  }

  @override
  Widget build(BuildContext context) {
    var newsItem = Provider.of<NewsItemModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: newsItem.feed == null ? Text('') : Text(newsItem.feed.title),
        centerTitle: true,
        leading: Builder(
            builder: (context) => IconButton(
                icon: FaIcon(FontAwesomeIcons.ellipsisV),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                })),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SettingView()));
            },
          ),
        ],
      ),
      drawer: DrawerWidget(widget.user),
      body: sayfalariGoster(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Constants().mainColor,
        /* backgroundColor: AdaptiveTheme.of(context).isDefault
            ? Constants().mainColor
            : Colors.black12, */
        //fixedColor: Colors.red,
        unselectedItemColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.newspaper),
            //label: 'haberler'.tr().toString(),
            title: Text('haberler'.tr().toString()),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            //label: 'Kategoriler',
            title: Text('kategoriler'.tr().toString()),
          ),
          /* BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ), */
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Constants().buttonColor,
        onTap: _onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: false,
      ),
    );
  }
}

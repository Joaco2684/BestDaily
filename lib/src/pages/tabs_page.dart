import 'package:flutter/material.dart';
import 'package:news_provider/src/pages/tab1_page.dart';
import 'package:news_provider/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';


class TabsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
   ),
    );
  }
}

class _Navigation extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      selectedItemColor: Colors.red,
      currentIndex: navigationModel.actualPage,
      onTap: (value) => navigationModel.actualPage = value,
      items: [

        BottomNavigationBarItem(
          icon: Icon( Icons.person_outline ),
          label: 'For you'
        ),

        BottomNavigationBarItem(
          icon: Icon( Icons.public ),
          label: 'Headlines'
        ),

      ],
    );
  }
}

class _Pages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        
        Tab1Page(),

       Tab2Page()


      ],
    );
  }
}

class _NavigationModel with ChangeNotifier{

  int _actualPage = 0;
  PageController _pageController = new PageController();

  int get actualPage => this._actualPage;

  set actualPage( int value ) {
    this._actualPage = value;

    _pageController.animateToPage(value, duration: Duration(milliseconds: 250), curve: Curves.easeOut);

    notifyListeners();
  }

  PageController get pageController => this._pageController;

}
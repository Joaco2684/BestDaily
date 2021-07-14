import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_provider/src/models/category_model.dart';
import 'package:news_provider/src/models/news_models.dart';
import 'package:http/http.dart' as http;


final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = 'f5d64596e6724c7b8dcea31ee32385c9';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category( FontAwesomeIcons.building , 'business'),
    Category( FontAwesomeIcons.tv , 'entertainment'),
    Category( FontAwesomeIcons.addressCard , 'general'),
    Category( FontAwesomeIcons.headSideVirus , 'health'),
    Category( FontAwesomeIcons.vials , 'science'),
    Category( FontAwesomeIcons.volleyballBall , 'sports'),
    Category( FontAwesomeIcons.memory , 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};


  NewsService() {
    this.getTopHeadlines();

    categories.forEach((element) {
      this.categoryArticles[element.name] = [];
    });

  }

  get selectedCategory => this._selectedCategory;

  set selectedCategory (String valor) {
    this._selectedCategory = valor;

    this.getArticlesByCategory( valor );
    notifyListeners();
  }

  List<Article> get getArticlesSelectedCategory => this.categoryArticles[ this.selectedCategory ];


  getTopHeadlines() async {
    
  
    final url = Uri.parse('$_URL_NEWS/top-headlines?country=ar&apiKey=$_APIKEY');
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson( resp.body );

    this.headlines.addAll( newsResponse.articles );
    notifyListeners();


  }

  getArticlesByCategory( String category ) async {

    if (this.categoryArticles[category].length > 0) {
      return this.categoryArticles[category];
    }
    
    final url = Uri.parse('$_URL_NEWS/top-headlines?country=ar&apiKey=$_APIKEY&category=$category');
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson( resp.body );
    

    this.categoryArticles[category].addAll( newsResponse.articles );

    notifyListeners();

  }




}
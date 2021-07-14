import 'package:flutter/material.dart';
import 'package:news_provider/src/models/news_models.dart';
import 'package:news_provider/src/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ListNews extends StatelessWidget {

  final List<Article> news;

  const ListNews( this.news );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.news.length,
      itemBuilder: (context, index) {

        return _New( article: this.news[index], index: index );

      },
    );
  }
}

class _New extends StatelessWidget {

  final Article article;
  final int index;

  const _New({ 
    @required this.article, 
    @required this.index
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(height: 10,),

        _TopBarCard(article: article, index: index),

        _Titlecard(article: article),

        _ImageCard( article: article ),

        _BodyCard( article: article ),

        SizedBox(height: 10,),

        _ButtonsCard(article: article),

        SizedBox(height: 10,),
        Divider(),

        SizedBox(height: 10,)
      ],
    );
  }
}

class _TopBarCard extends StatelessWidget {

  final Article article;
  final int index;

  const _TopBarCard({ this.article, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${ index + 1 }. ', style: TextStyle( color: myTheme.accentColor ),),
          Text('${ article.source.name }. ',)
        ],
      ),

    );
  }
}

class _Titlecard extends StatelessWidget {

  final Article article;

  const _Titlecard({ this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text( article.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700), )
    );
  }
}

class _ImageCard extends StatelessWidget {

  final Article article;

  const _ImageCard({this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50) ),
        child: Container(
          child: ( article.urlToImage != null )
              ? FadeInImage(
                  placeholder: AssetImage( 'assets/giphy.gif' ),
                  image: NetworkImage(article.urlToImage),
                )
              : Image(image: AssetImage('assets/no-image.png'))
        ),
      ),
    );
  }
} 

class _BodyCard extends StatelessWidget {
  
  final Article article;

  const _BodyCard({ this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text( (article.description != null) ? article.description : ''),
    );
  }
}

class _ButtonsCard extends StatelessWidget {

  final Article article;

  const _ButtonsCard({ this.article});

  @override
  Widget build(BuildContext context) {

    final url = article.url;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          RawMaterialButton(
            onPressed: () async {
              //Abrir el sitio web
              if (await canLaunch(url) != null) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon( Icons.link ),
          )


        ],
      ),
    );
  }
}
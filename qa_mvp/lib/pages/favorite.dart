import 'package:flutter/material.dart';
import 'package:qa_mvp/utils/colors.dart';
import 'package:qa_mvp/utils/constants.dart';
import 'package:qa_mvp/components/quote_card.dart';
import 'package:qa_mvp/models/Quote.dart';

class FavoritesPage extends StatefulWidget {
  final quotes;
  final favorites;
  final quotesCallback;
  FavoritesPage({this.quotes, this.favorites, this.quotesCallback});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final globalKey = new GlobalKey<ScaffoldState>();
  List quotes;
  List<int> favorites;
  Function(int) quotesCallback;

  @override
  void initState() {
    super.initState();
    quotes = widget.quotes;
    favorites = widget.favorites;
    quotesCallback = widget.quotesCallback;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: cAppPrimaryColor,
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Favorites', style: TextStyle(color: Colors.black, fontSize: 20.0)),
        backgroundColor: cAppPrimaryColor,
        elevation: 5,
        brightness: Brightness.light,
      ),
      body: new SafeArea(
        child: new Stack(
          children: <Widget>[
            _container(),
          ],
        ),
      ),
    );
  }

  Widget _container() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      child: new Column(
        children: <Widget>[
          new Expanded(
            child: new ListView.builder(
              itemBuilder: _buildQuoteItem,
              itemCount: quotes.length,
            ),
          ),
        ],
      ),
    );
  }

  bool _getLikeFromId(int id) {
    return favorites.contains(id);
  }

  Widget _buildQuoteItem(BuildContext context, int index) {
    int id = quotes[index]['id'];
    String author = quotes[index]['author'];
    String quote = quotes[index]['quote'];
    String date = quotes[index]['date'];

    return Dismissible (
      key: Key(date),
      onDismissed: (direction) {
        quotesCallback(id);
      },
      child: new QuoteCard(
        like: _getLikeFromId(id),
        quote: Quote(type: QuoteCardTypes.Favorite, id: id, author: author, quote: quote, date: date),
        callback: () {},
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:qa_mvp/utils/colors.dart';
import 'package:qa_mvp/utils/constants.dart';
import 'package:qa_mvp/utils/app_shared_preferences.dart';
import 'package:qa_mvp/components/quote_card.dart';
import 'package:qa_mvp/models/Quote.dart';
import 'favorite.dart';

class QuotesPage extends StatefulWidget {
  final favorites;
  QuotesPage({this.favorites});

  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  final globalKey = new GlobalKey<ScaffoldState>();
  List quotes;
  List<int> favorites;
  ScrollController _scrollController = new ScrollController();

  List<QuoteCard> qcList = [];

  @override
  void initState() {
    super.initState();
    quotes = DailyQuotes.SampleData;
    favorites = widget.favorites;
    qcList = DailyQuotes.SampleData.map((d) => createQuoteCardWithIndex(DailyQuotes.SampleData.indexOf(d))).toList();
  }

  QuoteCard createQuoteCardWithIndex(int index) {
    int id = quotes[index]['id'];
    String author = quotes[index]['author'];
    String quote = quotes[index]['quote'];
    String date = quotes[index]['date'];
    return QuoteCard.getQuoteCard(
      _getLikeFromId(id),
      new Quote(type: QuoteCardTypes.All, id: id, author: author, quote: quote, date: date),
          () async {
        _quoteCardCallback(id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: globalKey,
      backgroundColor: cAppPrimaryColor,
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Quotes', style: TextStyle(color: Colors.black, fontSize: 20.0)),
        backgroundColor: cAppPrimaryColor,
        elevation: 5,
        brightness: Brightness.light,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                globalKey.currentContext,
                new MaterialPageRoute(
                  builder: (context) => new FavoritesPage(
                    quotes: _getFavoriteData(), favorites: favorites, quotesCallback: (int id) {
                      setState(() {
                        favorites.remove(id);
                        AppSharedPreferences.setFavorites(favorites);
                        qcList[id-1] = createQuoteCardWithIndex(id-1);
                        _scrollController.animateTo(2000.0, duration: const Duration(microseconds: 1), curve: Curves.easeOut);
                        new Future.delayed(const Duration(milliseconds: 500), () {
                          _scrollController.animateTo(0.0, duration: const Duration(microseconds: 1), curve: Curves.easeOut); }
                        );
                      });
                    }
                  ),
                ),
              );
            },
          ),
        ],
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

  List _getFavoriteData() {
    return quotes.where((d) => favorites.contains(d['id'])).toList();
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
              controller: _scrollController,
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
    return qcList[index];
  }

  void _quoteCardCallback(int id) {
    setState(() {
      if (_getLikeFromId(id)) {
        favorites.remove(id);
        AppSharedPreferences.setFavorites(favorites);
      } else {
        favorites.add(id);
        AppSharedPreferences.setFavorites(favorites);
      }

      qcList[id-1] = createQuoteCardWithIndex(id-1);
    });
  }
}
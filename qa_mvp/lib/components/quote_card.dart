import 'package:flutter/material.dart';
import 'package:qa_mvp/models/Quote.dart';
import 'package:qa_mvp/utils/constants.dart';
import 'package:qa_mvp/utils/colors.dart';

class QuoteCard extends StatefulWidget {
  bool like;
  Quote quote;
  VoidCallback callback;
  _QuoteCardState quoteState;

  QuoteCard({this.like, this.quote, this.callback});

  @override
  createState() => quoteState = new _QuoteCardState(
    like: this.like,
    quote: this.quote,
    callback: this.callback,
  );

  static Widget getQuoteCard(bool like, Quote quote, VoidCallback callback) {
    return new QuoteCard(like: like, quote: quote, callback: callback);
  }
}

class _QuoteCardState extends State<QuoteCard> {
  bool like;
  Quote quote;
  VoidCallback callback;

  _QuoteCardState({this.like, this.quote, this.callback});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: new Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0, bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    quote.author,
                    style: TextStyle(
                      color: cAppAuthorTextColor,
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  quote.type == QuoteCardTypes.All ?
                  new IconButton(
                    icon: _getIconButton(),
                    onPressed: () {
                      setState(() {
                        like = !like;
                        callback();
                      });
                    },
                  ) : new Padding(padding: EdgeInsets.all(0.0)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0, top: 5.0, right: 15.0, bottom: 10.0),
              child: new Text(quote.quote, overflow: TextOverflow.ellipsis, maxLines: 20),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0, top: 5.0, right: 15.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    quote.date,
                    style: TextStyle(
                        color: cAppQuoteDateTextColor,
                        fontSize: 15.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Icon _getIconButton() {
    if (like) {
      return Icon(Icons.favorite);
    } else {
      return Icon(Icons.favorite_border);
    }
  }
}
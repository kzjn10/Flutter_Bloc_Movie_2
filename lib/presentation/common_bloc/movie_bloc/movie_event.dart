import 'package:flutter/material.dart';

abstract class ArticleEvent {
  bool isFromApi;

  ArticleEvent({this.isFromApi});
}

class FetchArticleListEvent extends ArticleEvent {
  FetchArticleListEvent({bool fromApi}) : super(isFromApi: fromApi);
}

class FetchArticleDetailEvent extends ArticleEvent {
  final String articleId;
  FetchArticleDetailEvent({@required this.articleId, bool fromApi})
      : super(isFromApi: fromApi);
}

import 'package:insurance/domain/entities/article_detail_entity.dart';
import 'package:insurance/domain/entities/article_entity.dart';

abstract class ArticleState {}

class LoadArticleListState extends ArticleState {}

class LoadedArticleListState extends ArticleState {
  final List<ArticleEntity> data;

  LoadedArticleListState({this.data});
}

class FailToLoadArticleListState extends ArticleState {}

class LoadArticleDetailState extends ArticleState {}

class LoadedArticleDetailState extends ArticleState {
  final ArticleDetailEntity data;

  LoadedArticleDetailState({this.data});
}

class FailToLoadArticleDetailState extends ArticleState {}

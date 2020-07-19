import 'package:flutter/material.dart';

import 'package:insurance/domain/entities/article_detail_entity.dart';
import 'package:insurance/domain/entities/article_entity.dart';
import 'package:insurance/domain/repositories/article_repository.dart';

class ArticleUseCase {
  final ArticleRepository articleRepository;

  ArticleUseCase({this.articleRepository});

  Future<List<ArticleEntity>> getLatestArticles({bool isFromApi}) async {
    return articleRepository.getLatestArticles(isFromApi: isFromApi);
  }

  Future<ArticleDetailEntity> getArticleDetail(
      {@required String id, bool isFromApi}) async {
    return articleRepository.getArticleDetail(id: id, isFromApi: isFromApi);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:insurance/domain/usecases/article_usecase.dart';

import 'article_event.dart';
import 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleUseCase articleUseCase;

  ArticleBloc({this.articleUseCase});

  @override
  ArticleState get initialState => LoadArticleListState();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    switch (event.runtimeType) {
      case FetchArticleListEvent:
        yield* _mapLoadArticleListToState(event);
        break;
      case FetchArticleDetailEvent:
        yield* _mapLoadArticleDetailToState(event);
        break;
      default:
        break;
    }
  }

  Stream<ArticleState> _mapLoadArticleListToState(
      FetchArticleListEvent event) async* {
    try {
      yield LoadArticleListState();

      final bundleData =
          await articleUseCase.getLatestArticles(isFromApi: event.isFromApi);

      if (bundleData?.isNotEmpty ?? false) {
        yield LoadedArticleListState(data: bundleData);
      } else {
        yield FailToLoadArticleListState();
      }
    } catch (_) {
      yield FailToLoadArticleListState();
    }
  }

  Stream<ArticleState> _mapLoadArticleDetailToState(
      FetchArticleDetailEvent event) async* {
    try {
      yield LoadArticleDetailState();

      final orderData = await articleUseCase.getArticleDetail(
          id: event.articleId, isFromApi: true);

      if (orderData != null) {
        yield LoadedArticleDetailState(data: orderData);
      } else {
        yield FailToLoadArticleDetailState();
      }
    } catch (_) {
      yield FailToLoadArticleDetailState();
    }
  }
}

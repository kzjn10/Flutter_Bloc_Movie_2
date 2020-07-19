import 'package:flutter/material.dart';

import 'package:flutter_movie_app/common/constants/graphic_constants.dart';
import 'package:flutter_movie_app/common/constants/router_constants.dart';
import 'package:flutter_movie_app/common/internationalization.dart';
import 'package:flutter_movie_app/common/utils/my_scroll_behavior.dart';
import 'package:flutter_movie_app/data/datasources/remote/constants/remote_constants.dart';
import 'package:flutter_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_movie_app/presentation/journey/detail/movie_detail_constants.dart';
import 'package:flutter_movie_app/presentation/theme/theme_color.dart';
import 'package:flutter_movie_app/presentation/widgets/category_widget/category_widget.dart';
import 'package:flutter_movie_app/presentation/widgets/movie_list_widget/movie_list_widget.dart';
import 'package:flutter_movie_app/presentation/widgets/slideshow_widget/slideshow_widget.dart';
import 'package:flutter_movie_app/presentation/widgets/spacing_widget/spacing_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final logoWidth = MediaQuery.of(context).size.width * .25;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Image.asset(
          GraphicConstants.logo,
          width: logoWidth,
        ),
        centerTitle: true,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black, // Here
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ScrollConfiguration(
          key: UniqueKey(),
          behavior: MyScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SlideshowWidget(
                  onItemInteraction: (movieId) {
                    _navigateToMovieDetail(context, movieId);
                  },
                ),
                SpacingWidget(verticalSpacing: 30),
                CategoryWidget(),
                SpacingWidget(verticalSpacing: 30),
                _buildMyListWidget(context),
                SpacingWidget(verticalSpacing: 30),
                _buildPopularListWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMyListWidget(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    S.of(context).translate('homeScreen.title.myList'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                )
              ],
            ),
          ),
          MovieListWidget(
            type: MovieListType.topRated,
            onItemInteraction: (movieId) {
              _navigateToMovieDetail(context, movieId);
            },
          )
        ],
      ),
    );
  }

  Widget _buildPopularListWidget(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    S.of(context).translate('homeScreen.title.popular'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                )
              ],
            ),
          ),
          MovieListWidget(
            type: MovieListType.popular,
            onItemInteraction: (movieData) {
              _navigateToMovieDetail(context, movieData);
            },
          )
        ],
      ),
    );
  }

  Future<void> _navigateToMovieDetail(
      BuildContext context, MovieEntity data) async {
    await Navigator.pushNamed(
      context,
      RouteName.movieDetailScreen,
      arguments: MovieDetailArguments(
        movieId: '${data.id}',
        coverPath: data.backdropPath,
        title: data.title,
      ),
    );
  }
}

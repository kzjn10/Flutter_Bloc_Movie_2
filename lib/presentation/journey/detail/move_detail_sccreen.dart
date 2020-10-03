import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';

import 'package:flutter_movie_app/common/constants/graphic_constants.dart';
import 'package:flutter_movie_app/common/injector/injector.dart';
import 'package:flutter_movie_app/common/utils/cover_clipper.dart';
import 'package:flutter_movie_app/common/utils/my_scroll_behavior.dart';
import 'package:flutter_movie_app/common/utils/path_utils.dart';
import 'package:flutter_movie_app/domain/entities/country_entity.dart';
import 'package:flutter_movie_app/domain/entities/genre_entity.dart';
import 'package:flutter_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_movie_app/presentation/common_bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_movie_app/presentation/widgets/gallery_widget/gallery_widget.dart';
import 'package:flutter_movie_app/presentation/widgets/image_network_widget/image_network_widget.dart';
import 'package:flutter_movie_app/presentation/widgets/spacing_widget/spacing_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  final String movieId;
  final String coverPath;
  final String title;

  MovieDetailScreen({
    this.movieId,
    this.coverPath,
    this.title,
  });

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }

    _movieBloc = Injector.resolve<MovieBloc>()
      ..add(FetchMovieDetailEvent(movieId: widget.movieId));
  }

  @override
  void dispose() {
    _movieBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logoWidth = MediaQuery.of(context).size.width * .25;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBodyWidget(context),
          Positioned(
            //Place it at the top, and not use the entire screen
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              title: Image.asset(
                GraphicConstants.logo,
                width: logoWidth,
              ),
              centerTitle: true,
              brightness: Brightness.light,
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              //No more green
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.black, // Here
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return ScrollConfiguration(
      key: UniqueKey(),
      behavior: MyScrollBehavior(),
      child: SingleChildScrollView(
        child: BlocBuilder<MovieBloc, MovieState>(
          bloc: _movieBloc,
          builder: (context, state) {
            if (state is LoadedMovieDetailState) {
              return _buildContentWidget(context, state.data);
            } else {
              return _buildLoadingWidget(context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildContentWidget(BuildContext context, MovieEntity data) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildBackdropWidget(context, data?.posterPath ?? ''),
          SpacingWidget(verticalSpacing: 30),
          Container(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildMovieNameWidget(context, data?.originalTitle ?? ''),
                SpacingWidget(verticalSpacing: 30),
                _buildGenresWidget(context, data?.genres ?? <GenreEntity>[]),
                SpacingWidget(verticalSpacing: 30),
                _buildRatingWidget(
                    context, data?.voteAverage ?? 0.0, data?.voteCount ?? 0),
                SpacingWidget(verticalSpacing: 30),
                _buildMovieInfoWidget(
                  context,
                  data?.releaseDate ?? '',
                  data?.productionCountries ?? <CountryEntity>[],
                  data?.runtime ?? 0,
                ),
                SpacingWidget(verticalSpacing: 30),
                _buildMovieDescriptionWidget(context, data?.overview ?? ''),
                SpacingWidget(verticalSpacing: 30),
                _buildScreenShootWidget(context, data?.id ?? 0)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackdropWidget(BuildContext context, String backdrop) {
    return Container(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.biggest.width;
        return Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipPath(
                    clipper: CoverClipper(),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 10.0),
                              blurRadius: 10.0)
                        ],
                      ),
                      child: ImageNetworkWidget(
                        imageUrl:
                            PathUtils.getImagePath(backdrop, width: 'w780'),
                        fit: BoxFit.cover,
                        width: width,
                        height: width,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                          ),
                          onPressed: () {
                            debugPrint('>>>>>>> On Add Menu Pressed');
                          },
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.share,
                          ),
                          onPressed: () {
                            debugPrint('>>>>>>> On Share Menu Pressed');
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: width / 2 - 25,
              top: width,
              child: FractionalTranslation(
                translation: const Offset(0.0, -0.5),
                child: FloatingActionButton(
                  onPressed: () {
                    debugPrint('>>>>>>> On Floating Action Button Pressed');
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _buildMovieNameWidget(BuildContext context, String name) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildGenresWidget(BuildContext context, List<GenreEntity> genres) {
    final genresValue = StringBuffer();

    for (final item in genres) {
      if (item != null) {
        if (genresValue.length != 0) {
          genresValue.write(', ');
        }

        genresValue.write(item.name);
      }
    }

    return Container(
        alignment: Alignment.center,
        child: Text(
          genresValue.toString(),
          style: const TextStyle(
            color: Colors.black45,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  Widget _buildRatingWidget(
      BuildContext context, double voteAverage, int voteCount) {
    return Container(
      alignment: Alignment.center,
      child: StarRating(
        size: 25.0,
        rating: voteAverage / 2,
        color: Colors.red,
        borderColor: Colors.black54,
        starCount: 5,
      ),
    );
  }

  Widget _buildMovieInfoWidget(BuildContext context, String year,
      List<CountryEntity> productionCountry, int length) {
    final productionCountries = StringBuffer();
    for (final item in productionCountry) {
      if (item != null) {
        if (productionCountries.length != 0) {
          productionCountries.write(', ');
        }

        productionCountries.write(item.id);
      }
    }

    return Container(
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          _buildMovieMoreInfoItemWidget('Year', year.substring(0, 4) ?? ''),
          _buildMovieMoreInfoItemWidget(
              'Country', productionCountries.toString() ?? ''),
          _buildMovieMoreInfoItemWidget('Length', '$length min'),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieDescriptionWidget(
      BuildContext context, String description) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        description,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black87, fontSize: 14.0),
      ),
    );
  }

  Widget _buildScreenShootWidget(BuildContext context, int movieId) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: const <Widget>[
              Expanded(
                child: Text(
                  'Screenshots',
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
          GalleryWidget(movieId: '$movieId')
        ],
      ),
    );
  }

  Widget _buildMovieMoreInfoItemWidget(String title, String value) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        width: constraints.biggest.width > 100 ? 100 : double.infinity,
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SpacingWidget(verticalSpacing: 10),
            Wrap(
              children: <Widget>[
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter_movie_app/common/injector/injector.dart';
import 'package:flutter_movie_app/common/utils/path_utils.dart';
import 'package:flutter_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_movie_app/presentation/common_bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_movie_app/data/datasources/remote/constants/remote_constants.dart';
import 'package:flutter_movie_app/presentation/widgets/image_network_widget/image_network_widget.dart';
import 'package:flutter_movie_app/presentation/widgets/place_holder_widget/place_holder_widget.dart';

class SlideshowWidget extends StatefulWidget {
  final Function(MovieEntity) onItemInteraction;

  SlideshowWidget({this.onItemInteraction});

  @override
  _SlideshowWidgetState createState() => _SlideshowWidgetState();
}

class _SlideshowWidgetState extends State<SlideshowWidget> {
  MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }

    _movieBloc = Injector.resolve<MovieBloc>()
      ..add(FetchMovieListEvent(type: MovieListType.nowPlaying));
  }

  @override
  void dispose() {
    _movieBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<MovieBloc, MovieState>(
        bloc: _movieBloc,
        builder: (context, state) {
          if (state is LoadedMovieListState) {
            return _buildContentWidget(context, state.data);
          } else {
            return _buildLoadingSliderWidget(context);
          }
        },
      ),
    );
  }

  Widget _buildContentWidget(BuildContext context, List<MovieEntity> dataSet) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: CarouselSlider(
        height: width / 2,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        pauseAutoPlayOnTouch: const Duration(seconds: 10),
        enlargeCenterPage: true,
        items: dataSet.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  if (widget.onItemInteraction != null) {
                    widget.onItemInteraction(item);
                  } else {
                    debugPrint('>>>>>>> Handle stuff');
                  }
                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: _buildSliderItemWidget(item)),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSliderItemWidget(MovieEntity data) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: <Widget>[
            ImageNetworkWidget(
              imageUrl: PathUtils.getImagePath(data.backdropPath),
              fit: BoxFit.cover,
              height: constraints.biggest.height,
              width: constraints.biggest.width,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              width: constraints.biggest.width,
              height: constraints.biggest.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: const [0.1, 0.5, 0.7, 0.9],
                  colors: const [
                    Color(0x00000000),
                    Color(0x00000000),
                    Color(0x22000000),
                    Color(0x66000000),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  data?.title?.toUpperCase() ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _buildLoadingSliderWidget(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .8;
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0.0,
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: PlaceHolderWidget(
        width: width,
        height: width * 9 / 16,
      ),
    );
  }
}

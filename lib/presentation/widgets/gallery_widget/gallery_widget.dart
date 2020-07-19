import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_movie_app/common/injector/injector.dart';
import 'package:flutter_movie_app/common/utils/path_utils.dart';
import 'package:flutter_movie_app/domain/entities/movie_image_entity.dart';
import 'package:flutter_movie_app/presentation/common_bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_movie_app/presentation/widgets/image_network_widget/image_network_widget.dart';

class GalleryWidget extends StatefulWidget {
  final String movieId;

  GalleryWidget({this.movieId});

  @override
  _GalleryWidgetState createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }

    _movieBloc = Injector.resolve<MovieBloc>()
      ..add(FetchMovieGraphicEvent(movieId: widget.movieId));
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
          if (state is LoadedMovieGraphicState) {
            return _buildContentWidget(context, state.data);
          } else {
            return _buildLoadingWidget(context);
          }
        },
      ),
    );
  }

  Widget _buildContentWidget(BuildContext context, MovieImageEntity data) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: width / 3,
      margin: const EdgeInsets.only(bottom: 50, top: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.posters.length > 10 ? 10 : data.posters.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItemWidget(
              data.posters[index].filePath, width / 3, index == 0);
        },
      ),
    );
  }

  Widget _buildItemWidget(String imagePath, double itemHeight, bool isFirst) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: EdgeInsets.only(left: isFirst ? 0 : 10, right: 10, bottom: 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: ImageNetworkWidget(
        imageUrl: PathUtils.getImagePath(imagePath),
        fit: BoxFit.cover,
        width: itemHeight * 4 / 3,
        height: itemHeight / 2,
      ),
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

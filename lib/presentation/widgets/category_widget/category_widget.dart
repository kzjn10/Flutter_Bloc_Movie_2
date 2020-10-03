import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_movie_app/common/injector/injector.dart';
import 'package:flutter_movie_app/common/utils/path_utils.dart';
import 'package:flutter_movie_app/data/datasources/remote/constants/remote_constants.dart';
import 'package:flutter_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_movie_app/presentation/common_bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_movie_app/presentation/widgets/image_network_widget/image_network_widget.dart';

class CategoryWidget extends StatefulWidget {
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }

    _movieBloc = Injector.resolve<MovieBloc>()
      ..add(FetchMovieListEvent(type: MovieListType.upcoming));
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
            return _buildLoadingWidget(context);
          }
        },
      ),
    );
  }

  Widget _buildContentWidget(BuildContext context, List<MovieEntity> data) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: width / 4,
      margin: const EdgeInsets.only(bottom: 10, top: 25),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length > 10 ? 10 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItemWidget(data[index], width / 3, index == 0);
        },
      ),
    );
  }

  Widget _buildItemWidget(MovieEntity data, double itemHeight, bool isFirst) {
    return Container(
      width: itemHeight * 4 / 3,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10.0,
        margin: EdgeInsets.only(left: isFirst ? 20 : 10, right: 10, bottom: 20),
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
                alignment: Alignment.center,
                width: constraints.biggest.width,
                height: constraints.biggest.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      Color(0x99ff0000),
                      Color(0x66ff0000),
                      Color(0x66ff0000),
                      Color(0x99ff0000),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    data?.releaseDate,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return Container();
  }
}

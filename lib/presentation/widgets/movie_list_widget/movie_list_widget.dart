import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_movie_app/common/injector/injector.dart';
import 'package:flutter_movie_app/common/utils/path_utils.dart';
import 'package:flutter_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_movie_app/presentation/common_bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_movie_app/presentation/widgets/image_network_widget/image_network_widget.dart';

class MovieListWidget extends StatefulWidget {
  final String type;
  final Function(MovieEntity) onItemInteraction;

  MovieListWidget({this.type, this.onItemInteraction});

  @override
  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }

    _movieBloc = Injector.resolve<MovieBloc>()
      ..add(FetchMovieListEvent(type: widget.type));
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

  Widget _buildContentWidget(BuildContext context, List<MovieEntity> dataSet) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: width / 1.75,
      margin: const EdgeInsets.only(bottom: 10, top: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dataSet.length > 10 ? 10 : dataSet.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {
                if (widget.onItemInteraction != null) {
                  widget.onItemInteraction(dataSet[index]);
                } else {
                  debugPrint('>>>>>>> Handle stuff');
                }
              },
              child:
                  _buildMovieItemWidget(dataSet[index], width / 4, index == 0));
        },
      ),
    );
  }

  Widget _buildMovieItemWidget(
      MovieEntity data, double itemHeight, bool isFirst) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 7.0,
      margin: EdgeInsets.only(left: isFirst ? 20 : 10, right: 10, bottom: 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: ImageNetworkWidget(
        imageUrl: PathUtils.getImagePath(data.posterPath),
        fit: BoxFit.cover,
        width: itemHeight * 4 / 3,
        height: itemHeight / 2,
      ),
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return Container();
  }
}

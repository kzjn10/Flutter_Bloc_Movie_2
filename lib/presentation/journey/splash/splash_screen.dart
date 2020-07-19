import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app/common/constants/router_constants.dart';
import 'package:flutter_movie_app/common/injector/injector.dart';
import 'package:flutter_movie_app/common/internationalization.dart';
import 'package:flutter_movie_app/presentation/common_bloc/timer_bloc/timer_bloc.dart';
import 'package:flutter_movie_app/presentation/journey/base/base_state_widget.dart';
import 'package:flutter_movie_app/presentation/theme/theme_color.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseStateWidget<SplashScreen> {
  TimerBloc _timerBloc;

  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }

    _timerBloc = Injector.resolve<TimerBloc>()
      ..add(const TimerStarted(duration: 3));
  }

  @override
  void dispose() {
    _timerBloc.close();
    super.dispose();
  }

  @override
  Widget buildContentView(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackgroundWidget(context),
          Center(
            child: BlocListener<TimerBloc, TimerState>(
              bloc: _timerBloc,
              listener: (context, state) {
                if (state is TimerRunComplete) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteName.homeScreen,
                    ModalRoute.withName(RouteName.initial),
                  );
                }
              },
              child: BlocBuilder<TimerBloc, TimerState>(
                bloc: _timerBloc,
                builder: (context, state) {
                  final minutesStr = ((state.duration / 60) % 60)
                      .floor()
                      .toString()
                      .padLeft(2, '0');
                  final secondsStr =
                      (state.duration % 60).floor().toString().padLeft(2, '0');
                  return Text(
                    S.of(context).translate('splashScreen.message.delayTime',
                        params: ['$minutesStr:$secondsStr']),
                    style: Theme.of(context).textTheme.headline6,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBackgroundWidget(BuildContext context) {
    return Container(color: AppColor.primaryColor);
  }
}

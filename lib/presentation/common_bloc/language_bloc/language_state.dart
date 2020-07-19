import 'package:insurance/presentation/common_bloc/base/base_bloc_state.dart';

class LanguageState extends BaseBlocState {
  LanguageState() : super(timeStamp: DateTime.now().millisecondsSinceEpoch);
}

class StartAppState extends LanguageState {}

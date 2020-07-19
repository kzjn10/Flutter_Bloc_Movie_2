import 'package:bloc/bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(StartAppState());

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) {
    throw UnimplementedError();
  }
}

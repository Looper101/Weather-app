import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    print('bloc:$bloc transition:$transition');
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    print("$bloc ==> event emmited: $event");
    super.onEvent(bloc, event);
  }
}

import 'package:app_bloc_flutter/app/data/repository/api_service_repository.dart';
import 'package:app_bloc_flutter/app/modules/counter/bloc/counter_events.dart';
import 'package:app_bloc_flutter/app/modules/counter/bloc/counter_state.dart';
import 'package:bloc/bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc(this._serviceRepository) : super(counterInitialState) {
    on<InitialCounterEvent>(_initial);
    on<IncrementEvent>(_increment);
    on<DecrementEvent>(_decrement);
  }

  final ApiServiceRepository _serviceRepository;

  void _initial(InitialCounterEvent event, Emitter<CounterState> emit) async {
    _serviceRepository.log();
    emit(state.copyWith(loading: true));
    await Future.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(loading: false));
  }

  void _increment(IncrementEvent event, Emitter<CounterState> emit) async {
    emit(
      state.copyWith(
        count: state.count + 1,
        oldCount: state.count,
        loading: true,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 200));
    emit(
      state.copyWith(
        loading: false,
      ),
    );
  }

  void _decrement(DecrementEvent event, Emitter<CounterState> emit) async {
    if (state.count > 0) {
      emit(
        state.copyWith(
          count: state.count - 1,
          oldCount: state.count,
          loading: true,
        ),
      );
      await Future.delayed(const Duration(milliseconds: 200));
      emit(
        state.copyWith(
          loading: false,
        ),
      );
    }
  }
}

class LoadingObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
  }
}

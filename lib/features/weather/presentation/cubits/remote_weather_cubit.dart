import 'package:bloc/bloc.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_data.dart';
import 'package:weather_app/features/weather/presentation/cubits/remote_weather_state.dart';

class RemoteWeatherCubit extends Cubit<RemoteWeatherState> {
  final GetWeatherDataUseCase getWeatherDataUseCase;
  RemoteWeatherCubit(super.initialState, {required this.getWeatherDataUseCase});

  Future<void> getWeatherData() async {
    emit(const RemoteWeatherLoading());
    final dataState = await getWeatherDataUseCase.call();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(RemoteWeatherDone(dataState.data!));
    } else if (dataState is DataFailed && dataState.error != null) {
      emit(RemoteWeatherError(dataState.error!));
    }
  }
}

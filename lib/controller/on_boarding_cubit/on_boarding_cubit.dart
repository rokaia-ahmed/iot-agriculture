import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_agriculture/controller/on_boarding_cubit/on_boarding_states.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(InitialIndexState());

  static OnBoardingCubit get(BuildContext ctx) => BlocProvider.of(ctx);

  int index = 0;

  void updateIndexValue({required int value}) {
    index = value;
    emit(UpdateIndexState());
  }
}

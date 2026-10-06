import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/core/api/result_api.dart';
import 'package:news_app/features/home/domain/entities/news_entity.dart';
import 'package:news_app/features/home/domain/use_case/get_news_use_case.dart';
import 'package:news_app/features/home/presentation/view_model/home_cubit/home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getNewsUseCase) : super(HomeInitial());
  final GetNewsUseCase _getNewsUseCase;

  Future<void> fetchNews() async {
    emit(HomeLoading());
    var result = await _getNewsUseCase.invoke();
    switch (result) {
      case Success<NewsEntity>():
        emit(HomeSuccess(result.data.articles));
      case Failure():
        emit(HomeError(result.messageError));
    }
  }
}

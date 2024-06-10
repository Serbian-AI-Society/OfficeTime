import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:re_searcher_ui/core/domain/chat_repository.dart';
import 'package:re_searcher_ui/core/injection_container.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ChatRepository chatRepository = IC.getIt();

  HomeBloc() : super(HomeInitial()) {
    on<PingServerEvent>((event, emit) {
      chatRepository.pingServer();
    });
  }
}

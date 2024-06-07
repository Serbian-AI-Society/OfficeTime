import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:re_searcher_ui/core/domain/chat_repository.dart';
import 'package:re_searcher_ui/core/domain/chat_repository_impl.dart';
import 'package:re_searcher_ui/features/chat/bloc/chat_bloc.dart';
import 'package:re_searcher_ui/features/home/bloc/home_bloc.dart';

class IC {
  static final getIt = GetIt.instance;

  static Future<void> setUp() async {
    // Setup Dio
    getIt.registerLazySingletonAsync<Dio>(() async {
      var dio = Dio();
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
        options.headers["Token"] = "OfficeTimePassword";
        return handler.next(options);
      }));

      return dio;
    });

     await getIt.isReady<Dio>();
    // Setup repositories
    getIt.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(dio: getIt()));

    // Setup bloc
    getIt.registerLazySingleton(() => HomeBloc());
    getIt.registerLazySingleton(() => ChatBloc());
  }
}

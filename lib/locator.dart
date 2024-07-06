import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/remote/gemini_api_service.dart';
import 'data/repository/api_repository_impl.dart';
import 'domain/repository/api_repository.dart';

final locator = GetIt.instance;

Future<void> initializeDependecies() async {
  final dio = Dio();
  dio.interceptors.add(AwesomeDioInterceptor());

  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<GeminiApiService>(
    GeminiApiService(),
  );

  locator.registerSingleton<ApiRepository>(
    ApiRepositoryImp(locator<GeminiApiService>()) as ApiRepository,
  );
}

import 'package:dio/dio.dart';

import '../../domain/entities/response/api_response.dart';
import '../../domain/entities/response/content.dart';
import '../../domain/repository/api_repository.dart';
import '../../utils/resources/data_state.dart';
import '../datasources/remote/gemini_api_service.dart';

class ApiRepositoryImp implements ApiRepository {
  final GeminiApiService _geminiApiService;

  ApiRepositoryImp(
    this._geminiApiService,
  );

  @override
  Future<DataState<ApiResponse>> getResponse({
    required List<Content> request,
  }) async {
    try {
      final httpResponse = await _geminiApiService.chatTextGeneration(request);
      if (httpResponse.statusCode == 200) {
        return DataSuccess(data: ApiResponse.fromJson(httpResponse.data));
      } else {
        throw DioException(
          response: httpResponse,
          requestOptions: httpResponse.requestOptions,
        );
      }
    } on DioException catch (error) {
      return DataFailed(error: error);
    }
  }
}

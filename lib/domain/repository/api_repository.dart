


import '../../utils/resources/data_state.dart';
import '../entities/response/api_response.dart';
import '../entities/response/content.dart';

abstract class ApiRepository {
  Future<DataState<ApiResponse>> getResponse({
    required List<Content> request,
  });
}

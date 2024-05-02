import 'package:My.solution/domain/entities/response/api_response.dart';
import 'package:My.solution/domain/entities/response/content.dart';
import 'package:My.solution/utils/resources/data_state.dart';

abstract class ApiRepository {
  Future<DataState<ApiResponse>> getResponse({
    required List<Content> request,
  });
}

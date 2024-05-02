import 'package:My.solution/domain/entities/response/part.dart';
import 'package:My.solution/domain/entities/response/content.dart';
import 'package:My.solution/domain/repository/api_repository.dart';
import 'package:My.solution/presentation/cubit/chat/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatSuccessState> {
  final ApiRepository _apiRepository;
  ChatCubit(this._apiRepository)
      : super(
          const ChatSuccessState(
            isLoading: false,
          ),
        );
  List<Content> messages = [];
  Future<void> getAnswer(String text) async {
    //
    messages.insert(0, Content(role: "user", parts: [Parts(text: text)]));
    emit(ChatSuccessState(isLoading: true, messages: messages));
    // Api call
    final response =
        await _apiRepository.getResponse(request: messages.reversed.toList());
    print("Repsone-DATA-->${response.data!.toJson()}");
    print("Repsone-ERRor--->${response.error}");
    messages.insert(
      0,
      Content(
        role: 'model',
        parts: [
          Parts(text: response.data!.candidates.first.content.parts.first.text)
        ],
      ),
    );
    emit(ChatSuccessState(isLoading: false, messages: messages));
  }
}

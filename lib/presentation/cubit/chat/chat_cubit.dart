import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/response/content.dart';
import '../../../domain/entities/response/part.dart';
import '../../../domain/repository/api_repository.dart';
import 'chat_state.dart';

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

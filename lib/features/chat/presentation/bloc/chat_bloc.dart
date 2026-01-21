import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/features/chat/domain/entities/chat_message.dart';
import 'package:quant_ai/features/chat/domain/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _repository;

  ChatBloc(this._repository) : super(ChatInitial()) {
    on<ChatStarted>(_onChatStarted);
    on<ChatMessageSent>(_onMessageSent);
  }

  void _onChatStarted(ChatStarted event, Emitter<ChatState> emit) {
    emit(ChatLoaded(messages: const []));
  }

  Future<void> _onMessageSent(
    ChatMessageSent event,
    Emitter<ChatState> emit,
  ) async {
    final currentState = state;
    if (currentState is ChatLoaded) {
      // Add user message immediately
      final userMessage = ChatMessage(
        id: DateTime.now().toString(), // Temp ID
        text: event.message,
        isUser: true,
        timestamp: DateTime.now(),
      );

      final updatedMessages = List<ChatMessage>.from(currentState.messages)
        ..add(userMessage);
      emit(ChatLoaded(messages: updatedMessages, isTyping: true));

      // Fetch AI response
      final result = await _repository.sendMessage(event.message);

      result.fold(
        (failure) {
          // Handle error (maybe add an error message to the chat)
          emit(ChatLoaded(messages: updatedMessages, isTyping: false));
          emit(
            ChatError(failure.message),
          ); // Or stick to loaded with error snackbar
        },
        (aiMessage) {
          final newMessages = List<ChatMessage>.from(updatedMessages)
            ..add(aiMessage);
          emit(ChatLoaded(messages: newMessages, isTyping: false));
        },
      );
    }
  }
}

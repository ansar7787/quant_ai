import 'package:dartz/dartz.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/error/failures.dart';
import 'package:quant_ai/features/chat/domain/entities/chat_message.dart';
import 'package:quant_ai/features/chat/domain/repositories/chat_repository.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final GenerativeModel _model;

  ChatRepositoryImpl(this._model);

  @override
  Future<Either<Failure, ChatMessage>> sendMessage(String message) async {
    try {
      final content = [Content.text(message)];
      final response = await _model.generateContent(content);

      if (response.text == null) {
        return Left(ServerFailure('No response from AI'));
      }

      return Right(
        ChatMessage(
          id: const Uuid().v4(),
          text: response.text!,
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:quant_ai/core/error/failures.dart';
import 'package:quant_ai/features/chat/domain/entities/chat_message.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatMessage>> sendMessage(String message);
}

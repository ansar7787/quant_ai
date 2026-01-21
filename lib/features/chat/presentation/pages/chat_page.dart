import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quant_ai/di/injection.dart';
import 'package:quant_ai/features/chat/domain/entities/chat_message.dart';
import 'package:quant_ai/features/chat/presentation/bloc/chat_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatBloc>()..add(ChatStarted()),
      child: Scaffold(
        appBar: AppBar(title: const Text('AI Advisor')),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  List<ChatMessage> messages = [];
                  bool isTyping = false;

                  if (state is ChatLoaded) {
                    messages = state.messages;
                    isTyping = state.isTyping;
                  }

                  if (messages.isEmpty && !isTyping) {
                    return const Center(
                      child: Text('Ask me anything about crypto!'),
                    );
                  }

                  return ListView.builder(
                    reverse: true, // Show newest at bottom
                    padding: EdgeInsets.all(16.w),
                    itemCount: messages.length + (isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (isTyping && index == 0) {
                        return const Align(
                          alignment: Alignment.centerLeft,
                          child: Chip(label: Text('AI is typing...')),
                        );
                      }

                      // Adjust index if typing indicator is present
                      final messageIndex = isTyping ? index - 1 : index;
                      // Reverse index for data source since listview is reversed
                      final chatMessage =
                          messages[messages.length - 1 - messageIndex];

                      return _MessageBubble(message: chatMessage);
                    },
                  );
                },
              ),
            ),
            const _ChatInput(),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isUser
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
            bottomLeft: isUser ? Radius.circular(12.r) : Radius.circular(0),
            bottomRight: isUser ? Radius.circular(0) : Radius.circular(12.r),
          ),
        ),
        constraints: BoxConstraints(maxWidth: 0.75.sw),
        child: Text(
          message.text,
          style: TextStyle(
            color: isUser
                ? Colors.white
                : Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }
}

class _ChatInput extends StatefulWidget {
  const _ChatInput();

  @override
  State<_ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<_ChatInput> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        16.w,
      ).copyWith(bottom: 16.w + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type your message...',
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    context.read<ChatBloc>().add(ChatMessageSent(_controller.text));
    _controller.clear();
  }
}

import 'package:cases/gemini/models/message.dart';
import 'package:cases/gemini/providers/get_all_messages_provider.dart';
import 'package:cases/gemini/widgets/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesList extends ConsumerWidget {
  const MessagesList({super.key, required this.userId});

  // final List<Message> messages;
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageData = ref.watch(getAllMesswageProvider(userId));
    return messageData.when(
      data: (messages) {
        return ListView.builder(
          reverse : true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages.elementAt(index);
            return MessageTile(
              isOutGoing: message.isMine,
              message: message,
            );
          },
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()));
      },
      loading: () {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

import 'package:cases/gemini/repositories/auth_repository.dart';
import 'package:cases/gemini/repositories/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatProvider = Provider(
  (ref) => ChatRepository(),
);

final authProvider = Provider(
  (ref) => AuthRepository(),
);

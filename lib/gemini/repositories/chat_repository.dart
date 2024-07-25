// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

@immutable
class ChatRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future sendMessage({
    required String apiKey,
    required XFile? image,
    required String PromptText,
  }) async {
    final textModel = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final imageModel =
        GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);
    final userId = _auth.currentUser!.uid;
    final sendMessageId = const Uuid().v4();
  }
}

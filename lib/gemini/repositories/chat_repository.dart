// ignore_for_file: unused_field, unused_local_variable, unused_label

import 'package:cases/gemini/extensions/extensions.dart';
import 'package:cases/gemini/models/message.dart';
import 'package:cases/gemini/repositories/storage_repository.dart';
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
    required String promptText,
  }) async {
    //? textModel........................
    final textModel = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final imageModel =
        GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);

    final userId = _auth.currentUser!.uid;
    final sentMessageId = Uuid().v4();

    Message message = Message(
      id: sentMessageId,
      message: promptText,
      createdAt: DateTime.now(),
      isMine: true,
    );

    if (image != null) {
      final downloadUrl = await StorageRepository().saveImageToStorage(
        image: image,
        messageId: sentMessageId,
      );

      message = message.copyWith(
        imageUrl: downloadUrl,
      ) as Message;
    }

    await _firestore
        .collection('conversations')
        .doc(userId)
        .collection("message")
        .doc(sentMessageId)
        .set(message.toMap());

    //? create response
    GenerateContentResponse response;
    try {
      if (image == null) {
        response = await textModel.generateContent([Content.text(promptText)]);
      } else {
        //? convert it to Uimnt8List
        final imageBytes = await image.readAsBytes();

        //? define your parts
        final prompt = TextPart(promptText);
        final mimeType = image..getMimeTypeFromExtension();
        final imagePart = DataPart(mimeType as String, imageBytes);

        //? make a multimodel request to Gemini AI ............
        response = await imageModel.generateContent([
          Content.multi([
            prompt,
            imagePart,
          ])
        ]);
      }
      final responseText = response.text;

      //? save the response to firebase
      final receivedMessageId = const Uuid().v4();

      final responseMessage = Message(
        id: receivedMessageId,
        message: responseText!,
        createdAt: DateTime.now(),
        isMine: false,
      );

      //? save message tok firebase
      await _firestore
          .collection('conversations')
          .doc(userId)
          .collection('messages')
          .doc(receivedMessageId)
          .set(responseMessage.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

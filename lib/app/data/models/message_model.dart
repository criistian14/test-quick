import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testquick/app/domain/entities/message.dart';

class MessageModel extends Message {
  final String idConversation;
  final File pictureFile, audioFile;

  MessageModel({
    String message,
    String picture,
    String audio,
    bool read,
    String idFrom,
    String idTo,
    DateTime createdAt,
    this.idConversation,
    this.pictureFile,
    this.audioFile,
  }) : super(
          message: message,
          picture: picture,
          audio: audio,
          read: read,
          idFrom: idFrom,
          idTo: idTo,
          createdAt: createdAt,
        );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json["message"],
      picture: json["picture"],
      audio: json["audio"],
      read: json["read"] ?? false,
      idFrom: json["id_from"],
      idTo: json["id_to"],
      createdAt: json["created_at"] != null
          ? (json['created_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "picture": picture,
      "audio": audio,
      "read": read ?? false,
      "id_from": idFrom,
      "id_to": idTo,
    };
  }

  MessageModel copyWith({
    String message,
    String picture,
    String audio,
    bool read,
    String idFrom,
    String idTo,
    DateTime createdAt,
    String idConversation,
  }) =>
      MessageModel(
        message: message ?? this.message,
        picture: picture ?? this.picture,
        audio: audio ?? this.audio,
        read: read ?? this.read,
        idFrom: idFrom ?? this.idFrom,
        idTo: idTo ?? this.idTo,
        createdAt: createdAt ?? this.createdAt,
        idConversation: idConversation ?? this.idConversation,
      );
}

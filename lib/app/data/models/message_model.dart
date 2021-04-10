import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testquick/app/domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    String message,
    String picture,
    String audio,
    bool read,
    String idFrom,
    String idTo,
    DateTime createdAt,
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
}

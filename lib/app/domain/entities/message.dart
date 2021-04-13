import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String message, picture, audio;
  final bool read;
  final String idFrom, idTo;
  final DateTime createdAt;

  Message({
    this.message,
    this.picture,
    this.audio,
    this.read,
    this.idFrom,
    this.idTo,
    this.createdAt,
  });

  @override
  List<Object> get props => [
        message,
        picture,
        audio,
        read,
        idFrom,
        idTo,
        createdAt,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final String content;
  final String time;
  Note({
    this.id,
    @required this.title,
    @required this.content,
    this.time,
  });
  @override
  List<Object> get props => [id, title, content, time];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Note extends Equatable {
  final String id;
  final String nim;
  final String nama;
  final String kelas;
  final String time;
  Note({
    this.id,
    @required this.nim,
    @required this.nama,
    @required this.kelas,
    this.time,
  });
  @override
  List<Object> get props => [id, nim, nama, kelas, time];
}

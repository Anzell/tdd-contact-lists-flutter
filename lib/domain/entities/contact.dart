import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String? id;
  final String name;
  final String number;

  const Contact({
    required this.name,
    required this.number,
    this.id,
  });

  @override
  List<Object?> get props => [id, name, number];
}

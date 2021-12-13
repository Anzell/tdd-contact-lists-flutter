import 'package:equatable/equatable.dart';

class SearchFilter extends Equatable {
  final String? number;
  final String? name;

  const SearchFilter({
    this.number,
    this.name,
  });

  @override
  List<Object?> get props => [number, name];
}

import 'package:equatable/equatable.dart';

class MemoryCard extends Equatable {
  final String id;
  final String front;
  final String back;

  const MemoryCard({required this.id, required this.front, required this.back});

  MemoryCard copyWith({String? id, String? front, String? back}) {
    return MemoryCard(
      id: id ?? this.id,
      front: front ?? this.front,
      back: back ?? this.back,
    );
  }

  @override
  List<Object?> get props => [id, front, back];
}

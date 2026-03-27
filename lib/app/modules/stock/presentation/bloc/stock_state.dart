import 'package:equatable/equatable.dart';

/// Estados do módulo de estoque (placeholder para evolução com BLoC dedicado).
abstract class StockState extends Equatable {
  const StockState();

  @override
  List<Object?> get props => [];
}

class StockInitial extends StockState {
  const StockInitial();
}

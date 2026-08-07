import '../../data/models/bus_model.dart';
import '../../data/models/recommendation_model.dart';

abstract class PassengerState {
  final List<BusModel> buses;
  final List<RecommendationModel> recommendations;
  final String searchQuery;
  final bool seatsOnlyFilter;
  final BusModel? selectedBus;

  const PassengerState({
    required this.buses,
    required this.recommendations,
    this.searchQuery = '',
    this.seatsOnlyFilter = false,
    this.selectedBus,
  });
}

class PassengerInitial extends PassengerState {
  PassengerInitial()
      : super(
          buses: [],
          recommendations: [],
        );
}

class PassengerLoading extends PassengerState {
  PassengerLoading({
    required super.buses,
    required super.recommendations,
    super.searchQuery,
    super.seatsOnlyFilter,
    super.selectedBus,
  });
}

class PassengerLoaded extends PassengerState {
  PassengerLoaded({
    required super.buses,
    required super.recommendations,
    super.searchQuery,
    super.seatsOnlyFilter,
    super.selectedBus,
  });
}

class PassengerError extends PassengerState {
  final String message;

  PassengerError({
    required super.buses,
    required super.recommendations,
    required this.message,
    super.searchQuery,
    super.seatsOnlyFilter,
    super.selectedBus,
  });
}

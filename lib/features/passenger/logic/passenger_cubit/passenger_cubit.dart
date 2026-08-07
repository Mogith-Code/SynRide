import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/passenger_repository.dart';
import '../../data/models/bus_model.dart';
import 'passenger_state.dart';

class PassengerCubit extends Cubit<PassengerState> {
  final PassengerRepository repository;

  PassengerCubit({required this.repository}) : super(PassengerInitial());

  void loadPassengerData() {
    emit(PassengerLoaded(
      buses: repository.liveBuses,
      recommendations: repository.recommendations,
    ));
  }

  void searchBuses(String query) {
    List<BusModel> filtered = repository.searchBuses(query);
    if (state.seatsOnlyFilter) {
      filtered = filtered.where((b) => b.hasAvailableSeats).toList();
    }

    emit(PassengerLoaded(
      buses: filtered,
      recommendations: repository.recommendations,
      searchQuery: query,
      seatsOnlyFilter: state.seatsOnlyFilter,
      selectedBus: state.selectedBus,
    ));
  }

  void toggleSeatsOnlyFilter(bool seatsOnly) {
    List<BusModel> filtered = repository.searchBuses(state.searchQuery);
    if (seatsOnly) {
      filtered = filtered.where((b) => b.hasAvailableSeats).toList();
    }

    emit(PassengerLoaded(
      buses: filtered,
      recommendations: repository.recommendations,
      searchQuery: state.searchQuery,
      seatsOnlyFilter: seatsOnly,
      selectedBus: state.selectedBus,
    ));
  }

  void selectBusForTracking(String busId) {
    final bus = repository.getBusById(busId);
    emit(PassengerLoaded(
      buses: state.buses,
      recommendations: state.recommendations,
      searchQuery: state.searchQuery,
      seatsOnlyFilter: state.seatsOnlyFilter,
      selectedBus: bus,
    ));
  }
}

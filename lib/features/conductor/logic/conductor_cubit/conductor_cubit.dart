import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/ticket_repository.dart';
import '../../data/models/bus_shift_model.dart';
import 'conductor_state.dart';

class ConductorCubit extends Cubit<ConductorState> {
  final TicketRepository repository;

  ConductorCubit({required this.repository})
      : super(ConductorInitial(
          shift: repository.activeShift,
          tickets: repository.tickets,
          isOnline: repository.isOnline,
        ));

  void loadConductorData() {
    emit(ConductorLoaded(
      shift: repository.activeShift,
      tickets: repository.tickets,
      isOnline: repository.isOnline,
    ));
  }

  void toggleOnlineMode(bool online) {
    repository.setOnlineStatus(online);
    emit(ConductorLoaded(
      shift: repository.activeShift,
      tickets: repository.tickets,
      isOnline: repository.isOnline,
      message: online ? 'Cloud Sync Online' : 'Switched to Offline Mode',
    ));
  }

  void issueTicket({
    required String originStop,
    required String destinationStop,
    required String passengerType,
    required String paymentMethod,
    required int passengerCount,
    required double fareAmount,
  }) async {
    emit(ConductorLoading(
      shift: repository.activeShift,
      tickets: repository.tickets,
      isOnline: repository.isOnline,
    ));

    try {
      final ticket = await repository.issueTicket(
        originStop: originStop,
        destinationStop: destinationStop,
        passengerType: passengerType,
        paymentMethod: paymentMethod,
        passengerCount: passengerCount,
        fareAmount: fareAmount,
      );

      emit(TicketIssuedSuccess(
        shift: repository.activeShift,
        tickets: repository.tickets,
        isOnline: repository.isOnline,
        issuedTicket: ticket,
      ));
    } catch (e) {
      emit(ConductorError(
        shift: repository.activeShift,
        tickets: repository.tickets,
        isOnline: repository.isOnline,
        errorMessage: 'Failed to issue ticket: $e',
      ));
    }
  }

  void incrementPassengerCount(int count) {
    repository.incrementPassengerCount(count);
    emit(ConductorLoaded(
      shift: repository.activeShift,
      tickets: repository.tickets,
      isOnline: repository.isOnline,
      message: 'Added $count passenger(s)',
    ));
  }

  void alightPassengers(int count) {
    repository.alightPassengers(count);
    emit(ConductorLoaded(
      shift: repository.activeShift,
      tickets: repository.tickets,
      isOnline: repository.isOnline,
      message: 'Alighted $count passenger(s)',
    ));
  }

  void updateCurrentStop(int stopIndex) {
    repository.setCurrentStopIndex(stopIndex);
    emit(ConductorLoaded(
      shift: repository.activeShift,
      tickets: repository.tickets,
      isOnline: repository.isOnline,
      message: 'Current Stop Updated: ${repository.activeShift.currentStop}',
    ));
  }

  void syncPendingQueue() async {
    emit(ConductorLoading(
      shift: repository.activeShift,
      tickets: repository.tickets,
      isOnline: repository.isOnline,
    ));

    final syncedCount = await repository.syncPendingQueue();

    emit(OfflineSyncSuccess(
      shift: repository.activeShift,
      tickets: repository.tickets,
      isOnline: repository.isOnline,
      syncedCount: syncedCount,
      message: syncedCount > 0
          ? 'Successfully synced $syncedCount offline ticket(s)!'
          : 'All tickets are already up to date in cloud!',
    ));
  }

  void startNewShift(BusShiftModel newShift) {
    repository.startNewShift(newShift);
    emit(ConductorLoaded(
      shift: repository.activeShift,
      tickets: repository.tickets,
      isOnline: repository.isOnline,
      message: 'New Shift Started for ${newShift.routeNumber}',
    ));
  }

  void endShift() {
    repository.endShift();
    emit(ConductorLoaded(
      shift: repository.activeShift,
      tickets: repository.tickets,
      isOnline: repository.isOnline,
      message: 'Shift ended. Summary generated.',
    ));
  }
}

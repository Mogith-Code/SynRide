import '../../data/models/bus_shift_model.dart';
import '../../data/models/ticket_model.dart';

abstract class ConductorState {
  final BusShiftModel shift;
  final List<TicketModel> tickets;
  final bool isOnline;
  final String? message;

  const ConductorState({
    required this.shift,
    required this.tickets,
    required this.isOnline,
    this.message,
  });
}

class ConductorInitial extends ConductorState {
  ConductorInitial({
    required super.shift,
    required super.tickets,
    required super.isOnline,
  });
}

class ConductorLoading extends ConductorState {
  ConductorLoading({
    required super.shift,
    required super.tickets,
    required super.isOnline,
  });
}

class ConductorLoaded extends ConductorState {
  ConductorLoaded({
    required super.shift,
    required super.tickets,
    required super.isOnline,
    super.message,
  });
}

class TicketIssuedSuccess extends ConductorState {
  final TicketModel issuedTicket;

  TicketIssuedSuccess({
    required super.shift,
    required super.tickets,
    required super.isOnline,
    required this.issuedTicket,
    super.message = 'Ticket issued successfully!',
  });
}

class OfflineSyncSuccess extends ConductorState {
  final int syncedCount;

  OfflineSyncSuccess({
    required super.shift,
    required super.tickets,
    required super.isOnline,
    required this.syncedCount,
    required String message,
  }) : super(message: message);
}

class ConductorError extends ConductorState {
  final String errorMessage;

  ConductorError({
    required super.shift,
    required super.tickets,
    required super.isOnline,
    required this.errorMessage,
  }) : super(message: errorMessage);
}

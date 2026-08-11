import 'dart:async';
import '../models/ticket_model.dart';
import '../models/bus_shift_model.dart';

class TicketRepository {
  // Initial Mock Active Shift
  BusShiftModel _activeShift = BusShiftModel(
    shiftId: 'SHIFT-2026-0807',
    busId: 'BUS-101',
    routeNumber: 'Route 138',
    routeName: 'Pettah - Maharagama Express',
    conductorId: 'COND-042',
    conductorName: 'Renujaan R',
    totalCapacity: 54,
    currentOccupancy: 18,
    currentStopIndex: 0,
    stops: [
      'Pettah Fort',
      'Torenton Square',
      'Borella Junction',
      'Nawala Junction',
      'Nugegoda Town',
      'Delkanda Junction',
      'Maharagama Depot',
    ],
    startTime: DateTime.now().subtract(const Duration(hours: 2)),
    isActive: true,
    totalRevenue: 2850.00,
    totalTicketsIssued: 14,
  );

  final List<TicketModel> _tickets = [];
  bool _isOnline = true;

  TicketRepository() {
    _populateInitialTickets();
  }

  void _populateInitialTickets() {
    final now = DateTime.now();
    _tickets.addAll([
      TicketModel(
        ticketId: 'TCK-9901',
        ticketNumber: 'SR-138-9901',
        busId: 'BUS-101',
        routeNumber: 'Route 138',
        conductorId: 'COND-042',
        originStop: 'Pettah Fort',
        destinationStop: 'Nugegoda Town',
        passengerType: 'Adult',
        paymentMethod: 'SyncPass QR',
        fareAmount: 180.00,
        passengerCount: 1,
        issuedAt: now.subtract(const Duration(minutes: 42)),
        isSynced: true,
      ),
      TicketModel(
        ticketId: 'TCK-9902',
        ticketNumber: 'SR-138-9902',
        busId: 'BUS-101',
        routeNumber: 'Route 138',
        conductorId: 'COND-042',
        originStop: 'Pettah Fort',
        destinationStop: 'Maharagama Depot',
        passengerType: 'Adult',
        paymentMethod: 'Cash',
        fareAmount: 500.00,
        passengerCount: 2,
        issuedAt: now.subtract(const Duration(minutes: 30)),
        isSynced: true,
      ),
      TicketModel(
        ticketId: 'TCK-9903',
        ticketNumber: 'SR-138-9903',
        busId: 'BUS-101',
        routeNumber: 'Route 138',
        conductorId: 'COND-042',
        originStop: 'Borella Junction',
        destinationStop: 'Delkanda Junction',
        passengerType: 'Student',
        paymentMethod: 'Cash',
        fareAmount: 120.00,
        passengerCount: 1,
        issuedAt: now.subtract(const Duration(minutes: 15)),
        isSynced: false,
      ),
    ]);
  }

  // Getters
  BusShiftModel get activeShift => _activeShift;
  List<TicketModel> get tickets => List.unmodifiable(_tickets);
  bool get isOnline => _isOnline;

  List<TicketModel> get pendingTickets =>
      _tickets.where((t) => !t.isSynced).toList();

  // Network Status Toggle
  void setOnlineStatus(bool online) {
    _isOnline = online;
  }

  // Calculate dynamic fare based on stop distance and category
  double calculateFare({
    required String origin,
    required String destination,
    required String passengerType,
    required int passengerCount,
  }) {
    int originIdx = _activeShift.stops.indexOf(origin);
    int destIdx = _activeShift.stops.indexOf(destination);

    if (originIdx == -1) originIdx = 0;
    if (destIdx == -1) destIdx = _activeShift.stops.length - 1;

    int stopDistance = (destIdx - originIdx).abs();
    if (stopDistance == 0) stopDistance = 1;

    double baseRate = 80.00;
    double perStopRate = 45.00;
    double totalBaseFare = baseRate + (stopDistance * perStopRate);

    // Apply concession discounts
    double multiplier = 1.0;
    if (passengerType == 'Child' || passengerType == 'Student') {
      multiplier = 0.5;
    } else if (passengerType == 'Senior') {
      multiplier = 0.75;
    }

    return (totalBaseFare * multiplier * passengerCount);
  }

  // Issue Ticket Transaction
  Future<TicketModel> issueTicket({
    required String originStop,
    required String destinationStop,
    required String passengerType,
    required String paymentMethod,
    required int passengerCount,
    required double fareAmount,
  }) async {
    final ticketId = 'TCK-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    final ticketNumber = 'SR-138-${1000 + _tickets.length + 1}';

    final ticket = TicketModel(
      ticketId: ticketId,
      ticketNumber: ticketNumber,
      busId: _activeShift.busId,
      routeNumber: _activeShift.routeNumber,
      conductorId: _activeShift.conductorId,
      originStop: originStop,
      destinationStop: destinationStop,
      passengerType: passengerType,
      paymentMethod: paymentMethod,
      fareAmount: fareAmount,
      passengerCount: passengerCount,
      issuedAt: DateTime.now(),
      isSynced: _isOnline,
    );

    _tickets.insert(0, ticket);

    // Update active shift stats
    int newOccupancy = (_activeShift.currentOccupancy + passengerCount)
        .clamp(0, _activeShift.totalCapacity + 20);

    _activeShift = _activeShift.copyWith(
      currentOccupancy: newOccupancy,
      totalTicketsIssued: _activeShift.totalTicketsIssued + passengerCount,
      totalRevenue: _activeShift.totalRevenue + fareAmount,
    );

    return ticket;
  }

  // Increment Occupancy Quick Action
  void incrementPassengerCount(int count) {
    int newCount = (_activeShift.currentOccupancy + count)
        .clamp(0, _activeShift.totalCapacity + 20);
    _activeShift = _activeShift.copyWith(currentOccupancy: newCount);
  }

  // Alight Passenger Quick Action
  void alightPassengers(int count) {
    int newCount = (_activeShift.currentOccupancy - count).clamp(0, 999);
    _activeShift = _activeShift.copyWith(currentOccupancy: newCount);
  }

  // Change current stop index
  void setCurrentStopIndex(int index) {
    if (index >= 0 && index < _activeShift.stops.length) {
      _activeShift = _activeShift.copyWith(currentStopIndex: index);
    }
  }

  // Sync Pending Offline Tickets
  Future<int> syncPendingQueue() async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate net latency
    int syncedCount = 0;

    for (int i = 0; i < _tickets.length; i++) {
      if (!_tickets[i].isSynced) {
        _tickets[i] = _tickets[i].copyWith(isSynced: true);
        syncedCount++;
      }
    }
    return syncedCount;
  }

  // Update active shift details
  void startNewShift(BusShiftModel newShift) {
    _activeShift = newShift;
    _tickets.clear();
  }

  void endShift() {
    _activeShift = _activeShift.copyWith(isActive: false);
  }
}

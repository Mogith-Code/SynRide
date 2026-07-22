class TicketModel {
  final String ticketId;
  final String busId;
  final String originStop;
  final String destinationStop;
  final double fareAmount;
  final int passengerCount;
  final DateTime issuedAt;
  final bool isSynced;

  TicketModel({
    required this.ticketId,
    required this.busId,
    required this.originStop,
    required this.destinationStop,
    required this.fareAmount,
    required this.passengerCount,
    required this.issuedAt,
    this.isSynced = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'busId': busId,
      'originStop': originStop,
      'destinationStop': destinationStop,
      'fareAmount': fareAmount,
      'passengerCount': passengerCount,
      'issuedAt': issuedAt.toIso8601String(),
      'isSynced': isSynced,
    };
  }
}

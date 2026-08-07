class TicketModel {
  final String ticketId;
  final String ticketNumber;
  final String busId;
  final String routeNumber;
  final String conductorId;
  final String originStop;
  final String destinationStop;
  final String passengerType;
  final String paymentMethod;
  final double fareAmount;
  final int passengerCount;
  final DateTime issuedAt;
  final bool isSynced;

  TicketModel({
    required this.ticketId,
    required this.ticketNumber,
    required this.busId,
    required this.routeNumber,
    required this.conductorId,
    required this.originStop,
    required this.destinationStop,
    this.passengerType = 'Adult',
    this.paymentMethod = 'Cash',
    required this.fareAmount,
    required this.passengerCount,
    required this.issuedAt,
    this.isSynced = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'ticketNumber': ticketNumber,
      'busId': busId,
      'routeNumber': routeNumber,
      'conductorId': conductorId,
      'originStop': originStop,
      'destinationStop': destinationStop,
      'passengerType': passengerType,
      'paymentMethod': paymentMethod,
      'fareAmount': fareAmount,
      'passengerCount': passengerCount,
      'issuedAt': issuedAt.toIso8601String(),
      'isSynced': isSynced,
    };
  }

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      ticketId: json['ticketId'] ?? '',
      ticketNumber: json['ticketNumber'] ?? '',
      busId: json['busId'] ?? '',
      routeNumber: json['routeNumber'] ?? '',
      conductorId: json['conductorId'] ?? '',
      originStop: json['originStop'] ?? '',
      destinationStop: json['destinationStop'] ?? '',
      passengerType: json['passengerType'] ?? 'Adult',
      paymentMethod: json['paymentMethod'] ?? 'Cash',
      fareAmount: (json['fareAmount'] as num?)?.toDouble() ?? 0.0,
      passengerCount: json['passengerCount'] ?? 1,
      issuedAt: json['issuedAt'] != null 
          ? DateTime.parse(json['issuedAt']) 
          : DateTime.now(),
      isSynced: json['isSynced'] ?? false,
    );
  }

  TicketModel copyWith({
    String? ticketId,
    String? ticketNumber,
    String? busId,
    String? routeNumber,
    String? conductorId,
    String? originStop,
    String? destinationStop,
    String? passengerType,
    String? paymentMethod,
    double? fareAmount,
    int? passengerCount,
    DateTime? issuedAt,
    bool? isSynced,
  }) {
    return TicketModel(
      ticketId: ticketId ?? this.ticketId,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      busId: busId ?? this.busId,
      routeNumber: routeNumber ?? this.routeNumber,
      conductorId: conductorId ?? this.conductorId,
      originStop: originStop ?? this.originStop,
      destinationStop: destinationStop ?? this.destinationStop,
      passengerType: passengerType ?? this.passengerType,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      fareAmount: fareAmount ?? this.fareAmount,
      passengerCount: passengerCount ?? this.passengerCount,
      issuedAt: issuedAt ?? this.issuedAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}

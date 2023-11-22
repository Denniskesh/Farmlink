class Booking {
  final String userId;
  final String equipmentId;
  final String package;
  final String pickUp;
  final String dropOff;
  final String landSize;
  final String totalAmount;
  final String equipmentType;
  final String duration;
  final String rate;

  Booking({
    required this.userId,
    required this.equipmentId,
    required this.duration,
    required this.package,
    required this.pickUp,
    required this.dropOff,
    required this.landSize,
    required this.totalAmount,
    required this.equipmentType,
    required this.rate,
  });
}

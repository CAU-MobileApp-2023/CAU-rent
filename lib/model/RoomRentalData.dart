class RoomRentalData {
  String? renter;
  int? classroom;
  String? startDate;
  String? endDate;

  RoomRentalData(this.renter, this.classroom, this.startDate, this.endDate);

  Map<String, dynamic> toJson() => {
    'renter': renter,
    'classroom': classroom,
    'start_date': startDate,
    'end_date': endDate
  };
}
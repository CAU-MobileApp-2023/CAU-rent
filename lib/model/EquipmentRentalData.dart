class EquipmentRentalData {
  String? renter;
  int? device;
  String? startDate;
  String? endDate;

  EquipmentRentalData(this.renter, this.device, this.startDate, this.endDate);

  Map<String, dynamic> toJson() => {
    'renter': renter,
    'device': device,
    'start_date': startDate,
    'end_date': endDate
  };
}
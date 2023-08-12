import 'package:booking_calendar/booking_calendar.dart';

class BookingServiceWrapper {
  BookingService _bookingService;

  String? description;

  BookingServiceWrapper({
    String? userId,
    String? userName,
    String? userEmail,
    String? userPhoneNumber,
    DateTime? bookingStart,
    DateTime? bookingEnd,
    String? serviceId,
    String? serviceName,
    int? serviceDuration,
    int? servicePrice,
    this.description,
  }) : _bookingService = BookingService(
          userId: userId,
          userName: userName,
          userEmail: userEmail,
          userPhoneNumber: userPhoneNumber,
          bookingStart:
              bookingStart ?? DateTime.now(), // Default to now if null
          bookingEnd: bookingEnd ??
              DateTime.now()
                  .add(Duration(hours: 1)), // Default to one hour from now
          serviceId: serviceId,
          serviceName:
              serviceName ?? 'Unknown Service', // Default to 'Unknown Service'
          serviceDuration: serviceDuration ?? 15,
          servicePrice: servicePrice,
        );

  BookingServiceWrapper.fromJson(Map<String, dynamic> json)
      : description = json['description'] as String?,
        _bookingService = BookingService.fromJson(json);

  Map<String, dynamic> toJson() {
    final originalJson = _bookingService.toJson();
    originalJson['description'] = description;
    return originalJson;
  }

  String? get userId => _bookingService.userId;
  String? get userName => _bookingService.userName;
  String? get userEmail => _bookingService.userEmail;
  String? get userPhoneNumber => _bookingService.userPhoneNumber;
  DateTime get bookingStart => _bookingService.bookingStart;
  DateTime get bookingEnd => _bookingService.bookingEnd;
  String? get serviceId => _bookingService.serviceId;
  String get serviceName => _bookingService.serviceName;
  int get serviceDuration => _bookingService.serviceDuration;
  int? get servicePrice => _bookingService.servicePrice;

  // Setters
  set userId(String? id) {
    _updateBookingService(userId: id);
  }

  set userName(String? name) {
    _updateBookingService(userName: name);
  }

  set userEmail(String? email) {
    _updateBookingService(userEmail: email);
  }

  set userPhoneNumber(String? phoneNumber) {
    _updateBookingService(userPhoneNumber: phoneNumber);
  }

  set bookingStart(DateTime start) {
    _updateBookingService(bookingStart: start);
  }

  set bookingEnd(DateTime end) {
    _updateBookingService(bookingEnd: end);
  }

  set serviceId(String? id) {
    _updateBookingService(serviceId: id);
  }

  set serviceName(String name) {
    _updateBookingService(serviceName: name);
  }

  set serviceDuration(int duration) {
    _updateBookingService(serviceDuration: duration);
  }

  set servicePrice(int? price) {
    _updateBookingService(servicePrice: price);
  }

  void _updateBookingService({
    String? userId,
    String? userName,
    String? userEmail,
    String? userPhoneNumber,
    DateTime? bookingStart,
    DateTime? bookingEnd,
    String? serviceId,
    String? serviceName,
    int? serviceDuration,
    int? servicePrice,
  }) {
    _bookingService = BookingService(
      userId: userId ?? _bookingService.userId,
      userName: userName ?? _bookingService.userName,
      userEmail: userEmail ?? _bookingService.userEmail,
      userPhoneNumber: userPhoneNumber ?? _bookingService.userPhoneNumber,
      bookingStart: bookingStart ?? _bookingService.bookingStart,
      bookingEnd: bookingEnd ?? _bookingService.bookingEnd,
      serviceId: serviceId ?? _bookingService.serviceId,
      serviceName: serviceName ?? _bookingService.serviceName,
      serviceDuration: serviceDuration ?? _bookingService.serviceDuration,
      servicePrice: servicePrice ?? _bookingService.servicePrice,
    );
  }

  BookingServiceWrapper.fromBookingService(BookingService bookingService)
      : _bookingService = bookingService;

  BookingService get internalBookingService => _bookingService;
}

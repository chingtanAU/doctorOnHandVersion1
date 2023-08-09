import 'package:booking_calendar/booking_calendar.dart';
import 'package:doctorppp/entity/DoctorProfile.dart';
import 'package:doctorppp/entity/userProfile.dart';
import 'package:doctorppp/globals.dart';
import 'package:get/get.dart';
import '../persistance/userCrud.dart' as userCrud;

class PatientMeetingsController extends GetxController {
  final Rx<List<BookingService>> allPatientMeetings =
      Rx<List<BookingService>>(List.empty(growable: true));
  final Rx<DoctorProfile> earliestdoctor =
      Rx<DoctorProfile>(DoctorProfile.empty());

  // Add a variable to store the earliest meeting
  final Rx<BookingService?> earliestMeeting = Rx<BookingService?>(null);

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchPatientMeetings(auth.currentUser!.uid);
    print("aaaaaaa ${allPatientMeetings.value.length}");
    // Compute the earliest meeting here
    earliestMeeting.value = getEaliestMeeting();
    if (earliestMeeting.value != null) {
      await getDoctorData(earliestMeeting.value!);
      print(earliestdoctor.value.fName);
    }
  }

  BookingService? getEaliestMeeting() {
    final meetings =
        getUpcomingMeetings(allPatientMeetings.value, DateTime.now());
    print(DateTime.now().toString());
    if (meetings.isEmpty) {
      return null;
    }
    return meetings.reduce((current, next) =>
        current.bookingStart.isBefore(next.bookingStart) ? current : next);
  }

  Future<DoctorProfile?> getDoctorData(BookingService meeting) async {
    await userCrud
        .fetchDoctorInfo(meeting.serviceId!)
        .then((value) => earliestdoctor.value = value!);
    print(earliestdoctor.value.fName);
    update();
  }

  List<BookingService> getUpcomingMeetings(
      List<BookingService> meetings, DateTime presentTime) {
    final l = meetings
        .where((meeting) => meeting.bookingStart.isAfter(presentTime))
        .toList();
    l.sort((a, b) => a.bookingStart.compareTo(b.bookingStart));
    return l;
  }

  List<BookingService> getPassedMeetings(
      List<BookingService> meetings, DateTime presentTime) {
    final l = meetings
        .where((meeting) => meeting.bookingStart.isBefore(presentTime))
        .toList();
    l.sort((a, b) => a.bookingStart.compareTo(b.bookingStart));
    print(l.length);
    return l;
  }

  // Future<List<BookingService>?> fetchPatientMeetings(String id) async {
  //   await userCrud
  //       .fetchUserMeetings(id)
  //       .then((value) => allPatientMeetings.value = value);
  //   update();
  // }
  void fetchPatientMeetings(String id) {
    userCrud.fetchUserMeetingsStream(id).listen((List<BookingService> data) {
      allPatientMeetings.value = data;
      // Update the earliest meeting whenever data changes
      earliestMeeting.value = getEaliestMeeting();
      if (earliestMeeting.value != null) {
        getDoctorData(earliestMeeting.value!);
      }
    });
  }
}

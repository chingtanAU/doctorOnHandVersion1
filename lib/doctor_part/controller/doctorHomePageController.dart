import 'package:booking_calendar/booking_calendar.dart';
import 'package:doctorppp/entity/userProfile.dart';
import 'package:doctorppp/globals.dart';
import 'package:get/get.dart';
import '../completedVisits/view.dart';
import '../persistance/meetingCrud.dart' as meetingCrud;
import '../../persistance/userCrud.dart' as userCrud;

class DoctorHomePageController extends GetxController {
  final Rx<List<BookingService>> allDoctrorMeetings =
      Rx<List<BookingService>>(List.empty(growable: true));

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchDoctorMeetings(auth.currentUser!.uid);
    print("aaaaaaa ${allDoctrorMeetings.value.length}");
    Get.put(CompletedVisitsController());
  }

  BookingService? getEaliestMeeting() {
    final meetings =
        getUpcomingMeetings(allDoctrorMeetings.value, DateTime.now());
    print(DateTime.now().toString());
    if (meetings.isEmpty) {
      return null;
    }
    print(meetings[0].bookingStart.toString());
    return meetings.reduce((current, next) =>
        current.bookingStart.isBefore(next.bookingStart) ? current : next);
  }

  Future<UserProfile?> getPatientData(BookingService meeting) async {
    UserProfile? u;
    await userCrud.fetchUserInfo(meeting.userId!).then((value) => u = value);
    print('mmmmmmmmmm ${u?.address}');
    return u;
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

  Future<List<BookingService>?> fetchDoctorMeetings(String id) async {
    await meetingCrud
        .fetchDoctorMeetings(id)
        .then((value) => allDoctrorMeetings.value = value);
  }
}

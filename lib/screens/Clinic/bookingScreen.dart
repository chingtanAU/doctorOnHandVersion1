import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorppp/globals.dart';
import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'booking_service_wrapper.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../persistance/userCrud.dart' as usercrud;
import '../../Controllers/clinicDetailsContoller.dart';
import '../../Controllers/patientMeetingsController.dart';
import '../../validatorsAuth/auth.dart';
import 'package:doctorppp/entity/DoctorProfile.dart';

class BookingCalendarDemoApp extends StatefulWidget {
  BookingCalendarDemoApp({super.key});

  final clinicdetailController = Get.find<ClinicDetailsContoller>();
  final authController = Get.find<AuthController>();

  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  final TextEditingController _descController = TextEditingController();
  CollectionReference meeting =
  FirebaseFirestore.instance.collection('Meetings');
  final now = DateTime.now();
  late BookingServiceWrapper consultation;
  String? role;
  String? fName;
  String? lName;
  String? address;
  String? phone;
  String? picture;
  String? specialty;

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
    DoctorProfile? doctor = Get.arguments as DoctorProfile?;
    if (doctor != null) {
      role = doctor.role;
      fName = doctor.fName;
      lName = doctor.lName;
      address = doctor.address;
      phone = doctor.phone;
      picture = doctor.picture;
      specialty = doctor.speciality;

      setState(() {});
    }
    consultation = BookingServiceWrapper(
        serviceName: 'Consultation',
        serviceDuration: 15,
        bookingEnd: DateTime(now.year, now.month, now.day, 16, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 8, 0));
  }

  CollectionReference<BookingService> getBookingStream(
      {required String doctorId}) {
    return meeting
        .doc(doctorId)
        .collection('DoctorMeetings')
        .withConverter<BookingService>(
      fromFirestore: (snapshots, _) =>
          BookingService.fromJson(snapshots.data()!),
      toFirestore: (snapshots, _) => snapshots.toJson(),
    );
  }

  Stream<dynamic>? getBookingStreamFirebase(
      {required DateTime end, required DateTime start}) {
    final doctorData = widget.clinicdetailController.doctorData.value;
    if (doctorData == null || doctorData.id == null) {
      print("Doctor data or ID is null");
      return Stream.value([]); // Return an empty stream instead of null
    }
    return getBookingStream(doctorId: doctorData.id!).snapshots();
  }

  List<DateTimeRange> convertStreamResultFirebase(
      {required dynamic streamResult}) {
    List<DateTimeRange> converted = [];
    for (var i = 0; i < streamResult.size; i++) {
      final item = streamResult.docs[i].data();
      converted.add(
          DateTimeRange(start: (item.bookingStart!), end: (item.bookingEnd!)));
    }
    return converted;
  }

  Future<bool> uploadBookingFirebase({required BookingService newBooking}) async {
    BookingServiceWrapper newBookingWrapper =
    BookingServiceWrapper.fromBookingService(newBooking);
    return await _displayTextInputDesc(context, newBookingWrapper);
  }


  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
  }

  String? codeDialog;
  String? valueDesc;

  Future<bool> _displayTextInputDesc(
      BuildContext context, BookingServiceWrapper newBooking) async {
    bool success = false;
    await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (context) {
        return AlertDialog(
          title: const Text('Describe your problem'),
          content: SingleChildScrollView(
            child: TextField(
              controller: _descController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Enter your problem description here',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () async {
                newBooking.description = _descController.text;
                newBooking.userId = auth.currentUser?.uid;
                newBooking.userName =
                "${widget.authController.userData.value.fName} ${widget.authController.userData.value.lName}";
                newBooking.userEmail =
                    widget.authController.userData.value.email;
                newBooking.userPhoneNumber =
                    widget.authController.userData.value.phone;

                final doctorData = widget.clinicdetailController.doctorData.value;
                if (doctorData != null) {
                  newBooking.serviceId = doctorData.id;
                  newBooking.serviceName =
                  "${doctorData.fName} ${doctorData.lName}";

                  var newBookingRef = meeting
                      .doc(doctorData.id)
                      .collection('DoctorMeetings')
                      .doc();

                  try {
                    await newBookingRef.set({
                      'docId': newBookingRef.id,
                      ...newBooking.toJson()
                    });
                    await usercrud.addmeetingUser(auth.currentUser!.uid,
                        newBookingRef.id, newBooking.toJson());

                    // Call fetchPatientMeetings without awaiting
                    Get.find<PatientMeetingsController>()
                        .fetchPatientMeetings(auth.currentUser!.uid);

                    print("Booking added successfully");
                    success = true;
                    Navigator.pop(context);
                  } catch (error) {
                    print("Failed to add booking: $error");
                    // You might want to show an error message to the user here
                  }
                } else {
                  print("Doctor data is null");
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
    return success;
  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Book Date and Time'),
          elevation: 9,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.1, 0.6],
                colors: [Colors.blue, Colors.teal],
              ),
            ),
          ),
        ),
        body: Obx(() {
          if (widget.clinicdetailController.doctorData.value == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: BookingCalendar(
                  bookingService: consultation.internalBookingService,
                  convertStreamResultToDateTimeRanges: convertStreamResultFirebase,
                  getBookingStream: getBookingStreamFirebase,
                  uploadBooking: uploadBookingFirebase,
                  pauseSlots: generatePauseSlots(),
                  pauseSlotText: 'LUNCH',
                  hideBreakTime: false,
                  loadingWidget: const Text('Fetching data...'),
                  //uploadingWidget: const CircularProgressIndicator(),
                  locale: 'en',
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  disabledDays: const [DateTime.thursday],
                  wholeDayIsBookedWidget:
                  const Text('Sorry, for this day everything is booked'),
              ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

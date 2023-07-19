

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorppp/globals.dart';
import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../persistance/userCrud.dart' as usercrud;
import '../../Controllers/clinicDetailsContoller.dart';
import '../../validatorsAuth/auth.dart';

class BookingCalendarDemoApp extends StatefulWidget {
   BookingCalendarDemoApp({Key? key}) : super(key: key);

  final clinicdetailController = Get.find<ClinicDetailsContoller>() ;
  final authController = Get.find<AuthController>();

  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {

  final TextEditingController _descController = TextEditingController();
  CollectionReference meeting = FirebaseFirestore.instance.collection('Meetings');
  final now = DateTime.now();
  late BookingService consultation;

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
    // DateTime.now().startOfDay
    // DateTime.now().endOfDay
    consultation = BookingService(
        serviceName: 'Consultation',
        serviceDuration: 15,
        bookingEnd: DateTime(now.year, now.month, now.day, 16, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 8, 0));
  }

  CollectionReference<BookingService> getBookingStream({required String doctorId}) {
    /*var d= meeting.doc('eFWgNp9ZQy2453tnKO9j').
    collection('DoctorMeetings').
    get().
    then((querySnapshot) {for (var docSnapshot in querySnapshot.docs) {
      print('${docSnapshot.id} => ${docSnapshot.data()}');
    }});
    */
    return meeting.doc(doctorId).collection('DoctorMeetings').withConverter<BookingService>(
      fromFirestore: (snapshots, _) => BookingService.fromJson(snapshots.data()!),
      toFirestore: (snapshots, _) => snapshots.toJson(),
    );}

  Stream<dynamic>? getBookingStreamFirebase(
      {required DateTime end, required DateTime start}) {
    //print(start);
    //print(end);
    return getBookingStream(doctorId:widget.clinicdetailController.doctorData.value.id!)
        .snapshots();
  }

  List<DateTimeRange> convertStreamResultFirebase(
      {required dynamic streamResult}) {
    List<DateTimeRange> converted = [] ;
    //print(streamResult.runtimeType);
    for (var i = 0; i < streamResult.size; i++) {
      final item = streamResult.docs[i].data();
      converted.add(DateTimeRange(start: (item.bookingStart!), end:(item.bookingEnd!) ));
    }
    print(converted);
    return converted;
  }

  Future<dynamic> uploadBookingFirebase({required BookingService newBooking,required BuildContext context}) async {
    await _displayTextInputDesc(context,newBooking);

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


  Future<void> _displayTextInputDesc(BuildContext context,BookingService newBooking) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('describe your problem'),
            content: TextField(
              controller :_descController ,

            ),
            actions: <Widget>[

              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('Submit'),
                onPressed: () async {
                  newBooking.description= _descController.text;
                  newBooking.userId= auth.currentUser?.uid;
                  newBooking.userName= "${widget.authController.userData.value.fName} ${widget.authController.userData.value.lName}";
                  newBooking.userEmail= widget.authController.userData.value.email;
                  newBooking.userPhoneNumber= widget.authController.userData.value.phone;
                  newBooking.serviceId=widget.clinicdetailController.doctorData.value.id;
                  newBooking.serviceName="${widget.clinicdetailController.doctorData.value.fName} ${widget.clinicdetailController.doctorData.value.lName}";
                  await meeting
                      .doc(widget.clinicdetailController.doctorData.value.id!)
                      .collection('DoctorMeetings')
                      .add(newBooking.toJson())
                      .then((value) async {
                        await usercrud.addmeetingUser(auth.currentUser!.uid, value.id,newBooking.toJson());
                        Navigator.pop(context);})
                      .catchError((error) => print("Failed to add booking: $error"));



                },


              ),
            ],
          );
        });
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
                    stops: [

                      0.1,
                      0.6,
                    ],
                    colors: [

                      Colors.blue,
                      Colors.teal,
                    ],
                  )
              ),
            ),

          ),
          body: Center(

            child: BookingCalendar(
              bookingService: consultation,
              convertStreamResultToDateTimeRanges: convertStreamResultFirebase,
              getBookingStream: getBookingStreamFirebase,
              uploadBooking: uploadBookingFirebase ,
              pauseSlots: generatePauseSlots(),
              pauseSlotText: 'LUNCH',
              hideBreakTime: false,
              loadingWidget: const Text('Fetching data...'),
              uploadingWidget: const CircularProgressIndicator(),
              locale:'eng',
              startingDayOfWeek: StartingDayOfWeek.monday,
              wholeDayIsBookedWidget:
              const Text('Sorry, for this day everything is booked'),
              //disabledDates: [DateTime(2023, 1, 20)],
              //disabledDays: [6, 7],
            ),
          ),
        ));
  }
}
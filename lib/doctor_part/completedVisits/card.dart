import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';



class VisitCard extends StatelessWidget {
  final BookingService visit;

  const VisitCard({Key? key, required this.visit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int filledFields = 0;

    if (visit.userName != null) {
      filledFields++;
    }
    filledFields++;
      filledFields++;
  
    Color cardColor;
    if (filledFields == 3) {
      cardColor = Colors.green;
    } else if (filledFields == 2 || filledFields == 1) {
      cardColor = Colors.yellow;
    } else {
      cardColor = Colors.red;
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Visit Details',
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: const Icon(
                Icons.person,
                color: Colors.black,
                size: 20,
              ),
              title: Text(
                visit.userName ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    visit.serviceName ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${visit.bookingStart.toString()} ',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
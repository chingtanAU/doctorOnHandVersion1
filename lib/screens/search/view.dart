import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Clinic/clinicdetails.dart';
import 'model.dart';
import 'logic.dart';


class ClinicSearchPage1 extends StatelessWidget {
  final ClinicSearchController controller = Get.put(ClinicSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clinic Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Obx(() {
                  return DropdownButton<int>(
                    value: controller.filterValue.value,
                    onChanged: (value) {
                      if (value != null) {
                        controller.filterValue.value = value;
                        controller.applyFilter();
                      }
                    },
                    items: [
                      DropdownMenuItem<int>(
                        value: 0,
                        child: Text('Number of Visits'),
                      ),
                      DropdownMenuItem<int>(
                        value: 1,
                        child: Text('Last Visit'),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: Obx(
                  () =>
                  ListView.builder(
                    itemCount: controller.filteredClinics.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Get.to(() =>
                                ClinicDetails(
                                    clinic: controller.filteredClinics[index]));
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      controller.filteredClinics[index]
                                          .imageUrl,
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 0, 0, 0),
                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        SizedBox(height: 16.0),
                                        Text(
                                          controller.filteredClinics[index]
                                              .name,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          'Visits: ${controller
                                              .filteredClinics[index].visits}',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          'Last Visit: ${controller
                                              .filteredClinics[index]
                                              .lastVisit}',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClinicDetailsPage extends StatelessWidget {
  final Clinic clinic;

  const ClinicDetailsPage({Key? key, required this.clinic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clinic Details'),
      ),
      body: Column(
        children: [
          Image.asset(clinic.imageUrl),
          SizedBox(height: 16.0),
          Text(
            clinic.name,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'Visits: ${clinic.visits}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Last Visit: ${clinic.lastVisit}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 16.0),
          Text(
            clinic.description,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

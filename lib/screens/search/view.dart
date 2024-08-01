import 'package:doctorppp/Controllers/clinicDetailsContoller.dart';
import 'package:doctorppp/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/clinicController.dart';
import '../Clinic/clinicdetails.dart';

class ClinicSearchPage1 extends StatelessWidget {
  final ClinicContoller clinicController;
  final ClinicDetailsContoller clinicdetailController;

  ClinicSearchPage1({super.key})
      : clinicController = Get.find<ClinicContoller>(),
        clinicdetailController = Get.put(ClinicDetailsContoller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Get.back(),
        ),
        [], // Empty list for actions
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      clinicController.searchText.value = value;
                      clinicController.search();
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Obx(() {
                  return DropdownButton<int>(
                    value: clinicController.filterValue.value,
                    onChanged: (value) {
                      if (value != null) {
                        clinicController.filterValue.value = value;
                        clinicController.applyFilter();
                      }
                    },
                    items: const [
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
                  () => ListView.builder(
                itemCount: clinicController.filteredClinics.length,
                itemBuilder: (context, index) {
                  final clinic = clinicController.filteredClinics[index];
                  return GestureDetector(
                    onTap: () {
                      clinicdetailController.setDoctordata(clinic.idClinic);
                      Get.to(() => ClinicDetails(clinic: clinic));
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                "assets/medical1.png",
                                height: 100,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    clinic.clinicName,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Visits: ${clinic.visitNumber}',
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'Last Visit: ${clinic.lastVisit}',
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

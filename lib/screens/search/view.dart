import 'package:doctorppp/Controllers/clinicDetailsContoller.dart';
import 'package:doctorppp/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/clinicController.dart';
import '../Clinic/clinicdetails.dart';
import 'model.dart';

class ClinicSearchPage1 extends StatelessWidget {
  final clinicController = Get.find<ClinicContoller>();
  final clinicdetailController = Get.put(ClinicDetailsContoller());

  List<Obx> actions4 = [];

  ClinicSearchPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          const IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: null,
          ),
          actions4),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    //controller: clinicController.searchController,
                    onChanged: (value) {
                      clinicController.searchText.value = value;
                      clinicController
                          .search(); // Trigger the search method when text changes
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
                  return GestureDetector(
                      onTap: () {
                        clinicdetailController.setDoctordata(
                            clinicController.filteredClinics[index].idClinic);
                        Get.to(() => ClinicDetails(
                            clinic: clinicController.filteredClinics[index]));
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    "assets/medical1.png",
                                    height: 150,
                                    width: 90,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 16.0),
                                    SizedBox(
                                      width: 260,
                                      child: Text(
                                        clinicController
                                            .filteredClinics[index].clinicName,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      'Visits: ${clinicController.filteredClinics[index].visitNumber}',
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      'Last Visit: ${clinicController.filteredClinics[index].lastVisit}',
                                      style: const TextStyle(fontSize: 16.0),
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
        title: const Text('Clinic Details'),
      ),
      body: Column(
        children: [
          Image.asset(clinic.imageUrl),
          const SizedBox(height: 16.0),
          Text(
            clinic.name,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Visits: ${clinic.visits}',
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Last Visit: ${clinic.lastVisit}',
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 16.0),
          Text(
            clinic.description,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

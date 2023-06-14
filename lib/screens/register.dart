import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../globals.dart' as globals;
import '../validatorsAuth/Validator.dart' as validator;

import '../validatorsAuth/auth.dart' as auth;

const List<String> list = <String>['Pa'
    'tient', 'Doctor', 'Administrator'];

const List<String> listSpeciality = <String>['Pa'
    'tient', 'Doctor', 'Administrator'];
const List<String> listClinic = <String>
['University of Alberta Hospital',
  'Oliver Village Clinic',
  'Misericordia Urgent Care Centre',
  'Queen Elizabeth II Hospital',
  'Meadows Medical Clinic',
];




class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);


  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {



  refresh() {

    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Stack(
                children: [
                  Positioned(
                    right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.15,
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Create\nAccount',
                        style: TextStyle(color: Colors.white, fontSize: 33),
                      ),
                    ),
                  ),
                  Container(

                    padding: EdgeInsets.only(
                        top: MediaQuery
                            .of(context)
                            .size
                            .height * 0.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          margin: EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                                DropdownButtonExample(notifyParent: refresh),


                              globals.roleKey.currentState?.value=='Doctor' ? DropdownButtonClinic():
                                  /////////////////////////////

                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                key: globals.fNameKey,
                                validator: (text)=> validator.nameValidator(text!) ,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "First Name",
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                key: globals.lNameKey,
                                validator: (text)=> validator.nameValidator(text!) ,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Last Name",
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 30,
                              ),

                              TextFormField(
                                onChanged: (text) {
                                 validator.FireError.setEmailUseError(false);
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                key: globals.emailKey,
                                validator: (email)=>validator.emailValidatro(email!),
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Email",

                                    hintStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),

                              SizedBox(
                                height: 30,
                              ),

                              TextFormField(
                                key: globals.addressKey,
                                validator:(address)=>validator.nameValidator(address!),
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Address",
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),

                              SizedBox(
                                height: 30,
                              ),

                              IntlPhoneField(
                               // keyField: globals.phoneKey,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    labelText: 'Phone Number',
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (phone) {

                                  print(phone.completeNumber);
                                },
                                onCountryChanged: (country) {
                                  print('Country changed to: ' + country.name);
                                },
                              ),

                           /*   TextFormField(
                                key:globals.phoneKey,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Phone",
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                style: TextStyle(color: Colors.black),
                              ),
*/
                              SizedBox(
                                height: 17,
                              ),

                              TextFormField(
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator:(pass)=>validator.passwordValidator(pass!),
                                key:globals.passKey,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),


                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (pass)=>pass==globals.passKey.currentState?.value ? null:'Password must be same as above' ,
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                key:globals.conPassKey,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 27,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xff4c505b),
                                    child: IconButton(
                                        color: Colors.black,
                                        onPressed: () {auth.onRegister(context);},
                                        icon: Icon(
                                          Icons.arrow_forward,
                                        )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, 'login');
                                    },
                                    child: Text(
                                      'Sign In',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.black,
                                          fontSize: 18),
                                    ),
                                    style: ButtonStyle(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ]
            ),

          ),
        )


    );
  }}

///////////////////////////////////////////////////////////////////////////////////////
class DropdownButtonExample extends StatefulWidget {

  final Function() notifyParent;

  const DropdownButtonExample({super.key,required this.notifyParent});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
    autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value)=>(value==null ? 'select an account type' : null ) ,
      hint: Text("Account Type",style: TextStyle(color: Colors.black)),
      key: globals.roleKey,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          hintStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )) ,
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        print(globals.roleKey.currentState?.value);
        setState(() {
          dropdownValue = value!;
          widget.notifyParent();
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,
          style:TextStyle(color: Colors.black) ,),
        );
      }).toList(),
    );
  }
}

/////////////////////////////////////////////////////////////////


class DropdownButtonClinic extends StatefulWidget {

  const DropdownButtonClinic({super.key});

  @override
  _DropdownButtonClinicState createState() => _DropdownButtonClinicState();
}

class _DropdownButtonClinicState extends State<DropdownButtonClinic> {
  String? dropdownValue ;

  @override
  Widget build(BuildContext context) {


    return  Column(

      children: [
        SizedBox(
          height: 40,
        ),
        DropdownButtonFormField<String>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value)=>(value==null ? 'clinic is required' : null ) ,
          hint: Text("Select your clinic",style: TextStyle(color: Colors.black)),
        key: globals.clinicsKey,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            hintStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )) ,
        isExpanded: true,
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        onChanged: (String? value) {
          print(globals.roleKey.currentState?.value);
          setState(() {
            dropdownValue = value!;
          });
        },
        items: listClinic.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
              style:TextStyle(color: Colors.black) ,),
          );
        }).toList(),
      ),SizedBox(
          height: 40,
        )],
    )
      ;
  }
}





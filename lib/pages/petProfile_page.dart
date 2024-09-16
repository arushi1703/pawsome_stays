import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pawsome_stays/widgets/custom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/backend_service.dart';
import '../widgets/custom_appbar.dart';

class PetprofilePage extends StatefulWidget {
  const PetprofilePage({super.key});

  @override
  State<PetprofilePage> createState() => _PetprofilePageState();
}

class _PetprofilePageState extends State<PetprofilePage> {

  Map<String, dynamic>? petDetails;
  final GetIt _getIt = GetIt.instance;
  late BackendService _backendService;

  @override
  void initState() {
    super.initState();
    _backendService = _getIt.get<BackendService>();
    _fetchAndStorePetDetails();
  }

  Future<void> _fetchAndStorePetDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ownerID = prefs.getString('ownerID');
    if (ownerID != null){
      String? petID = await _backendService.getPetIDByOwnerID(ownerID);
      if (petID != null){
        final details = await _backendService.getPetDetailsByID(petID);

        if (details != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('petDetails', jsonEncode(details));

          setState(() {
            petDetails = details; // Store the fetched details in state
          });
        }else { print ("Pet details are null");}
      }else { print ("PetID is null");}
    }else { print ("OwnerID null");}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'Pawsome Stays',),
      ),
      drawer: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: const CustomDrawer(),
      ),
      body: petDetails == null
          ? Center(child: CircularProgressIndicator())
          : _buildUI(),
    );
  }

  Widget _buildUI(){
    return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            /*decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/homebg.jpg"),
                fit: BoxFit.cover,
              ),
            ),*/
            child:Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  _petForm(),
                ]
              )
            )
          ),
        )
    );
  }

  Widget _petForm(){
    return Container(
      height: MediaQuery.sizeOf(context).height*0.60,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height*0.05,
      ),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(petDetails?['name'] ?? 'Unknown',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            _buildReadOnlyTextField('Age', petDetails?['age']?.toString() ?? ''),
            _buildReadOnlyTextField('Type', petDetails?['pettype'] ?? ''),
            _buildReadOnlyTextField('Gender', petDetails?['gender'] ?? ''),
            _buildReadOnlyTextField('Notes', petDetails?['notes'] ?? ''),
          ],
        )
      ),
    );
  }

  Widget _buildReadOnlyTextField(String label, String initialValue) {
    return TextFormField(
      initialValue: initialValue,
      //style: TextStyle(color: Colors.blueAccent),  // Set the text color to white
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black54),  // Set the label color to white
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),  // Border color when not focused
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),  // Border color when focused
        ),
      ),
      readOnly: true,
    );
  }
}

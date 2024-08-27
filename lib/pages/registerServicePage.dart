import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pawsome_stays/services/alert_service.dart';
import 'package:pawsome_stays/services/auth_service.dart';
import 'package:pawsome_stays/services/backend_service.dart';
import '../services/navigation_service.dart';
import '../widgets/custom_appbar.dart';
import 'package:pawsome_stays/widgets/custom_drawer.dart';
import 'package:http/http.dart' as http;

class RegisterServicePage extends StatefulWidget {
  const RegisterServicePage({super.key});

  @override
  State<RegisterServicePage> createState() => _RegisterServicePageState();
}

class _RegisterServicePageState extends State<RegisterServicePage> {

  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late NavigationService _navigationService;
  late AlertService _alertService;
  late BackendService _backendService;

  final List<String> services = ['Grooming', 'Pawdicure', 'De-Shedding', 'DailyWalks', 'Yoga', 'Swimming'];
  List<String> selectedServices = [];

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _alertService = _getIt.get<AlertService>();
    _backendService = _getIt.get<BackendService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'Pawsome Stays'),
      ),
      drawer: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomDrawer(),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            const Text("Choose Services:",
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue,
              ),
            ),
            Column(
              children: services.map((service){
                return CheckboxListTile(
                  title: Text(service),
                  value: selectedServices.contains(service),
                  onChanged:(bool? value){
                    setState((){
                      if (value == true) {
                        selectedServices.add(service);
                      } else {
                        selectedServices.remove(service);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            _registerServicesButton(),
          ]
        ),
      ),
    );
  }

  Widget _registerServicesButton(){
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: () async{
          String email = _authService.user!.email!;
          String? ownerID = await _backendService.getOwnerIDByEmail(email);

          if (ownerID != null){
            String? petID = await _backendService.getPetIDByOwnerID(ownerID);
            if (petID != null){
              var response = await _backendService.addServices(petID, selectedServices);
              print("Response Status: ${response.statusCode}");
              print("Response Body: ${response.body}");
              if (response.statusCode == 201){
                _navigationService.pushReplacementWithArguments("/home", ownerID);
                _alertService.showToast(text: "Services Registered!");
              }
              else{
                print('Failed to register services: ${response.body}');
                _alertService.showToast(text: "Failed to Register Services!");
              }
            }
            else{
              print('PetID not found while registering services');
            }
          }
          else{
            print('ownerID not found while registering services');
          }
        },
        child: const Text('Submit',
          style: TextStyle(
            fontSize: 15,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

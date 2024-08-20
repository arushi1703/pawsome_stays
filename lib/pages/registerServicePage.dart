import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pawsome_stays/services/alert_service.dart';
import '../services/navigation_service.dart';
import '../widgets/custom_appbar.dart';
import 'package:pawsome_stays/widgets/custom_drawer.dart';

class RegisterServicePage extends StatefulWidget {
  const RegisterServicePage({super.key});

  @override
  State<RegisterServicePage> createState() => _RegisterServicePageState();
}

class _RegisterServicePageState extends State<RegisterServicePage> {

  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  late AlertService _alertService;

  final List<String> services = ['Grooming', 'Pawdicure', 'De-Shedding', 'DailyWalks', 'Yoga', 'Swimming'];
  List<String> selectedServices = [];

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
    _alertService = _getIt.get<AlertService>();
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
            ElevatedButton(
                onPressed: (){
                  print(selectedServices);
                  _navigationService.pushNamed("/home");
                  _alertService.showToast(text: "Services Registered!");
                },
                child: const Text('Submit',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                  ),
                ),
            ),
          ]
        ),
      ),
    );
  }
}

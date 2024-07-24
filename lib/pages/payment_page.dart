import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pawsome_stays/services/alert_service.dart';
import 'package:pawsome_stays/services/navigation_service.dart';
import 'package:pawsome_stays/widgets/custom_appbar.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  final GetIt _getIt = GetIt.instance;
  late AlertService _alertService;
  late NavigationService _navigationService;

  @override
  void initState() {
    super.initState();
    _alertService= _getIt.get<AlertService>();
    _navigationService= _getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                _navigationService.pushReplacementNamed("/home");
                _alertService.showToast(text: "Payment successful");
                await Future.delayed(Duration(seconds: 2));
                _alertService.showToast(text: "Booking made");
              },
              child: Text("Pay"),
          )
        ],
      ),
    );
  }
}

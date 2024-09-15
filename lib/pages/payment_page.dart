import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pawsome_stays/services/alert_service.dart';
import 'package:pawsome_stays/services/navigation_service.dart';
import 'package:pawsome_stays/widgets/custom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentPage extends StatefulWidget {
  final Map<String, dynamic> arguments;

  const PaymentPage({super.key, required this.arguments});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  final GetIt _getIt = GetIt.instance;
  late AlertService _alertService;
  late NavigationService _navigationService;

  late String bedType;
  late DateTime check_in;
  late DateTime check_out;
  late int totalDays, totalBill;
  int bedCost = 5000, totalStayCost= 6000;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _alertService= _getIt.get<AlertService>();
    _navigationService= _getIt.get<NavigationService>();
    _loadBookingDetails();
  }

  Future<void> _loadBookingDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the stored booking details
    String? bookingDetailsJson = prefs.getString('bookingDetails');

    if (bookingDetailsJson != null) {
      Map<String, dynamic> bookingDetails = jsonDecode(bookingDetailsJson);

      setState(() {
        bedType = bookingDetails['bedType'];
        check_in = DateTime.parse(bookingDetails['check_in']);
        check_out = DateTime.parse(bookingDetails['check_out']);
        totalDays = bookingDetails['totalDays'];
        totalBill = bedCost + (totalDays*totalStayCost);
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'Make Payment'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator while data is being loaded
          : Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 20.0,
        ),
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
            const Text(
              'Payment Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            Text('Bed Type: $bedType', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Check-in Date: ${check_in.year}/${check_in.month}/${check_in.day}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Check-out Date: ${check_out.year}/${check_out.month}/${check_out.day}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Total Days: $totalDays', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            Text('Bed Cost: ₹$bedCost', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Stay Cost (₹6000/day): ₹${totalStayCost * totalDays}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            Text('Total Amount: ₹$totalBill',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? ownerID = prefs.getString('ownerID');
                if (ownerID != null) {
                  _navigationService.pushReplacementWithArguments("/home", ownerID);
                  _alertService.showToast(text: "Payment successful");
                  await Future.delayed(const Duration(seconds: 2));
                  _alertService.showToast(text: "Booking made\nWait for confirmation");
                }
              },
              child: const Text("Pay", style: TextStyle(fontSize: 18)),
            ),
                    ],
                  ),
          ),
    );
  }
}
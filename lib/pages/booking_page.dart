import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pawsome_stays/services/backend_service.dart';
import 'package:pawsome_stays/widgets/custom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../services/navigation_service.dart';
import '../widgets/custom_appbar.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {

  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  late BackendService _backendService;

  String bedType='Basic';
  var bedtypes= ['Basic', 'Bolster', 'Orthopedic', 'Heated'];
  bool isLoading = false;
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2024,9,25),
    end: DateTime(2024,9,30),
  );

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
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
            _headerText(),
            SizedBox(height: 30),
            _showPicker(),
            SizedBox(height: 30),
            _showCalendar(),
            SizedBox(height: 30),
            _chooseBed(),
            SizedBox(height: 30),
            _makePaymentButton(),
          ],
        ),
      ),
    );
  }

  Widget _chooseBed(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Choose bed : ',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(width: 30,),
          DropdownButton(
              value: bedType,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: bedtypes.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? value){
                setState(() {
                  bedType=value!;
                });
              }
          ),
        ],
      ),
        GestureDetector(
          onTap:(){
            _navigationService.pushNamed("/beds");
          },
          child: const Text(
            "View bed types",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
    ]
    );
  }

  Widget _headerText(){
    return Container(
      alignment: Alignment.topLeft,
      child: const Text("BOOKING",
        style: TextStyle(
          fontSize: 22,
          color: Colors.blue,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _showCalendar(){
    return TableCalendar(
      firstDay: DateTime(2024, 1, 1),
      lastDay: DateTime(2024, 12, 31),
      focusedDay: dateRange.start,
      //function that determines which days should be highlighted as selected.
      selectedDayPredicate: (day) {
        return isSameDay(day, dateRange.start) || isSameDay(day, dateRange.end);
      },
      rangeStartDay: dateRange.start,
      rangeEndDay: dateRange.end,
      calendarFormat: CalendarFormat.month,
      rangeSelectionMode: RangeSelectionMode.toggledOff,
    );
  }

  Widget _showPicker(){
    final start = dateRange.start;
    final end = dateRange.end;
    final difference = dateRange.duration;

    return Container(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          const Text("Please select the checkin and checkout dates :",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children : [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:WidgetStateProperty.all<Color>(Colors.blue),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text("${start.year}/${start.month}/${start.day}"),
                  onPressed: pickDateRange,
                )
              ),
              SizedBox(width:10),
              Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:WidgetStateProperty.all<Color>(Colors.blue),
                      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text("${end.year}/${end.month}/${end.day}"),
                    onPressed: pickDateRange,
                  )
              )
            ],
          ),
          SizedBox(height:30),
          Text("Total days: ${difference.inDays}",
            style:TextStyle(
              fontSize: 15,
            )
          ),
        ],
      )
    );
  }

  Future pickDateRange() async{
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2024,1,1),
      lastDate: DateTime(2024,12,31),
    );

    if (newDateRange == null) return;

    else{
      setState(() {
        dateRange = newDateRange;
      });
    }
  }

  Widget _makePaymentButton(){
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
          onPressed: isLoading
              ? null // Disable button when loading
              : () async {
            setState(() {
              isLoading = true;  // Start loading
            });

            // Retrieve ownerID from SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? ownerID = prefs.getString('ownerID');

            if (ownerID != null) {
              // Fetch petID asynchronously
              String? petID = await _backendService.getPetIDByOwnerID(ownerID);

              if (petID != null) {
                // Call the addBooking function with all necessary details
                final response = await _backendService.addBooking(
                  ownerID: ownerID,
                  petID: petID,
                  bedType: bedType,
                  checkIn: dateRange.start,
                  checkOut: dateRange.end,
                );
                if (response.statusCode == 201) {
                  final totalDays = dateRange.duration.inDays;
                  Map<String, dynamic> bookingDetails = {
                    'bedType': bedType,
                    'check_in': dateRange.start.toIso8601String(),
                    'check_out': dateRange.end.toIso8601String(),
                    'totalDays': totalDays,
                  };
                  // Convert the map to a JSON string
                  String bookingDetailsJson = jsonEncode(bookingDetails);
                  print(bookingDetailsJson);
                  // Store the JSON string in SharedPreferences
                  await prefs.setString('bookingDetails', bookingDetailsJson);
                  _navigationService.pushReplacementNamed("/payment");
                } else {
                  print('Failed to add booking: ${response.body}');
                }
              } else {
                print('Error fetching petID');
              }
            } else {
              print('Error: ownerID not found in SharedPreferences');
            }
            setState(() {
              isLoading = false;  // Stop loading after the process completes
            });
          },
          child: isLoading
              ? CircularProgressIndicator(  // Show loading indicator
            color: Colors.white,
          )
              : const Text(
            "Make Payment",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        )
      ),
    );
  }
}


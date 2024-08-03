import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pawsome_stays/widgets/custom_drawer.dart';
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

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2024,9,25),
    end: DateTime(2024,9,30),
  );

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
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
    return SafeArea(
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
            _makePaymentButton(),
          ],
        ),
      ),
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
          onPressed: (){
            _navigationService.pushReplacementNamed("/payment");
          },
          child: const Text(
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


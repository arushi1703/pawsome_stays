import 'package:flutter/material.dart';
import 'package:pawsome_stays/widgets/custom_drawer.dart';

import '../widgets/custom_appbar.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2024,9,25),
    end: DateTime(2024,9,30),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            _showPicker(),
          ],
        ),
      ),
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
          const Text("Date Range:"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children : [
              Expanded(
                child: ElevatedButton(
                  child: Text("${start.year}/${start.month}/${start.day}"),
                  onPressed: pickDateRange,
                )
              ),
              SizedBox(width:10),
              Expanded(
                  child: ElevatedButton(
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
}

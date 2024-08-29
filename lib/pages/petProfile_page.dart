import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawsome_stays/widgets/custom_drawer.dart';
import '../widgets/custom_appbar.dart';

class PetprofilePage extends StatefulWidget {
  const PetprofilePage({super.key});

  @override
  State<PetprofilePage> createState() => _PetprofilePageState();
}

class _PetprofilePageState extends State<PetprofilePage> {
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
      body: _buildUI(),
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
                  //_petForm(),
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
            const Text('Fluffy',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            _buildReadOnlyTextField('Age', '3 yrs'),
            _buildReadOnlyTextField('Type', 'Dog'),
            _buildReadOnlyTextField('Gender', 'Female'),
            _buildReadOnlyTextField('Notes', 'Loves to play fetch'),
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

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pawsome_stays/services/alert_service.dart';
import 'package:pawsome_stays/services/media_service.dart';
import 'package:pawsome_stays/services/navigation_service.dart';
import 'package:pawsome_stays/widgets/custom_formfield.dart';
import 'dart:io';

import '../consts.dart';


class PetregisterPage extends StatefulWidget {
  const PetregisterPage({super.key});

  @override
  State<PetregisterPage> createState() => _PetregisterPageState();
}

class _PetregisterPageState extends State<PetregisterPage> {

  final GlobalKey<FormState> _petRegisterFormKey= GlobalKey();

  final GetIt _getIt = GetIt.instance;

  late MediaService _mediaService;
  late AlertService _alertService;
  late NavigationService _navigationService;

  File? selectedImage;
  String? petName, petnotes;
  String petType='Dog', petSex='Male';
  double petAge=0;
  bool isLoading= false;

  var pettypes= ['Dog', 'Cat'];
  var petsexes= ['Male', 'Female'];

  @override
  void initState() {
    super.initState();
    _mediaService = _getIt.get<MediaService>();
    _alertService = _getIt.get<AlertService>();
    _navigationService = _getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/loginbg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _headerText(),
              if (!isLoading) _petRegisterForm(),
              if (!isLoading) _petRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerText(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child:Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height:30),
          Text(
            'Register your Pet!',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            "Let's start with some basics",
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue[500],
            ),
          )
        ],
      ),
    );
  }

  Widget _petRegisterForm(){
    return Container(
      height: MediaQuery.sizeOf(context).height*0.60,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height*0.05,
      ),
      child: Form(
        key : _petRegisterFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _petPfpSelectionField(),
            CustomFormfield(
                labelText: "Name",
                hintText: "pet name",
                height: MediaQuery.sizeOf(context).height * 0.1,
                regexp: NAME_VALIDATION_REGEX,
                onSaved: (value){
                  petName= value;
                }
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Type of pet : ',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(width: 30,),
                DropdownButton(
                    value: petType,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: pettypes.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? value){
                      setState(() {
                        petType=value!;
                      });
                    }
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Sex of pet : ',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(width: 30,),
                DropdownButton(
                    value: petSex,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: petsexes.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? value){
                      setState(() {
                        petSex=value!;
                      });
                    }
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Age : ',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Slider(
                  value: petAge,
                  max: 17,
                  divisions: 20,
                  label: petAge.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        petAge = value;
                      });
                    },
                )
              ],
            ),
            CustomFormfield(
                labelText: "Notes",
                hintText: "eg: allergies",
                height: MediaQuery.sizeOf(context).height * 0.1,
                regexp: DEFAULT_VALIDATION_REGEX,
                onSaved: (value){
                  petnotes = value;
                }
            ),
          ],
        )
      ),
    );
  }

  Widget _petRegisterButton(){
    return SizedBox(
        width: 200,
        child: ElevatedButton(
          onPressed: () async{
            setState(() {
              isLoading= true;
            });
            try{
              if((_petRegisterFormKey.currentState?.validate() ?? false )){
                _petRegisterFormKey.currentState?.save();
                print("Name: ${petName}, \nType:${petType}, \nSex:${petSex}, \nAge:${petAge}, \nNotes: ${petnotes}");
              }
            }catch(e){
              print(e);
            }
            /*setState(() {
              isLoading=false;
            });*/
            _alertService.showToast(text: "Pet Registered Successfully");
            _navigationService.pushReplacementNamed("/login");
          },
          child: Text(
            'Register Pet',
            style: TextStyle(
              fontSize: 20,
              color:Colors.blue,
            ),
          ),
        )
    );
  }

  Widget _petPfpSelectionField(){
    return GestureDetector(
      onTap: () async{
        File? file = await _mediaService.getImageFromGallery();
        if (file != null){
          setState(() {
            selectedImage = file;
          });
        }
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
        backgroundImage: selectedImage != null
            ? FileImage(selectedImage!)
            : NetworkImage(PLACEHOLDER_PFP) as ImageProvider,
      ),
    );
  }
}

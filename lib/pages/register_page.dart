import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pawsome_stays/services/alert_service.dart';
import 'package:pawsome_stays/services/auth_service.dart';
import 'package:pawsome_stays/services/media_service.dart';
import 'package:pawsome_stays/widgets/custom_formfield.dart';
import 'dart:io';

import '../consts.dart';
import '../services/navigation_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final GetIt _getIt = GetIt.instance;
  final GlobalKey<FormState> _registerFormKey= GlobalKey();

  late MediaService _mediaService;
  late NavigationService _navigationService;
  late AuthService _authService;
  late AlertService _alertService;


  File? selectedImage; //if user wants to give image
  String? email, password, name, phno;
  bool isLoading=false;

  @override
  void initState() {
    super.initState();
    _mediaService = _getIt.get<MediaService>();
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
    _alertService = _getIt.get<AlertService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(),
    );
  }

  Widget _buildUI(){
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
              children:[
                _headerText(),
                if (!isLoading) _registerForm(),
                if (!isLoading) _loginAccountLink(),
                if (isLoading) const Expanded(
                  child: Center(
                    child: CircularProgressIndicator()
                  )
                ),
              ],
            ),
          ),
        )
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
            'Nice to Meet You!',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Text(
            'Register an account using the form below',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue[500],
            ),
          )
        ],
      ),
    );
  }

  Widget _registerForm(){
    return Container(
      height: MediaQuery.sizeOf(context).height*0.60,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height*0.05,
      ),
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _pfpSelectionField(),
            CustomFormfield(
                labelText: "Name",
                hintText: "John Doe",
                height: MediaQuery.sizeOf(context).height * 0.1,
                regexp: NAME_VALIDATION_REGEX,
                onSaved: (value){
                  setState(() {
                    name= value;
                  });
                }
            ),
            CustomFormfield(
                labelText: "Email",
                hintText: "johndoe@gmail.com",
                height: MediaQuery.sizeOf(context).height * 0.1,
                regexp: EMAIL_VALIDATION_REGEX,
                onSaved: (value){
                  setState(() {
                    email= value;
                  });
                }
            ),
            CustomFormfield(
                labelText: "Password",
                hintText: "Test123!",
                obscureText: true,
                height: MediaQuery.sizeOf(context).height * 0.1,
                regexp: PASSWORD_VALIDATION_REGEX,
                onSaved: (value){
                  setState(() {
                    password= value;
                  });
                }
            ),
            CustomFormfield(
                labelText: "Phone No.",
                hintText: "1234567890",
                height: MediaQuery.sizeOf(context).height * 0.1,
                regexp: PHONE_VALIDATION_REGEX,
                onSaved: (value){
                  setState(() {
                    phno= value;
                  });
                }
            ),
            _registerButton(),
          ],
        )
      ),
    );
  }

  Widget _registerButton(){
    return SizedBox(
        width: 150,
        child: ElevatedButton(
          onPressed: () async{
            setState(() {
              isLoading= true;
            });
            try{
              if((_registerFormKey.currentState?.validate() ?? false )){
                _registerFormKey.currentState?.save();
                bool result = await _authService.signup(email!, password!);
                if (result){
                  print(result);
                }
              }
            }catch(e){
              print(e);
            }
            setState(() {
              isLoading=false;
            });
            /*_alertService.showToast(text: "Account Registered Successfully");
            _navigationService.goBack();*/
          },
          child: Text(
            'SignUp',
            style: TextStyle(
              fontSize: 20,
              color:Colors.blue,
            ),
          ),
        )
    );
  }

  Widget _loginAccountLink(){
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            "Already have an account?",
            style: TextStyle(
              color:Colors.blue,
              fontSize: 18,
            ),
          ),
          GestureDetector(
            onTap:(){
              _navigationService.goBack();
            },
            child: const Text(
              " Login",
              style: TextStyle(
                color:Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pfpSelectionField(){
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

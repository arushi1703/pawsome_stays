import 'package:flutter/material.dart';
import 'package:pawsome_stays/services/alert_service.dart';
import 'package:pawsome_stays/services/auth_service.dart';
import 'package:pawsome_stays/services/navigation_service.dart';
import 'package:pawsome_stays/widgets/custom_formfield.dart';
import 'package:get_it/get_it.dart';
import '../consts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GetIt _getIt = GetIt.instance;
  final GlobalKey<FormState> _loginFormKey= GlobalKey();

  late AuthService _authService;
  late NavigationService _navigationService;
  late AlertService _alertService;

  String? email, password;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
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
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: AssetImage("images/logo.jpg"),
                      fit : BoxFit.fill,
                    )
                ),
                height : 200,
              ),
            ),
            _headerText(),
            _loginForm(),
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
            'Welcome Back!',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Text(
            'Enter details to login',
            style: TextStyle(
              fontSize: 18,
              color: Colors.blue[500],
            ),
          )
        ],
      ),
    );
  }

  Widget _loginForm(){
    return Container(
      height: MediaQuery.sizeOf(context).height*0.40,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height*0.05,
      ),
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomFormfield(
              labelText:"Email",
              hintText: "example@gmail.com",
              height: MediaQuery.sizeOf(context).height*0.10,
              regexp: EMAIL_VALIDATION_REGEX,
              onSaved: (value){
                setState(() {
                  email= value;
                });
              },
            ),
            SizedBox(height:20),
            CustomFormfield(
              labelText:"Password",
              hintText: "",
              height: MediaQuery.sizeOf(context).height*0.10,
              regexp: PASSWORD_VALIDATION_REGEX,
              obscureText: true,
              onSaved: (value){
                setState(() {
                  password= value;
                });
              },
            ),
            _loginButton(),
            _createAccountLink(),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(){
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: () async{
          if (_loginFormKey.currentState?.validate() ?? false){
            _loginFormKey.currentState?.save();
            bool result = await _authService.login(email!, password!);
            if (result){
              _alertService.showToast(
                text: "Login Successful",
                icon: Icons.check,
              );
              _navigationService.pushReplacementNamed("/home");
            }
            else{
              _alertService.showToast(
                text: "Failed to login! Please try again",
                icon: Icons.error,
              );
            }
          }
        },
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            color:Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget _createAccountLink(){
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            "Don't have an account?",
            style: TextStyle(
              color:Colors.white,
              fontSize: 18,
            ),
          ),
          GestureDetector(
            onTap:(){
              _navigationService.pushNamed("/register");
            },
            child: const Text(
              " Sign Up",
              style: TextStyle(
                color:Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

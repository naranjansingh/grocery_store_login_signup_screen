import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:cutkut/ui/home.dart';

class cutkutLogin extends StatefulWidget {
  @override
  _cutkutLoginState createState() => _cutkutLoginState();
}

class _cutkutLoginState extends State<cutkutLogin> {

  Country _selectedCountry;
  final controller = TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String consumerMobileNumber;
  Color color = Colors.grey;

  @override
  void initState() {
    _selectedCountry = Country.IN;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: formUI(),
      )
    );
  }

  Widget formUI() {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 180, left: 20, right: 20),

            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  appIcon(),
                  SizedBox(height: 20),
                  welcomeText(),
                  SizedBox(height: 20),
                  editTextWithCountryCode(),
                  SizedBox(height: 20),
                  textDescription(),
                  SizedBox(height: 20),
                  sendOTPButtonWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }

    return null;
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      print("Mobile $consumerMobileNumber");
      print('Country ${_selectedCountry.name}');

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }

  Widget sendOTPButtonWidget() {
    return Container(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(

        onPressed: _sendToServer,
        child: Text('Send OTP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        //color: Theme.of(context).accentColor,

      ),
    );
  }

  Widget textDescription() {
    return Container(
        child: Text(
      'We never compromise on security!\nHelp us create a safe place by providing your mobile number to maintain authenticity',
      style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.normal, color: Colors.grey),
    ));
  }

  Widget editTextWithCountryCode() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: CountryPicker(
            showDialingCode: true,
            showName: false,
            showCurrencyISO: false,
            onChanged: (Country country) {
              setState(() {
                _selectedCountry = country;
              });
            },
            selectedCountry: _selectedCountry,
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: TextFormField(

            maxLength: 10,
            keyboardType: TextInputType.number,
            onChanged: (String newVal) {
              setState(() {
                if(newVal.length==10){
                  color = Colors.teal;
                }else{
                  color = Colors.grey;
                }
              });
            },
            decoration: InputDecoration(
                labelText: 'Enter phone number',
                suffixIcon: Icon(CupertinoIcons.phone)),
            validator: _validateMobile,
            controller: controller,
            onSaved: (String phoneNumber) {
              debugPrint('find the input length ${phoneNumber.length}');
              consumerMobileNumber = phoneNumber;
            },
          ),
        )
      ],
    );
  }

  Widget appIcon() {
    return Align(
        alignment: Alignment.topLeft,
        child: Image.asset('assets/img/doctor.png',
            width: 80, height: 80, color: Colors.teal));
  }

  Widget welcomeText() {
    return Container(
      child: const Text(
        'Welcome to\ncutkut',
        style: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

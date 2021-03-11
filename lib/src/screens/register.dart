import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vacpass_app/src/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../route.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() =>  _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

 TextEditingController _email = TextEditingController();
 TextEditingController _password = TextEditingController();
 TextEditingController _confirmpassword = TextEditingController();
 TextEditingController _firstName = TextEditingController();
 TextEditingController _lastName = TextEditingController();
 TextEditingController _address = TextEditingController();
 TextEditingController _mbrand = TextEditingController();
 TextEditingController _brandName = TextEditingController();
 TextEditingController _brandNumber = TextEditingController();
 TextEditingController _placeVacined = TextEditingController();
 TextEditingController _physicianName = TextEditingController();
 TextEditingController _licenseNumber = TextEditingController();

 DateTime _lastRTPCR,_dateVacined;
 String _strLastRTPCR;
 TextEditingController _dateController = TextEditingController();
 TextEditingController _dateVController = TextEditingController();

 String _lastnamelabel = '';
 String _firstnamelabel = '';
 String _addresslabel = '';
 String _mbrandlabel = '';
 String _brandnamelabel = '';
 String _brandnumberlabel = '';
 String _datevaccinedlabel = '';
 String _placevaccinedlabel = '';
 String _physiciannamelabel = '';
 String _licensenumberlabel = '';
 String _lastrtpcrlabel = '';
 String _emaillabel = '';
 String _passwordlabel = '';
 String _confirmpasswordlabel = '';

 CollectionReference users = FirebaseFirestore.instance.collection('users');

  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  Widget buildLastname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            _lastnamelabel,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2),
              )
            ]
          ),
          height: 60,
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: _lastName,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.purple[300]
              ),
              hintText: 'Lastname',
              hintStyle: TextStyle(
                color: Colors.black38
              )
            ), 
            validator: (String value) { 
              if (value.isEmpty) return 'Last Name is Required';
              if(value.length < 2) return 'Last name should contain atleast 2 letters';
              return null;
            },
            onChanged: ((value){
              if(_lastName.text.isNotEmpty && _lastName.text.length == 1) setState(() {_lastnamelabel = 'Last name'; });
              if(_lastName.text.isEmpty) setState(() {_lastnamelabel = ''; });
            }),
          )
        ),
      ],
    );
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
           _emaillabel,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2),
              )
            ]
          ),
          height: 60,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _email,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.purple[300],
              ),
              hintText: 'Email address',
              hintStyle: TextStyle(
                color: Colors.black38
              )
            ),
            validator: (String value) {
                  if (value.isEmpty) return 'Email is Required';
                  if (!RegExp( r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)) {
                    return 'Please enter a valid email Address';
                  }
                  return null;
            },
            onChanged: ((value){
              if(_email.text.isNotEmpty && _email.text.length == 1) setState(() {_emaillabel = 'Email address'; });
              if(_email.text.isEmpty) setState(() {_emaillabel = ''; });
            }),
          )
        ),
      ],
    );
}


  Widget buildAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            _addresslabel,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2),
              )
            ]
          ),
          height: 60,
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: _address,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.location_city,
                color: Colors.purple[300]
              ),
              hintText: 'Address',
              hintStyle: TextStyle(
                color: Colors.black38
              )
            ),
            validator: (String value) {
                if (value.isEmpty) return 'Address is Required';
              if(value.length < 10) return 'Address should contain atleast 10 letters';
                return null;
            },
            onChanged: ((value){
              if(_address.text.isNotEmpty && _address.text.length == 1) setState(() {_addresslabel = 'Address'; });
              if(_address.text.isEmpty) setState(() {_addresslabel = ''; });
            }),
          )
        ),
      ],
    );
}

Widget buildFirstname() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            _firstnamelabel,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2),
              )
            ]
          ),
          height: 60,
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: _firstName,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.purple[300]
              ),
              hintText: 'Firstname',
              hintStyle: TextStyle(
                color: Colors.black38
              )
            ),
            validator: (String value) {
              if (value.isEmpty) return 'First Name is Required';
              if(value.length < 4) return 'First name should contain atleast 4 letters';
              return null;
            },
            onChanged: ((value){
              if(_firstName.text.isNotEmpty && _firstName.text.length == 1) setState(() {_firstnamelabel = 'First name'; });
              if(_firstName.text.isEmpty) setState(() {_firstnamelabel = ''; });
            }),
          )
        ),
      ],
    );
}

Widget buildBrandName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            _brandnamelabel,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2),
              )
            ]
          ),
          height: 60,
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: _brandName,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.branding_watermark,
                color: Colors.purple[300]
              ),
              hintText: 'Brand Name',
              hintStyle: TextStyle(
                color: Colors.black38
              )
            ), 
            validator: (String value) {
              if (value.isEmpty) return 'Brand Name is Required';
              if(value.length < 4) return 'Brand name should contain atleast 4 letters';
              return null;
            },
            onChanged: ((value){
              if(_brandName.text.isNotEmpty && _brandName.text.length == 1) setState(() {_brandnamelabel = 'Brand Name'; });
              if(_brandName.text.isEmpty) setState(() {_brandnamelabel = ''; });
            }),
          )
        ),
      ],
    );
}

Widget buildBrandno() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            _brandnumberlabel,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2),
              )
            ]
          ),
          height: 60,
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: _brandNumber,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.format_list_numbered,
                color: Colors.purple[300]
              ),
              hintText: 'Brand No',
              hintStyle: TextStyle(
                color: Colors.black38
              )
            ),
            validator: (String value) {
              if (value.isEmpty) return 'Brand No. is Required';
              if(value.length < 4) return 'Brand number should contain atleast 4 digit';
              return null;
            },
            onChanged: ((value){
              if(_brandNumber.text.isNotEmpty && _brandNumber.text.length == 1) setState(() {_brandnumberlabel = 'Brand number'; });
              if(_brandNumber.text.isEmpty) setState(() {_brandnumberlabel = ''; });
            }),
          )
        ),
      ],
    );
}

Widget buildPhysicianName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            _physiciannamelabel,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2),
              )
            ]
          ),
          height: 60,
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: _physicianName,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.local_hospital ,
                color: Colors.purple[300]
              ),
              hintText: 'Physician Name',
              hintStyle: TextStyle(
                color: Colors.black38
              )
            ),
            validator: (String value) {
              if (value.isEmpty) return 'Physician/Nurse Name is Required';
              if(value.length < 2) return 'Physician name should contain atleast 2 letter';
              return null;
            },
            onChanged: ((value){
              if(_physicianName.text.isNotEmpty && _physicianName.text.length == 1) setState(() {_physiciannamelabel = 'Physician name'; });
              if(_physicianName.text.isEmpty) setState(() {_physiciannamelabel = ''; });
            }),
          )
        ),
      ],
    );
}

Widget buildplaceVacined() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            _placevaccinedlabel,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2),
              )
            ]
          ),
          height: 60,
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: _placeVacined,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.add_location,
                color: Colors.purple[300]
              ),
              hintText: 'Place of Vaccination',
              hintStyle: TextStyle(
                color: Colors.black38
              )
            ),
            validator: (String value) {
              if (value.isEmpty) return 'Place of Vaccination is Required';
              if(value.length < 8) return 'Hospital/Health center name should contain atleast 8 letters';
              return null;
            },
            onChanged: ((value){
              if(_placeVacined.text.isNotEmpty && _placeVacined.text.length == 1) setState(() {_placevaccinedlabel = 'Place of Vaccination'; });
              if(_placeVacined.text.isEmpty) setState(() {_placevaccinedlabel = ''; });
            }),
          )
        ),
      ],
    );
}

Widget buildLicenseNo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            _licensenumberlabel,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2),
              )
            ]
          ),
          height: 60,
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: _licenseNumber,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.credit_card ,
                color: Colors.purple[300]
              ),
              hintText: 'License Number',
              hintStyle: TextStyle(
                color: Colors.black38
              )
            ),
            validator: (String value) {
              if (value.isEmpty) return 'License No. is Required';
              if(value.length < 5) return 'License number should contain atleast 5 digits';
              return null;
            },
            onChanged: ((value){
              if(_licenseNumber.text.isNotEmpty && _licenseNumber.text.length == 1) setState(() {_licensenumberlabel = 'License Number'; });
              if(_licenseNumber.text.isEmpty) setState(() {_licensenumberlabel = ''; });
            }),
          )
        ),
      ],
    );
}

Widget buildDateVaccined() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
                Text(
                    _datevaccinedlabel,
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0,2),
                      )
                    ]
                  ),
                  height: 60,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                    controller: _dateVController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14),
                      prefixIcon: Icon(
                        Icons.date_range,
                        color: Colors.purple[300]
                      ),
                      hintText: 'Date Vaccined',
                      hintStyle: TextStyle(
                        color: Colors.black38
                      )
                    ),
                    onTap: () {
                        showDatePicker(
                          context: context, 
                          initialDate: DateTime.now(), 
                          firstDate: DateTime(2020), 
                          lastDate: DateTime.now()
                        ).then((value) =>
                           setState(() {
                            _dateVacined = value;
                            _dateVController..text = _dateVacined.toString();
                            if(_dateVController.text.isNotEmpty) setState(() {_datevaccinedlabel = 'Date of Vaccination'; });
                            if(_dateVController.text.isEmpty) setState(() {_datevaccinedlabel = ''; });
                          })
                        );
                    },
                    validator: (String value) {
                        if (value.isEmpty) return 'Date of Vaccination is Required';
                        if(value.toString() == DateTime.now().toString()) return 'Vaccination  date is the day you vacinated';
                        return null;
                    },
                  )
                ),
      ],
    );
}

Widget buildlastRTPCR() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: 
        <Widget>[
          Text (
              _lastrtpcrlabel,
              style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0,2),
                )
              ]
            ),
            height: 60,
            child: TextFormField(
              keyboardType: TextInputType.datetime,
              style: TextStyle(
                color: Colors.black87,
              ),
              controller: _dateController,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.date_range_sharp,
                  color: Colors.purple[300]
                ),
                hintText: _strLastRTPCR ?? 'Last RTPCR',
                hintStyle: TextStyle(
                  color: Colors.black38
                )
              ),
              onTap: () {
                  showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(2020), 
                    lastDate: DateTime.now()
                  ).then((value) =>
                      setState(() {
                      _lastRTPCR = value;
                      _dateController..text = _lastRTPCR.toString();
                      if(_dateController.text.isNotEmpty) setState(() {_lastrtpcrlabel = 'Last RT PCR Date'; });
                    })
                  );
              },
              validator: (String value) {
                if (value.isEmpty) return 'Date of Last RT-PCR is Required';
                return null;
              },
              onChanged: ((value){
                if(_dateController.text.isEmpty) setState(() {_lastrtpcrlabel = ''; });
              }),
            )
          ),
      ],
    );
}

Widget buildManufacurer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            _mbrandlabel,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2),
              )
            ]
          ),
          height: 60,
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: _mbrand,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.business,
                color: Colors.purple[300]
              ),
              hintText: 'Manufacurer name',
              hintStyle: TextStyle(
                color: Colors.black38
              )
            ),
            validator: (String value) {
              if (value.isEmpty) return 'Manufacturer Brand is Required';
              if(value.length < 5) return 'Manufacturer Brand should contain atleast 5 letters';
              return null;
            },
            onChanged: ((value){
              if(_mbrand.text.isNotEmpty && _mbrand.text.length == 1) setState(() {_mbrandlabel = 'Manufacturer name'; });
              if(_mbrand.text.isEmpty) setState(() {_mbrandlabel = ''; });
            }),
          )
        ),
      ],
    );
}

Widget buildpassword() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            _passwordlabel,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2),
              )
            ]
          ),
          height: 60,
          child: TextFormField(
            obscureText: true,
            controller: _password,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.purple[300]
              ),
              hintText: 'Password',
              hintStyle: TextStyle(
                color: Colors.black38
              )
            ),
             validator: (String value) {
                  if (value.isEmpty) return 'Password is Required';
                  return null;
                },
            onChanged: ((value){
              if(_password.text.isNotEmpty && _password.text.length == 1) setState(() {_passwordlabel = 'Password'; });
              if(_password.text.isEmpty) setState(() {_passwordlabel = ''; });
            }),
          ),
        ),
      ],
    );
}

Widget buildconfirmpassword() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            _confirmpasswordlabel,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2),
              )
            ]
          ),
          height: 60,
          child: TextFormField(
            obscureText: true,
            controller: _confirmpassword,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.purple[300]
              ),
              hintText: 'Confirm password',
              hintStyle: TextStyle(
                color: Colors.black38
              )
            ),
             validator: (String value) {
                  if (value.isEmpty) return 'Password is Required';
                  if(_password.text!= _confirmpassword.text){
                    _password.clear();
                    _confirmpassword.clear();
                    return 'Confirmation password and password didn\'t match';
                  }
                  else return null;
            },
            onChanged: ((value){
              if(_confirmpassword.text.isNotEmpty && _confirmpassword.text.length == 1) setState(() {_confirmpasswordlabel = 'Confirm password'; });
              if(_confirmpassword.text.isEmpty) setState(() {_confirmpasswordlabel = ''; });
            }),
          ),
        ),
      ],
    );
}


Widget buildSignInBtn(){
  return Container(
    padding: EdgeInsets.symmetric( vertical: 20),
    width: double.infinity,
    child: 
      RaisedButton(
        padding: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        color: Colors.white,
        child: Text(
          'Sign In',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        onPressed: (){
          if (_formKey.currentState.validate()) {
            try{
              auth.createUserWithEmailAndPassword(email: _email.text,password: _password.text).then((_){

                users
                .doc(auth.currentUser.uid)
                .set({
                    'role': 'passenger',
                    'L_name': _lastName.text,
                    'F_name': _firstName.text,
                    'Address': _address.text,
                    'M_Brand': _mbrand.text,
                    'Brand_name': _brandName.text,
                    'Brand_number': _brandNumber.text,
                    'Date_of_Vaccination': _dateVacined,
                    'Placed_vacined': _placeVacined.text,
                    'Physician_name': _physicianName.text,
                    'License_no': _licenseNumber.text,
                    'RT_PCR_Date': _lastRTPCR,
                  }).then((value) =>
                      Navigator.of(context).pushNamed(AppRoutes.authHome)
                  );
              });
            } on FirebaseAuthException catch(e){
              print(e.message);
            }
          }
        },
    )
  );
}

Widget buildCancelBtn(){
  return Container(
    width: double.infinity,
    child: 
      RaisedButton(
        padding: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        color: Colors.white,
        child: Text(
          'Cancel',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        onPressed: (){
          Navigator.of(context).pushNamed(AppRoutes.authLogin);
        },
    )
  );
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
                title: Text('Registration'),
                backgroundColor: Colors.pinkAccent,
                automaticallyImplyLeading: false,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.pinkAccent,
                      Colors.pink,
                      Colors.purple[300],
                      Colors.purpleAccent,
                    ]
                  )
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 30,
                  ),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          SizedBox(height: 7),
                          buildLastname(),
                          SizedBox(height: 7),
                          buildFirstname(),
                          SizedBox(height: 7),
                          buildAddress(),
                          SizedBox(height: 7),
                          buildManufacurer(),
                          SizedBox(height: 7),
                          buildBrandName(),
                          SizedBox(height: 7),
                          buildBrandno(),
                          SizedBox(height: 7),
                          buildDateVaccined(),
                          SizedBox(height: 7),
                          buildplaceVacined(),
                          SizedBox(height: 7),
                          buildPhysicianName(),
                          SizedBox(height: 7),
                          buildLicenseNo(),
                          SizedBox(height: 7),
                          buildlastRTPCR(),
                          SizedBox(height: 7),
                          buildEmail(),
                          SizedBox(height: 7),
                          buildpassword(),
                          SizedBox(height: 7),
                          buildconfirmpassword(),
                          buildSignInBtn(),
                          buildCancelBtn()
                      ],
                      )
                   ),
                  
                  ],
                )
                )
              )
            ],
          )
        )
      )
    );
  }
}
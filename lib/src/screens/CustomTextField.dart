import 'package:flutter/material.dart';
import 'package:vacpass_app/src/screens/ValidatorFunction.dart';

class CustomTextField extends StatelessWidget{
  final String action;
  final TextEditingController _controller;
  final TextInputType keyType;
  final String label;
  final bool obs;

  CustomTextField(this._controller, this.keyType, this.label, this.action, this.obs);

  Icon iconStyle(){
    if(action == 'email') return Icon(Icons.email, color: Colors.purple[300]);
    if(action == 'password') return Icon(Icons.lock, color: Colors.purple[300]);
    if(action == 'lastname') return Icon(Icons.person, color: Colors.purple[300]);
    if(action == 'firstname') return Icon(Icons.person, color: Colors.purple[300]);
    if(action == 'address') return Icon(Icons.location_city, color: Colors.purple[300]);
    if(action == 'brandname') return Icon(Icons.branding_watermark, color: Colors.purple[300]);
    if(action == 'brandnumber') return Icon(Icons.format_list_numbered, color: Colors.purple[300]);
    if(action == 'physician') return Icon(Icons.local_hospital, color: Colors.purple[300]);
    if(action == 'placevaccined') return Icon(Icons.add_location, color: Colors.purple[300]);
    if(action == 'licensenumber') return Icon(Icons.credit_card, color: Colors.purple[300]);
    if(action == 'manufacturer') return Icon(Icons.business, color: Colors.purple[300]);
    return null;
  }

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // CustomText(this.label),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
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
            obscureText: this.obs,
            controller: this._controller,
            validator: (String value){
              return ValidatorFunction(action).validate(value);
            },
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: iconStyle(),
              hintText: this.label,
              hintStyle: TextStyle(
                color: Colors.black38
              )
            ),
          ),
        )
      ],
    );
  }
}

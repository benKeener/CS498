import 'package:flutter/material.dart';


class  LoginPage extends StatefulWidget {
  const  LoginPage({Key? key}) : super(key: key);

  @override
  _ LoginPageState createState() => _ LoginPageState();
}

class _ LoginPageState extends State< LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:[
            Colors.blue,
            Colors.teal,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter

        ),
      ),
      child: ListView(
        children: <Widget>[
          headerSection(),
          textSection(),
          buttonSection(),
        ],
      ),
    );
  }

  Container textSection(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: <Widget>[
          txtEmail("LinkBlue ID", Icons.email),
          SizedBox(height: 30,),
          txtPassword("Password", Icons.password),
        ],
      ),
    )
  }

  TextFormField txtEmail(String title, IconData icon){
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: Colors.white70),
        icon: Icon(icon)
      ),
    );
  }

  Container headerSection(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Text("Login", style: TextStyle(color: Colors.white)),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pravana_eet/components/loading.dart';
import 'package:pravana_eet/db/Users.dart';
import 'package:pravana_eet/db/functions.dart';
import 'package:pravana_eet/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'LoginScreen.dart';

FirebaseUser loggedInUser;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  UserServices userServices=UserServices();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  bool isPhotoUrl() {
    if (loggedInUser.photoUrl != null) {
      return true;
    } else {
      return false;
    }
  }

  bool isDisplayName() {
    if (loggedInUser.displayName != null) {
      return true;
    } else {
      return false;
    }
  }
  final Color kGradientColorStart = Color(0xfff00079);
  final Color kGradientColorEnd = Color(0xfff2a041);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    showLogOutDialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        title: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Are you sure want to log out?',
                  style: TextStyle(fontSize: 18, color: Color(0xff3c4848)),
                ),
              ],
            )),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 10,
            ),
            RaisedButton(
              color: kGradientColorEnd,
              elevation: 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Logout',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                ],
              ),
              onPressed: () {
                user.signOut();
                changeScreenReplacement(context, LoginScreen());
                Fluttertoast.showToast(
                  msg: "logged Out Successfully",
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
              },
            ),
            RaisedButton(
              color: kGradientColorEnd,
              elevation: 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cancel',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    }
    if (isLoading) {
      return Loading();
    } else {
      return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kGradientColorStart, kGradientColorEnd],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          centerTitle: true,
          title: Text('Pranava Labs'),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: isDisplayName()
                    ? Text(
                        '${loggedInUser.displayName}',
                        style: TextStyle(color: Colors.white),
                      )
                    : Text(
                        'Hey! User',
                        style: TextStyle(color: Colors.white),
                      ),
                accountEmail: Text('${loggedInUser.email}'),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage: isPhotoUrl()
                        ? NetworkImage('${loggedInUser.photoUrl}')
                        : AssetImage(
                            'Assets/profile.jpg',
                          ),
                    backgroundColor: Colors.grey,
                  ),
                ),
                decoration: BoxDecoration(  gradient: LinearGradient(
                  colors: [kGradientColorStart, kGradientColorEnd],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),),
              ),
              InkWell(
                onTap: () {
                  showLogOutDialog(context);
                },
                child: ListTile(
                  title: Text('Logout'),
                  leading: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child:Text('Ankit Wadhwa',style: TextStyle(fontSize: 30,),
        ),
      ));
    }
  }
}



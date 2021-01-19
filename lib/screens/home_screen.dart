import 'package:firebaseAuthGoogle/utils/googleSignIn_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User signedInUser;

  void updateData() async {
    User gotUser = await signInWithGoogle();

    setState(() {
      signedInUser = gotUser;
    });
  }

  @override
  void initState() {
    super.initState();
    updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20.0),
          child: signedInUser == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome \nBack To \nMyApp",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(height: 50.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60.0, vertical: 20.0),
                      child: MaterialButton(
                        onPressed: () {
                          updateData();
                        },
                        minWidth: 30.0,
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10.0),
                            Text('Sign In With Google'),
                          ],
                        ),
                        shape: StadiumBorder(
                          side: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(signedInUser.displayName ?? ""),
                          Text(signedInUser.email ?? ""),
                          Text(signedInUser.phoneNumber ?? ""),
                          Image(
                            image: NetworkImage(signedInUser.photoURL ?? ""),
                            height: 50.0,
                            width: 50.0,
                          ),
                          MaterialButton(
                            onPressed: () async {
                              signOutGoogle();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            },
                            minWidth: 30.0,
                            child: Text('Sign Out'),
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Login to continue',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

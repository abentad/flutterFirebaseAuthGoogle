import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);

  final authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final User currentUser = _auth.currentUser;
  assert(currentUser.uid == user.uid);

  return user;
}

void signOutGoogle() async {
  await googleSignIn.signOut();
}

// static Future login() async {
//   final googleSignIn = GoogleSignIn();
//   final googleSignInAccount = await googleSignIn.signIn();
//   final googleAuth = await googleSignInAccount.authentication;
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );
//   final authResult =
//       await FirebaseAuth.instance.signInWithCredential(credential);
//   final User user = authResult.user;

//   //check if the user is not anonymous and their user idToken is not null
//   assert(!user.isAnonymous);
//   assert(await user.getIdToken() != null);

//   final User currentUser =
//   print(user.displayName);
// }

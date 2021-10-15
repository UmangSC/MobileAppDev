class Authentication{
	FirebaseAuth_auth = FirebaseAuth.instance;
	static String userid;

	Future<bool> emailSignIn(String email, String password){
	try {
  	UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    	email: "barry.allen@example.com",
    	password: "SuperSecretPassword!"
  	);
	} on FirebaseAuthException catch (e) {
  	if (e.code == 'user-not-found') {
    	print('No user found for that email.');
  	} else if (e.code == 'wrong-password') {
    	print('Wrong password provided for that user.');
  	}
	}
	}

	Future<bool> emailVerify(String email){
	User? user = FirebaseAuth.instance.currentUser;
	if (user != null && !user.emailVerified) {
  	var actionCodeSettings = ActionCodeSettings(
      	url: 'https://www.example.com/?email=${user.email}',
      	dynamicLinkDomain: 'example.page.link',
      	androidPackageName: 'com.example.android',
      	androidInstallApp: true,
      	androidMinimumVersion: '12',
      	iOSBundleId: 'com.example.ios',
      	handleCodeInApp: true,
  	);

  	await user.sendEmailVerification(actionCodeSettings);
	}	}

	Future<bool> emailLogin(String email){
	try {
  	UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    	email: "barry.allen@example.com",
    	password: "SuperSecretPassword!"
  	);
	} on FirebaseAuthException catch (e) {
  	if (e.code == 'user-not-found') {
    	print('No user found for that email.');
  	} else if (e.code == 'wrong-password') {
    	print('Wrong password provided for that user.');
  	}
	}
	}

	Future<bool> FacebookLogin(){
	import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

	Future<UserCredential> signInWithFacebook() async {
  	// Trigger the sign-in flow
  	final LoginResult loginResult = await FacebookAuth.instance.login();

  	// Create a credential from the access token
  	final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);

  	// Once signed in, return the UserCredential
 	 return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
	}
	}

	Future<bool> GoogleLogin(){
	import 'package:google_sign_in/google_sign_in.dart';

	Future<UserCredential> signInWithGoogle() async {
  	// Trigger the authentication flow
  	final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  	// Obtain the auth details from the request
  	final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  	// Create a new credential
  	final credential = GoogleAuthProvider.credential(
    	accessToken: googleAuth?.accessToken,
    	idToken: googleAuth?.idToken,
  	);

  	// Once signed in, return the UserCredential
  	return await FirebaseAuth.instance.signInWithCredential(credential);
	}
	}

	Future<bool> TwitterLogin(){
	import 'package:twitter_login/twitter_login.dart';

	Future<UserCredential> signInWithTwitter() async {
  	// Create a TwitterLogin instance
  	final twitterLogin = new TwitterLogin(
    	apiKey: '<your consumer key>',
    	apiSecretKey:' <your consumer secret>',
    	redirectURI: '<your_scheme>://'
  	);

  	// Trigger the sign-in flow
  	final authResult = twitterLogin.login();

  	// Create a credential from the access token
  	final twitterAuthCredential = TwitterAuthProvider.credential(
    	accessToken: authResult.authToken!,
    	secret: authResult.authTokenSecret!,
  	);

  	// Once signed in, return the UserCredential
  	return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
	}
	}

	Future<void> signInAnonymous(){
	UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
	}

	Future<void> signout(){
	await FirebaseAuth.instance.signOut();
	}

import 'package:first_pro/controllers/auth_controller.dart';
import 'package:first_pro/view/login_page.dart';
import 'package:first_pro/widgets/custom_input_field.dart';
import 'package:first_pro/widgets/custom_social_icon.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});


  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  bool _isLoading = false;

  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  // === AUTH INSTANCE ===
  final AuthController _authController = AuthController();



  // ==== CALL GOOGLE SIGN IN ===
  Future<void> _callGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    final errorMessage = await _authController.signInWithGoogle();

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Connexion avec Google réussie')),
    );

    Navigator.pushReplacementNamed(context, '/home');
  }

  // ==== CALL TWITTER SIGN IN ===
  Future<void> _callTwitterSignIn() async {
    setState(() {
      _isLoading = true;
    });

    final errorMessage = await _authController.signInWithTwitter();

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Connexion avec Twitter réussie')),
    );

    Navigator.pushReplacementNamed(context, '/home');
  }

  // ==== CALL FACEBOOK SIGN IN ===
  Future<void> _callFacebookSignIn() async {
    setState(() {
      _isLoading = true;
    });

    final errorMessage = await _authController.signInWithFacebook();

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Connexion avec Facebook réussie')),
    );

    Navigator.pushReplacementNamed(context, '/home');
  }

  // ==== CALL SIGN UP ===
  Future<void>  _callSignUp () async {
    setState(() {
      _isLoading = true;
    });

    final fullname = _fullnameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();


    final errorMessage = await _authController.registerUser(
      fullname: fullname,
      email: email,
      password: password,
    );

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      return;
    }

    // Clear form fields
    _fullnameController.clear();
    _emailController.clear();
    _passwordController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Compte créé avec succès ,Connectez-vous')),
    );

    Navigator.pushNamed(context, '/login');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0XFFF2F2F2),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),

                // === Logo ===
                Center(
                  child: Image.asset('lib/assets/logo.png',height: 100),
                ),
                SizedBox(height: 30),


                // === Title ===
                Center(
                  child: Text(
                    'Inscription',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(14, 56, 90, 100)

                    )
                  )
                ),
                SizedBox(height: 25),

                // ==== NAME FIELD ====

                CustomInputField(
                    icon: Icons.person,
                    hint: 'Nom complet',
                    controller: _fullnameController,
                ),
                SizedBox(height: 16),



                // ==== EMAIL FIELD ===
                CustomInputField(
                    icon: Icons.email,
                    hint: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                ),
                SizedBox(height: 16),


                // ==== PASSWORD FIELD ===
                CustomInputField(
                    icon: Icons.lock,
                    hint: 'Mot de passe',
                    obscure: true,
                    controller: _passwordController,


                ),
                SizedBox(height: 20),


                // === SIGN UP BUTTON ===
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(14, 56, 90, 100),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        )
                      ),
                      onPressed: _isLoading ? null : _callSignUp,
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('S\'inscrire',style: TextStyle(
                             fontSize: 16,
                             color: Colors.white
                             )
                          )
                  ),
                ),
                SizedBox(height: 15),


                // ===  SEPARATE ===
                Center(
                  child: Row(
                    children: [
                      Expanded(child: Divider()
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('OU'),
                      ),
                      Expanded(child: Divider()
                      )
                    ],
                  )
                ),
                SizedBox(height: 15),



                // === SOCIAL BUTTON ===
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSocialIcon(
                      child: Image.asset('lib/assets/google.png', height: 32),
                      onPressed: _callGoogleSignIn,
                    ),
                    SizedBox(width: 30),
                    CustomSocialIcon(
                      child: Image.asset('lib/assets/facebook.png', height: 35),
                      onPressed: _callFacebookSignIn,
                    ),
                    SizedBox(width: 30),
                    CustomSocialIcon(
                      child: Image.asset('lib/assets/twitter.png', height: 32),
                      onPressed: _callTwitterSignIn,
                    ),
                    SizedBox(width: 30),
                    CustomSocialIcon(child: Image.asset('lib/assets/icloud.png', height: 32)),
                  ],
                ),

                SizedBox(height: 20),



                // === HAVE AN ACCOUNT ===
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Vous avez déjà un compte?'),
                    TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text('Se connecter',style: TextStyle(
                          color: Color.fromRGBO(14, 56, 90,100),
                            fontWeight: FontWeight.bold
                        )
                        )
                    )
                  ],
                )




            ]

            )
          )
      ),
    );
  }


}




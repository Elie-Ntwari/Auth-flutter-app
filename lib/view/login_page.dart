import 'package:first_pro/controllers/auth_controller.dart';
import 'package:first_pro/widgets/custom_input_field.dart';
import 'package:first_pro/widgets/custom_social_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;

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

    // Navigate to home
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

    // Navigate to home
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

    // Navigate to home
    Navigator.pushReplacementNamed(context, '/home');
  }

  // ==== CALL LOGIN ===
  Future<void> _callLogin() async {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final errorMessage = await _authController.loginUser(
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
    _emailController.clear();
    _passwordController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Connexion réussie')),
    );

    // Navigate to home
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color(0XFFF2F2F2),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
            decoration: BoxDecoration(
              color: Color(0XFFF9F8FA),
              border: Border.all(color :Colors.grey.shade400),
              shape: BoxShape.circle
            ),
            child: Icon(FontAwesomeIcons.arrowLeft)
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),

                // === Logo ===
                Center(
                  child: Image.asset('lib/assets/logo.png',height: 100),
                ),
                SizedBox(height: 30),
                

                // === Title ===
                Center(
                  child: Text(
                    'Se Connecter',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(14, 56, 90, 100)

                    )
                  )
                ),
                SizedBox(height: 25),

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
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,

                ),
                SizedBox(height: 20),


                // === LOGIN BUTTON ===
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
                      onPressed: _isLoading ? null : _callLogin,
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Connexion',style: TextStyle(
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
                  //   SizedBox(width: 30),
                  //   CustomSocialIcon(child: Image.asset('lib/assets/icloud.png', height: 32)),
                  ],
                ),

                SizedBox(height: 20),



                // === HAVE AN ACCOUNT ===
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Vous n\'avez pas de compte?'),
                    TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text('S\'inscrire',style: TextStyle(
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

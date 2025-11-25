import 'package:first_pro/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  bool _isScrolled = false;

  final AuthController _authController = AuthController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final data = await _authController.getUserData();
    setState(() {
      _userData = data;
      _isLoading = false;
    });
  }

  void _onScroll() {
    setState(() {
      _isScrolled = _scrollController.offset > 50;
    });
  }

  Future<void> _logout() async {
    try {
      await _authController.logout();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la déconnexion: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: _isScrolled ? Colors.white : Colors.transparent,
        elevation: _isScrolled ? 4 : 0,
        title: _isScrolled
            ? Text(
                'Bienvenue',
                style: TextStyle(
                  color: Color.fromRGBO(14, 56, 90, 100),
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),

              // === Logo ===
              Center(
                child: Image.asset('lib/assets/logo.png', height: 100),
              ),
              SizedBox(height: 30),

              // === Title ===
              Center(
                child: Text(
                  'Bienvenue',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(14, 56, 90, 100),
                  ),
                ),
              ),
              SizedBox(height: 25),

              if (_isLoading)
                Center(child: CircularProgressIndicator())
              else if (_userData != null) ...[
                // === User Info ===
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Fullname
                        Row(
                          children: [
                            Icon(Icons.person, color: Color.fromRGBO(14, 56, 90, 100)),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                'Nom: ${_userData!['fullname'] ?? 'N/A'}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),

                        // Email
                        Row(
                          children: [
                            Icon(Icons.email, color: Color.fromRGBO(14, 56, 90, 100)),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                'Email: ${_userData!['email'] ?? 'N/A'}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),

                        // Created At
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: Color.fromRGBO(14, 56, 90, 100)),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                'Créé le: ${_formatDate(_userData!['createdAt'])}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // === LOGOUT BUTTON ===
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _logout,
                    child: Text(
                      'Se déconnecter',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ] else
                Center(
                  child: Text('Erreur lors du chargement des données utilisateur'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (_) {
      return dateString;
    }
  }
}
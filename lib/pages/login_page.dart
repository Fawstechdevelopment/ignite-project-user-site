// login_page.dart (API-integrated, preserves your original UI)
import 'package:flutter/material.dart';
import 'package:ignite_project_user_site/pages/project_details_page.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import '../providers/auth_provider.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Added controllers and state — UI kept identical
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  bool loading = false;
  bool showPassword = false;
  String? emailError;
  String? passError;

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = emailCtrl.text.trim();
    final password = passCtrl.text;
    if (email.isEmpty || !email.contains('@')) {
      setState(() => emailError = 'Please enter a valid email');
      return;
    }
    if (password.isEmpty || password.length < 6) {
      setState(() => passError = 'Password must be at least 6 characters');
      return;
    }
    setState(() => loading = true);
    try {
      final auth = context.read<AuthProvider>();
      final ok = await auth.login(emailCtrl.text.trim(), passCtrl.text.trim());
      setState(() => loading = false);
      if (!mounted) return;
      if (ok) {
        // Navigate to home preserving your navigation style
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ProjectDetailsPage()),
        );
      } else {
        final msg =
            context.read<AuthProvider>().lastError ??
            'Invalid email or password';
        final low = msg.toLowerCase();
        setState(() {
          if (low.contains('email')) {
            emailError = msg;
            passError = null;
          } else if (low.contains('password')) {
            passError = msg;
            emailError = null;
          } else {
            emailError = 'Check email';
            passError = 'Check password';
          }
        });
      }
    } catch (e) {
      setState(() => loading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _handleGoogleLogin() async {
    setState(() => loading = true);
    try {
      final auth = context.read<AuthProvider>();
      final ok = await auth.loginWithGoogle();
      setState(() => loading = false);
      if (!mounted) return;
      if (ok) {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
      } else {
        final msg =
            context.read<AuthProvider>().lastError ?? 'Google login failed';
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      }
    } catch (e) {
      setState(() => loading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGO'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            },
            child: const Text('Home'),
          ),
          TextButton(onPressed: () {}, child: const Text('Projects')),
          TextButton(onPressed: () {}, child: const Text('About us')),
          TextButton(onPressed: () {}, child: const Text('Products')),
          TextButton(onPressed: () {}, child: const Text('Contact')),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Log in'),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEAF4FF), Color(0xFFF6ECFF)],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 900;
                  final image = Image.asset(
                    'assets/login.svg.png',
                    fit: BoxFit.contain,
                  );

                  // Keep your UI exactly — replaced inner form with form wired to controllers
                  final form = Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Log in to your account',
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Welcome back! Please enter your details.',
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 20),
                          // Email field wired to controller
                          TextField(
                            controller: emailCtrl,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF1E6FE6),
                                ),
                              ),
                              errorText: emailError,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (_) => setState(() => emailError = null),
                          ),
                          const SizedBox(height: 12),
                          // Password field wired to controller
                          TextField(
                            controller: passCtrl,
                            obscureText: !showPassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF1E6FE6),
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () => setState(
                                  () => showPassword = !showPassword,
                                ),
                              ),
                              errorText: passError,
                            ),
                            onChanged: (_) => setState(() => passError = null),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              // keep checkboxes/defaults as they were
                              StatefulBuilder(
                                builder: (context, setStateSB) {
                                  bool remember = false;
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: remember,
                                        onChanged: (v) => setStateSB(
                                          () => remember = v ?? false,
                                        ),
                                      ),
                                      const Text('Remember for 30 days'),
                                    ],
                                  );
                                },
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const ForgotPasswordPage(),
                                    ),
                                  );
                                },
                                child: const Text('Forgot password'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Sign in button — calls API
                          SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: loading ? null : _handleLogin,
                              child: loading
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text('Sign in'),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 44,
                            child: OutlinedButton(
                              onPressed: loading ? null : _handleGoogleLogin,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: Image.asset(
                                      'assets/google_logo.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Flexible(
                                    child: Text(
                                      'Sign in with Google',
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account? "),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pushNamed('/signup'),
                                child: const Text('Sign up'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );

                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: image),
                        const SizedBox(width: 40),
                        SizedBox(width: 380, child: form),
                      ],
                    );
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 300, child: image),
                      const SizedBox(height: 24),
                      SizedBox(width: 380, child: form),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

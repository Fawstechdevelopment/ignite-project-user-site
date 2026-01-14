import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailCtrl = TextEditingController();
  bool loading = false;
  String? emailError;

  Future<void> _sendOtp() async {
    setState(() => loading = true);
    final auth = context.read<AuthProvider>();
    final ok = await auth.sendPasswordReset(emailCtrl.text.trim());
    setState(() => loading = false);
    if (!mounted) return;
    if (ok) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('OTP sent')));
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ResetPasswordPage(email: emailCtrl.text.trim()),
        ),
      );
    } else {
      final msg = auth.lastError ?? 'Failed to send OTP';
      setState(() => emailError = msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorText: emailError,
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (_) => setState(() => emailError = null),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: loading ? null : _sendOtp,
              child: const Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResetPasswordPage extends StatefulWidget {
  final String email;
  const ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController otpCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();
  bool loading = false;
  String? otpError;
  String? passError;

  Future<void> _reset() async {
    if (passCtrl.text.trim() != confirmCtrl.text.trim()) {
      setState(() => passError = 'Passwords do not match');
      return;
    }
    setState(() => loading = true);
    final auth = context.read<AuthProvider>();
    final ok = await auth.confirmPasswordReset(
      email: widget.email,
      otp: otpCtrl.text.trim(),
      newPassword: passCtrl.text.trim(),
    );
    setState(() => loading = false);
    if (!mounted) return;
    if (ok) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Password updated')));
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      final msg = auth.lastError ?? 'Failed to update password';
      setState(() {
        if (msg.toLowerCase().contains('otp')) {
          otpError = msg;
          passError = null;
        } else {
          passError = msg;
          otpError = null;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.email),
            const SizedBox(height: 12),
            TextField(
              controller: otpCtrl,
              decoration: InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorText: otpError,
              ),
              onChanged: (_) => setState(() => otpError = null),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorText: passError,
              ),
              onChanged: (_) => setState(() => passError = null),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmCtrl,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: loading ? null : _reset,
              child: const Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }
}

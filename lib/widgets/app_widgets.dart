// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Reusable AppBar for main pages
class IgniteAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final bool showLogo;

  const IgniteAppBar({Key? key, this.actions, this.showLogo = true})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: showLogo
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'IGNITE\nPROJECTS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            )
          : const SizedBox(),
      actions: actions,
      backgroundColor: Colors.white,
      foregroundColor: AppColors.darkText,
      elevation: 0.5,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Reusable input field wrapper
class AppTextField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int maxLines;
  final int? minLines;

  const AppTextField({
    Key? key,
    required this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.maxLines = 1,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
      decoration: getInputDecoration(labelText: labelText, hintText: hintText),
    );
  }
}

/// Summary row for checkout pages
class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const SummaryRow({
    Key? key,
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Reusable card container
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final Border? border;
  final Color backgroundColor;

  const AppCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.border,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: border,
        boxShadow: const [
          BoxShadow(
            color: Color(0x33858585),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Reusable button row for forms
class FormButtonRow extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onContinuePressed;
  final String continueLabel;
  final String backLabel;

  const FormButtonRow({
    Key? key,
    required this.onBackPressed,
    required this.onContinuePressed,
    this.continueLabel = 'Continue',
    this.backLabel = 'Back',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          child: OutlinedButton(
            onPressed: onBackPressed,
            child: Text(backLabel),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: onContinuePressed,
            child: Text(continueLabel),
          ),
        ),
      ],
    );
  }
}

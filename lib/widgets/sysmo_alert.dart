import 'package:flutter/material.dart';

/*
  @author     : akshayaa.p
  @date       : 16/05/2025
  @desc       : Reusable stateless widget to show an alert box with customizable:
                - Icon, text, colors and action button.
                - Used to display messages like success, failure, warning or error.
                - The button executes the provided onButtonPressed callback.
*/

class SysmoAlert extends StatelessWidget {
  final String message;
  final Color textColor;
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const SysmoAlert({
    super.key,
    required this.message,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.white,
    required this.iconColor,
    required this.icon,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: iconColor, size: 40),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor, fontSize: 25),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 3, 9, 110),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(buttonText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

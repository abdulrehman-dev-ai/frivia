import 'dart:ui';
import 'package:flutter/material.dart';

class GlassmorphismTheme {
  // Colors
  static const Color primaryColor = Color(0xFF6A1B9A); // Deep Purple
  static const Color secondaryColor = Color(0xFFFFAB00); // Amber
  static const Color accentColor = Color(0xFF2979FF); // Blue
  static const Color textPrimaryColor = Colors.white;
  static const Color textSecondaryColor = Color(0xFFE1E1E1);
  
  // Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6A1B9A), // Deep Purple
      Color(0xFF1A237E), // Indigo
    ],
  );
  
  static const LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x40FFFFFF), // Semi-transparent white
      Color(0x10FFFFFF), // More transparent white
    ],
  );
  
  // Border Radius
  static const double borderRadius = 16.0;
  static BorderRadius standardBorderRadius = BorderRadius.circular(borderRadius);
  static BorderRadius buttonBorderRadius = BorderRadius.circular(30.0);
  
  // Shadows
  static List<BoxShadow> containerShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 10,
      spreadRadius: 1,
      offset: const Offset(0, 4),
    ),
  ];
  
  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textPrimaryColor,
    letterSpacing: 1.2,
  );
  
  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: textSecondaryColor,
    letterSpacing: 0.5,
  );
  
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.8,
  );
  
  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16,
    color: textPrimaryColor,
  );
}

class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderRadius borderRadius;
  final double borderWidth;
  final Color borderColor;
  final double blur;
  final Gradient gradient;
  
  const GlassmorphicContainer({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height = double.infinity,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = EdgeInsets.zero,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.borderWidth = 1.5,
    this.borderColor = Colors.white30,
    this.blur = 10,
    this.gradient = GlassmorphismTheme.glassGradient,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: GlassmorphismTheme.containerShadow,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: borderRadius,
              border: Border.all(
                width: borderWidth,
                color: borderColor,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class GlassmorphicButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final double borderWidth;
  final Color borderColor;
  final double blur;
  final Gradient gradient;
  
  const GlassmorphicButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width = double.infinity,
    this.height = 56,
    this.padding = const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
    this.borderRadius = const BorderRadius.all(Radius.circular(30)),
    this.borderWidth = 1.5,
    this.borderColor = Colors.white30,
    this.blur = 5,
    this.gradient = GlassmorphismTheme.glassGradient,
  });
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: borderRadius,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius,
          border: Border.all(
            width: borderWidth,
            color: borderColor,
          ),
          boxShadow: GlassmorphismTheme.containerShadow,
        ),
        child: Center(child: child),
      ),
    );
  }
}
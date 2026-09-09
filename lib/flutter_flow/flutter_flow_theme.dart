import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App-wide design tokens for SINGnPLAY WorshipTime, structured the way a
/// FlutterFlow-exported project organizes its theme: pull colors and text
/// styles from `FlutterFlowTheme.of(context)` instead of hardcoding them
/// in widgets.
abstract class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) => WorshipTimeTheme();

  // Brand palette: deep indigo + coral + gold, warm cream background.
  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;

  late Color primaryText;
  late Color secondaryText;

  late Color primaryBackground;
  late Color secondaryBackground;

  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;

  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  TextStyle get displaySmall;
  TextStyle get headlineMedium;
  TextStyle get headlineSmall;
  TextStyle get titleLarge;
  TextStyle get titleMedium;
  TextStyle get bodyLarge;
  TextStyle get bodyMedium;
  TextStyle get bodySmall;
  TextStyle get labelMedium;
  TextStyle get labelSmall;
}

class WorshipTimeTheme extends FlutterFlowTheme {
  @override
  Color primary = const Color(0xFF5B3DF5);
  @override
  Color secondary = const Color(0xFFFF6B9D);
  @override
  Color tertiary = const Color(0xFFFFC857);
  @override
  Color alternate = const Color(0xFFEDE7FF);

  @override
  Color primaryText = const Color(0xFF241C3D);
  @override
  Color secondaryText = const Color(0xFF7A7392);

  @override
  Color primaryBackground = const Color(0xFFFFF8F0);
  @override
  Color secondaryBackground = const Color(0xFFFFFFFF);

  @override
  Color accent1 = const Color(0xFF4ECDC4);
  @override
  Color accent2 = const Color(0xFFFFE0B2);
  @override
  Color accent3 = const Color(0xFFFFD1DC);
  @override
  Color accent4 = const Color(0x1A5B3DF5);

  @override
  Color success = const Color(0xFF3BB273);
  @override
  Color warning = const Color(0xFFFFA726);
  @override
  Color error = const Color(0xFFE5525A);
  @override
  Color info = const Color(0xFF4ECDC4);

  @override
  TextStyle get displaySmall => GoogleFonts.poppins(
        color: primaryText,
        fontWeight: FontWeight.w700,
        fontSize: 28,
        height: 1.2,
      );

  @override
  TextStyle get headlineMedium => GoogleFonts.poppins(
        color: primaryText,
        fontWeight: FontWeight.w700,
        fontSize: 22,
      );

  @override
  TextStyle get headlineSmall => GoogleFonts.poppins(
        color: primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );

  @override
  TextStyle get titleLarge => GoogleFonts.poppins(
        color: primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );

  @override
  TextStyle get titleMedium => GoogleFonts.nunito(
        color: primaryText,
        fontWeight: FontWeight.w700,
        fontSize: 15,
      );

  @override
  TextStyle get bodyLarge => GoogleFonts.nunito(
        color: primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      );

  @override
  TextStyle get bodyMedium => GoogleFonts.nunito(
        color: secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );

  @override
  TextStyle get bodySmall => GoogleFonts.nunito(
        color: secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      );

  @override
  TextStyle get labelMedium => GoogleFonts.nunito(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 14,
      );

  @override
  TextStyle get labelSmall => GoogleFonts.nunito(
        color: secondaryText,
        fontWeight: FontWeight.w700,
        fontSize: 11,
      );
}

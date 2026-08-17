// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const designSize = Size(390, 844);

abstract class AppSizes {
  // Fonts
  static double get fontXs => 10.sp;
  static double get fontSm => 12.sp;
  static double get fontSmPlus => 13.sp;
  static double get fontMd => 14.sp;
  static double get fontLg => 16.sp;
  static double get fontLgPlus => 18.sp;
  static double get fontXl => 20.sp;
  static double get fontXxl => 24.sp;
  static double get fontXxlPlus => 26.sp;
  static double get fontXxxl => 28.sp;

  // Letter Spacing
  static double get letterSpacing1_2 => 1.2.w;
  static double get letterSpacing1_5 => 1.5.w;
  static double get letterSpacing2 => 2.w;

  // Paddings / Widths
  static double get borderSm => 1.w;
  static double get border1_5 => 1.5.w;
  static double get strokeWidth2 => 2.w;
  static double get strokeWidth2_5 => 2.5.w;
  static double get p4 => 4.w;
  static double get p8 => 8.w;
  static double get p12 => 12.w;
  static double get p14 => 14.w;
  static double get p16 => 16.w;
  static double get p20 => 20.w;
  static double get p24 => 24.w;

  // Widths
  static double get w8 => 8.w;
  static double get w12 => 12.w;
  static double get w16 => 16.w;

  // Heights
  static double get h4 => 4.h;
  static double get h6 => 6.h;
  static double get h8 => 8.h;
  static double get h10 => 10.h;
  static double get h12 => 12.h;
  static double get h14 => 14.h;
  static double get h16 => 16.h;
  static double get h20 => 20.h;
  static double get h24 => 24.h;
  static double get h28 => 28.h;
  static double get h32 => 32.h;
  static double get h36 => 36.h;
  static double get h48 => 48.h;

  // Radius
  static double get rSm => 4.r;
  static double get r8 => 8.r;
  static double get rMd => 8.r;
  static double get r10 => 10.r;
  static double get r12 => 12.r;
  static double get r14 => 14.r;
  static double get rLg => 16.r;
  static double get r18 => 18.r;
  static double get r20 => 20.r;
  static double get r22 => 22.r;
  static double get r24 => 24.r;
  static double get rXl => 24.r;
  static double get r32 => 32.r;

  // Icons / Avatars
  static double get iconSm => 16.r;
  static double get icon18 => 18.r;
  static double get icon20 => 20.r;
  static double get iconMd => 24.r;
  static double get iconLg => 32.r;
  static double get iconXl => 50.r;
  static double get iconXxl => 56.r;
  static double get icon64 => 64.r;
  static double get icon80 => 80.r;
  static double get icon84 => 84.r;
  static double get icon90 => 90.r;

  // Shadows
  static double get shadowBlurRadius => 10.r;
  static double get shadowBlurRadius16 => 16.r;
  static double get shadowOffset => 4.r;

  // QR Sizes
  static double get qrCardSize => 80.r; // Sanal kart üzerindeki mini QR
  static double get qrSmallSize => 140.r; // Bilet ekranı vb. için orta boy QR
  static double get qrLargeSize => 280.r; // Doğrulama ekranı için büyük QR

  //Cards
  static double get cardHeight => 220.h;

  // Line Heights
  static const double lineHeightCompact = 1.2;
  static const double lineHeightNormal = 1.3;
  static const double lineHeightRelaxed = 1.5;
}

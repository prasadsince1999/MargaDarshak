import 'package:flutter/material.dart';

/// Margadarshak Bauhaus shape, border, and hard-shadow tokens.
abstract final class AppShape {
  // Radius scale.
  static const double radiusNone = 0;
  static const double radiusXs = 2;
  static const double radiusSm = 4;
  static const double radiusMd = 8;
  static const double radiusFull = 999;

  // Temporary compatibility aliases.
  @Deprecated('Use radiusMd instead.')
  static const double radiusLg = radiusMd;

  @Deprecated('Use radiusMd instead.')
  static const double radiusXl = radiusMd;

  // Border scale.
  static const double borderThin = 1;
  static const double borderDefault = 2;
  static const double borderStrong = 4;

  @Deprecated('Use borderDefault or borderThin instead.')
  static const double borderWidthThin = borderDefault;

  @Deprecated('Use borderStrong instead.')
  static const double borderWidthThick = borderStrong;

  // Hard offset shadows. Normal cards use blurRadius 0.
  static const Offset shadowOffsetSm = Offset(3, 3);
  static const Offset shadowOffsetMd = Offset(6, 6);
  static const Offset shadowOffsetLg = Offset(8, 8);

  @Deprecated('Use shadowOffsetSm.dx or shadowOffsetSm.dy instead.')
  static const double shadowDistanceSm = 3;

  @Deprecated('Use shadowOffsetMd.dx or shadowOffsetMd.dy instead.')
  static const double shadowDistanceMd = 6;

  @Deprecated('Use shadowOffsetLg.dx or shadowOffsetLg.dy instead.')
  static const double graphicShadowDistance = 8;

  @Deprecated('Use shadowOffsetLg.dx or shadowOffsetLg.dy instead.')
  static const double heroShadowDistance = 8;

  static const BorderRadius borderRadiusNone = BorderRadius.all(
    Radius.circular(radiusNone),
  );
  static const BorderRadius borderRadiusXs = BorderRadius.all(
    Radius.circular(radiusXs),
  );
  static const BorderRadius borderRadiusSm = BorderRadius.all(
    Radius.circular(radiusSm),
  );
  static const BorderRadius borderRadiusMd = BorderRadius.all(
    Radius.circular(radiusMd),
  );
  static const BorderRadius borderRadiusFull = BorderRadius.all(
    Radius.circular(radiusFull),
  );

  @Deprecated('Use borderRadiusMd instead.')
  static const BorderRadius borderRadiusLg = borderRadiusMd;

  @Deprecated('Use borderRadiusMd instead.')
  static const BorderRadius borderRadiusXl = borderRadiusMd;

  static const BorderRadius borderRadiusSheet = BorderRadius.only(
    topLeft: Radius.circular(radiusMd),
    topRight: Radius.circular(radiusMd),
  );

  static const BorderRadius buttonRadius = borderRadiusSm;
  static const BorderRadius cardRadius = borderRadiusSm;
  static const BorderRadius inputRadius = borderRadiusXs;
  static const BorderRadius chipRadius = borderRadiusSm;
  static const BorderRadius dialogRadius = borderRadiusMd;

  static const double elevationNone = 0;
  static const double elevationCard = 0;
  static const double elevationHighlighted = 0;
  static const double elevationModal = 0;
}

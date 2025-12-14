import 'package:flutter/material.dart';

abstract class AppColors {
  // Border
  static const borderLowest = Color(0x26000000);
  static const borderPure = Color(0x80000000);

  // Fill
  static const fillMain = Colors.white;
  static const fillNeutralLowest = Color(0xFFF5F7F9);
  static const fillBackground = Color(0xFFFFFFFF);
  static const fillInteractionHighest = Color(0xFF000000);

  // Opacity
  static const opacityTransparent = 0.0;
  static const opacityLow = 0.1;
  static const opacityMediumLow = 0.2;
  static const opacityMedium = 0.5;

  // Interaction
  static final splashColor = fillMain.withValues(alpha: opacityMediumLow);
  static final highlightColor = fillMain.withValues(alpha: opacityLow);

  // Text
  static const textDisabled = Color(0x59000000);
  static const textSecondary = Color(0x99000000);

  // Base
  static const black = Color(0xFF000000);

  // Icon
  static const iconHighlight = Color(0xFF000824);

  // Brand
  static const primary = Color(0xFFDC0A2D);
  static const primaryDark = Color(0xFFD30A40);

  // Pokemon Types
  static const typeNormal = Color(0xFFA8A878);
  static const typeFire = Color(0xFFF08030);
  static const typeWater = Color(0xFF6890F0);
  static const typeElectric = Color(0xFFF8D030);
  static const typeGrass = Color(0xFF78C850);
  static const typeIce = Color(0xFF98D8D8);
  static const typeFighting = Color(0xFFC03028);
  static const typePoison = Color(0xFFA040A0);
  static const typeGround = Color(0xFFE0C068);
  static const typeFlying = Color(0xFFA890F0);
  static const typePsychic = Color(0xFFF85888);
  static const typeBug = Color(0xFFA8B820);
  static const typeRock = Color(0xFFB8A038);
  static const typeGhost = Color(0xFF705898);
  static const typeDragon = Color(0xFF7038F8);
  static const typeDark = Color(0xFF705848);
  static const typeSteel = Color(0xFFB8B8D0);
  static const typeFairy = Color(0xFFEE99AC);

  static Color getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return typeNormal;
      case 'fire':
        return typeFire;
      case 'water':
        return typeWater;
      case 'electric':
        return typeElectric;
      case 'grass':
        return typeGrass;
      case 'ice':
        return typeIce;
      case 'fighting':
        return typeFighting;
      case 'poison':
        return typePoison;
      case 'ground':
        return typeGround;
      case 'flying':
        return typeFlying;
      case 'psychic':
        return typePsychic;
      case 'bug':
        return typeBug;
      case 'rock':
        return typeRock;
      case 'ghost':
        return typeGhost;
      case 'dragon':
        return typeDragon;
      case 'dark':
        return typeDark;
      case 'steel':
        return typeSteel;
      case 'fairy':
        return typeFairy;
      default:
        return primaryDark;
    }
  }
}

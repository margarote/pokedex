import 'package:flutter/material.dart';

import '../../../../core/constants/api_constants.dart';
import '../../analytics/pokemon_analytics.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/header_section.dart';
import '../../../../core/widgets/positioned_image.dart';
import '../../../../core/widgets/type_chip.dart';
import '../../domain/entities/pokemon_entity.dart';
import 'item_card.dart';

class DetailDialog extends StatelessWidget {
  const DetailDialog({super.key, required this.pokemon});

  final PokemonEntity pokemon;

  static Future<void> show(BuildContext context, PokemonEntity pokemon) {
    PokemonAnalytics.logDetailScreen();
    return showDialog(
      context: context,
      builder: (_) => DetailDialog(pokemon: pokemon),
    );
  }

  bool get _hasEvolutions =>
      pokemon.prevEvolution != null || pokemon.nextEvolution != null;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.fillMain,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: AppDimens.md),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height *
              AppDimens.modalMaxHeightFactor,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              _buildHeader(context),
              const SizedBox(height: AppDimens.modalImageOffset),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.md),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    _buildAbilities(),
                    const SizedBox(height: AppDimens.lg),
                    _buildBaseStats(),
                    if (_hasEvolutions) ...[
                      const SizedBox(height: AppDimens.lg),
                      _buildEvolutions(),
                    ],
                    const SizedBox(height: AppDimens.md),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return HeaderSection(
      headerHeight: AppDimens.modalHeaderHeight,
      headerChild: Row(
        crossAxisAlignment: .start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  pokemon.name,
                  style: AppTypography.headlineLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.fillBackground,
                  ),
                ),
                const SizedBox(height: AppDimens.xs),
                Text(
                  '#${pokemon.number}',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.fillBackground,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.fillNeutralLowest,
            ),
          ),
        ],
      ),
      child: PositionedImage(
        imageUrl: pokemon.img,
        height: AppDimens.modalImageHeight,
        top: AppDimens.modalImageTop,
      ),
    );
  }

  Widget _buildAbilities() {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const Text(AppStrings.abilities, style: AppTypography.bodyMedium),
        const SizedBox(height: AppDimens.sm),
        Wrap(
          spacing: AppDimens.sm,
          runSpacing: AppDimens.sm,
          children: pokemon.type.map((type) => TypeChip(type: type)).toList(),
        ),
      ],
    );
  }

  Widget _buildBaseStats() {
    final stats = [
      (AppStrings.height, pokemon.height),
      (AppStrings.weight, pokemon.weight),
      (AppStrings.candy, pokemon.candy),
      (AppStrings.egg, pokemon.egg),
      (AppStrings.spawnChance, '${pokemon.spawnChance}%'),
      (AppStrings.spawnTime, pokemon.spawnTime),
    ];

    return Column(
      crossAxisAlignment: .start,
      children: [
        const Text(AppStrings.baseStats, style: AppTypography.bodyMedium),
        const SizedBox(height: AppDimens.sm),
        Container(
          padding: const EdgeInsets.all(AppDimens.md),
          decoration: BoxDecoration(
            color: AppColors.fillNeutralLowest,
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          ),
          child: Column(
            children: [
              for (var i = 0; i < stats.length; i++) ...[
                _buildStatRow(stats[i].$1, stats[i].$2),
                if (i < stats.length - 1) _buildDivider(),
              ],
              if (pokemon.candyCount != null) ...[
                _buildDivider(),
                _buildStatRow(
                  AppStrings.candyCount,
                  '${pokemon.candyCount}',
                  isHighlighted: true,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(
    String label,
    String value, {
    bool isHighlighted = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.sm),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: isHighlighted ? AppColors.black : AppColors.textSecondary,
              fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: AppTypography.bodySmall
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(color: AppColors.borderLowest, height: 1);
  }

  Widget _buildEvolutions() {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const Text(AppStrings.related, style: AppTypography.bodyMedium),
        const SizedBox(height: AppDimens.sm),
        Wrap(
          spacing: AppDimens.sm,
          runSpacing: AppDimens.sm,
          children: [
            ...?pokemon.prevEvolution?.map(_buildEvolutionCard),
            ...?pokemon.nextEvolution?.map(_buildEvolutionCard),
          ],
        ),
      ],
    );
  }

  Widget _buildEvolutionCard(PokemonEvolution evolution) {
    return SizedBox(
      width: AppDimens.pokemonCardWidth,
      child: ItemCard(
        name: evolution.name,
        number: int.tryParse(evolution.number) ?? 0,
        imageUrl: ApiConstants.getPokemonImageUrl(evolution.number),
      ),
    );
  }
}

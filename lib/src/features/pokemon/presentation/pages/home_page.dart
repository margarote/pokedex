import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/filter_chip_button.dart';
import '../../../../core/widgets/filter_icon_button.dart';
import '../../../../core/widgets/gradient_fade.dart';
import '../../../../core/widgets/header_content.dart';
import '../../../../core/widgets/header_section.dart';
import '../../../../core/widgets/positioned_image.dart';
import '../../../../injection_container.dart';
import '../../analytics/pokemon_analytics.dart';
import '../cubit/pokemon_list_cubit.dart';
import '../cubit/pokemon_list_state.dart';
import '../widgets/detail_dialog.dart';
import '../widgets/home_intro_section.dart';
import '../widgets/item_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PokemonAnalytics.logHomeScreen();
    return BlocProvider(
      create: (_) => injector.pokemonListCubit..loadPokemons(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryDark,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.fillBackground,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                HeaderSection(
                  headerChild: const HeaderContent(
                    title: AppStrings.appName,
                    icon: AppImages.ball,
                  ),
                  child: PositionedImage(
                    imageUrl: ApiConstants.getPokeApiImageUrl(
                      ApiConstants.homeHeaderPokemonId,
                    ),
                    height: AppDimens.homeHeaderImageHeight,
                    top: AppDimens.homeHeaderImageTop,
                  ),
                ),
                const SizedBox(height: AppDimens.homeHeaderImageOffset),
                const GradientFade(),
                const HomeIntroSection(
                  title: AppStrings.exploreTitle,
                  subtitle: AppStrings.exploreSubtitle,
                  highlightText: AppStrings.highlightCount,
                  highlightLabel: AppStrings.highlightLabel,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.md,
                    vertical: AppDimens.xl,
                  ),
                  child: AppTextField(
                    hintText: AppStrings.searchHint,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(AppDimens.md),
                      child: SvgPicture.asset(
                        AppIcons.search,
                        colorFilter: const ColorFilter.mode(
                          AppColors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    showBackButton: true,
                    showClearButton: true,
                    showBorderOnFocus: true,
                    onChanged: (query) {
                      context.read<PokemonListCubit>().searchPokemons(query);
                      PokemonAnalytics.logSearch(query);
                    },
                  ),
                ),
                const _FilterSection(),
                const SizedBox(height: AppDimens.lg),
                const _ItemGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonListCubit, PokemonListState>(
      buildWhen: (previous, current) => previous.sortType != current.sortType,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.md),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterIconButton(
                  icon: AppIcons.filter,
                  onTap: () => _showFilterSnackbar(context),
                ),
                const SizedBox(width: AppDimens.md),
                FilterChipButton(
                  label: AppStrings.sortAlphabetical,
                  isSelected: state.sortType == PokemonSortType.alphabetical,
                  onTap: () =>
                      _setSortType(context, PokemonSortType.alphabetical),
                ),
                const SizedBox(width: AppDimens.sm),
                FilterChipButton(
                  label: AppStrings.sortById,
                  isSelected: state.sortType == PokemonSortType.byId,
                  onTap: () => _setSortType(context, PokemonSortType.byId),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFilterSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.filterNotImplemented),
        duration: Duration(seconds: AppDimens.snackbarDurationSeconds),
      ),
    );
  }

  void _setSortType(BuildContext context, PokemonSortType sortType) {
    context.read<PokemonListCubit>().setSortType(sortType);
  }
}

class _ItemGrid extends StatelessWidget {
  const _ItemGrid();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonListCubit, PokemonListState>(
      builder: (context, state) {
        return switch (state.status) {
          PokemonListStatus.loading => _buildLoading(),
          PokemonListStatus.failure => _buildError(context, state),
          _ => _buildContent(context, state),
        };
      },
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimens.xl),
        child: CircularProgressIndicator(color: AppColors.primaryDark),
      ),
    );
  }

  Widget _buildError(BuildContext context, PokemonListState state) {
    return ErrorState(
      title: AppStrings.errorTitle,
      subtitle: state.errorMessage ?? AppStrings.errorLoadingPokemons,
      onRetry: () => context.read<PokemonListCubit>().loadPokemons(),
    );
  }

  Widget _buildContent(BuildContext context, PokemonListState state) {
    final pokemons = state.filteredPokemons;

    if (pokemons.isEmpty) {
      return const EmptyState(
        icon: Icons.catching_pokemon_outlined,
        title: AppStrings.emptyTitle,
        subtitle: AppStrings.emptySubtitle,
      );
    }

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppDimens.md),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: AppDimens.gridCrossAxisCount,
            mainAxisSpacing: AppDimens.md,
            crossAxisSpacing: AppDimens.md,
            childAspectRatio: AppDimens.pokemonCardAspectRatio,
          ),
          itemCount: pokemons.length,
          itemBuilder: (context, index) {
            final pokemon = pokemons[index];
            return ItemCard(
              name: pokemon.name,
              number: pokemon.id,
              onTap: () {
                PokemonAnalytics.logPokemonSelected(pokemon.id, pokemon.name);
                DetailDialog.show(context, pokemon);
              },
              imageUrl: pokemon.img,
              searchText: state.searchQuery,
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(AppDimens.lg),
          child: Text(
            AppStrings.allPokemonsLoaded(pokemons.length),
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textDisabled,
            ),
          ),
        ),
      ],
    );
  }
}

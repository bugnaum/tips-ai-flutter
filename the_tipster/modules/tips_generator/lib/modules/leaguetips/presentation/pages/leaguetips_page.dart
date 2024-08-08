import 'package:design_system/components/cardpagecontrol/cardpagecontrol_component.dart';
import 'package:design_system/components/gamecell/gamecell_component.dart';
import 'package:design_system/components/primaryheader/primaryheader_component.dart';
import 'package:design_system/components/secondaryheader/secondaryheader_component.dart';
import 'package:design_system/theme/the_tipster_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_generator/modules/leaguetips/data/models/next_game_model.dart';

import '../../domain/usecases/leaguetips_usecase.dart';
import '../blocs/leaguetips_bloc.dart';

class LeagueTipsPage extends StatelessWidget {
  const LeagueTipsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LeagueTipsBloc(getLeagueTips: context.read<GetLeagueTips>()),
      child: const LeagueTipsView(),
    );
  }
}

class LeagueTipsView extends StatelessWidget {
  const LeagueTipsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of().primaryBackground,
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: BlocBuilder<LeagueTipsBloc, LeagueTipsState>(
        builder: (context, state) {
          if (state is LeagueTipsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LeagueTipsLoaded) {
            return _buildSuccess(state);
          } else if (state is LeagueTipsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(
              child: Text('Press the button to load LeagueTips'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<LeagueTipsBloc>().loadLeagueTips(),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildSuccess(LeagueTipsLoaded state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          children: [
            const PrimaryHeaderComponent(
              title: 'Tips grátis da rodada',
            ),
            CardPageControlComponent(
              dtoList: state.freeTipsDTO,
            ),
            ...state.round.map((round) => _buildRound(round)),
          ],
        ),
      ),
    );
  }

  Widget _buildRound(NextGame round) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SecondaryHeaderComponent(
          title: round.round ?? '',
        ),
        ...round.games
                ?.map(
                  (game) => GameCellComponent(
                    dtoElement: GameCellComponentDTO.fromJson(
                      game.toJson(),
                    ),
                  ),
                )
                .toList() ??
            [],
      ],
    );
  }
}

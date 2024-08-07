import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: BlocBuilder<LeagueTipsBloc, LeagueTipsState>(
        builder: (context, state) {
          if (state is LeagueTipsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LeagueTipsLoaded) {
            final leaguetips = state.leaguetips;
            return Center(child: Text('Home: ${leaguetips.toString()}'));
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
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/{{fileModuleName}}_bloc.dart';
import '../../data/models/{{fileModuleName}}_model.dart';
import '../../domain/usecases/{{fileModuleName}}_usecase.dart';

class {{moduleName}}Page extends StatelessWidget {
  const {{moduleName}}Page({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => {{moduleName}}Bloc(get{{moduleName}}: context.read<Get{{moduleName}}>()),
      child: const {{moduleName}}View(),
    );
  }
}

class {{moduleName}}View extends StatelessWidget {
  const {{moduleName}}View({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: BlocBuilder<{{moduleName}}Bloc, {{moduleName}}State>(
        builder: (context, state) {
          if (state is {{moduleName}}Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is {{moduleName}}Loaded) {
          final {{fileModuleName}} = state.{{fileModuleName}};
            return Center(child: Text('Home: ${{{fileModuleName}}.toString()}'));
          } else if (state is {{moduleName}}Error) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Press the button to load {{moduleName}}'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<{{moduleName}}Bloc>().load{{moduleName}}(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

import 'dart:io';

import 'package:path/path.dart' as path;

void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart main.dart <command> [options]');
    return;
  }

  final command = args[0];
  final moduleName = args.length > 1 ? args[1] : null;

  switch (command) {
    case 'module':
      if (moduleName == null) {
        print('Usage: dart main.dart create <module_name>');
      } else {
        createModule(moduleName);
      }
      break;
    case 'component':
      if (moduleName == null) {
        print('Usage: dart main.dart create <module_name>');
      } else {
        createComponent(moduleName);
      }
      break;
    case 'help':
      print('Available commands:');
      print('  create <module_name>   Create a new module');
      break;
    default:
      print('Unknown command: $command');
      break;
  }
}

final currentScriptPath = Platform.script.toFilePath();

final currentDirectory = path.dirname(
  path.fromUri(
    Uri.file(currentScriptPath),
  ),
);

final templatesDirectory = path.normalize(
  path.join(currentDirectory, '..', '..', '..', '..', 'lib', 'templates'),
);

void createComponent(String componentName) {
  try {
    final moduleDirectory = Directory(
      path.join(
        Directory.current.path,
        componentName.toLowerCase(),
      ),
    );
    _createComponentStructure(
        moduleDirectory, templatesDirectory, componentName);
    print('Component structure for $componentName created successfully.');
  } catch (e) {
    print('Error creating component: $e');
  }
}

void createModule(String moduleName) {
  try {
    final moduleDirectory = Directory(
      path.join(
        Directory.current.path,
        moduleName.toLowerCase(),
      ),
    );
    _createModuleStructure(moduleDirectory, templatesDirectory, moduleName);
    print('Module structure for $moduleName created successfully.');
  } catch (e) {
    print('Error creating module: $e');
  }
}

void _createComponentStructure(
  Directory moduleDirectory,
  String templatesDirectory,
  String moduleName,
) {
  if (!moduleDirectory.existsSync()) {
    moduleDirectory.createSync(recursive: true);
  }
  _copyComponentTemplateFiles(moduleName, templatesDirectory, moduleDirectory);
}

void _createModuleStructure(
  Directory moduleDirectory,
  String templatesDirectory,
  String moduleName,
) {
  if (!moduleDirectory.existsSync()) {
    moduleDirectory.createSync(recursive: true);
  }

  // Define directories
  final dataDirectory = Directory(path.join(moduleDirectory.path, 'data'));
  final domainDirectory = Directory(path.join(moduleDirectory.path, 'domain'));
  final presentationDirectory =
      Directory(path.join(moduleDirectory.path, 'presentation'));

  // Create subdirectories
  _createDirectories([dataDirectory, domainDirectory, presentationDirectory]);

  // Create subdirectories within data and domain
  final dataSubdirectories = [
    Directory(path.join(dataDirectory.path, 'datasources')),
    Directory(path.join(dataDirectory.path, 'models')),
    Directory(path.join(dataDirectory.path, 'repositories')),
  ];

  final domainSubdirectories = [
    Directory(path.join(domainDirectory.path, 'entities')),
    Directory(path.join(domainDirectory.path, 'repositories')),
    Directory(path.join(domainDirectory.path, 'usecases')),
    Directory(path.join(domainDirectory.path, 'providers')),
  ];

  _createDirectories(dataSubdirectories);
  _createDirectories(domainSubdirectories);

  // Copy template files to respective directories
  _copyTemplateFiles(moduleName, templatesDirectory, moduleDirectory);
}

void _createDirectories(List<Directory> directories) {
  for (var directory in directories) {
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
  }
}

void _copyTemplateFiles(
    String moduleName, String templatesDirectory, Directory moduleDirectory) {
  final fileModuleName = moduleName.toLowerCase();
  final filesToCreate = [
    {
      'source': 'repository_impl.dart',
      'destination': path.join(
          'data', 'repositories', '${fileModuleName}_repository_impl.dart')
    },
    {
      'source': 'model.dart',
      'destination': path.join('data', 'models', '${fileModuleName}_model.dart')
    },
    {
      'source': 'repository.dart',
      'destination': path.join(
          'domain', 'repositories', '${fileModuleName}_repository.dart')
    },
    {
      'source': 'usecase.dart',
      'destination':
          path.join('domain', 'usecases', '${fileModuleName}_usecase.dart')
    },
    {
      'source': 'providers.dart',
      'destination':
          path.join('domain', 'providers', '${fileModuleName}_providers.dart')
    },
    {
      'source': 'bloc.dart',
      'destination':
          path.join('presentation', 'blocs', '${fileModuleName}_bloc.dart')
    },
    {
      'source': 'page.dart',
      'destination':
          path.join('presentation', 'pages', '${fileModuleName}_page.dart')
    },
  ];

  for (var file in filesToCreate) {
    final templatePath = path.join(templatesDirectory, file['source']);
    final destinationPath =
        path.join(moduleDirectory.path, file['destination']);

    final templateFile = File(templatePath);
    final destinationFile = File(destinationPath);

    if (!destinationFile.existsSync()) {
      destinationFile.createSync(recursive: true);
      final templateContent = templateFile.readAsStringSync();
      final updatedContent =
          templateContent.replaceAll('{{moduleName}}', moduleName);
      final updatedContentWithImport =
          updatedContent.replaceAll('{{fileModuleName}}', fileModuleName);

      destinationFile.writeAsStringSync(updatedContentWithImport);
    }
  }
}

void _copyComponentTemplateFiles(
    String moduleName, String templatesDirectory, Directory moduleDirectory) {
  final fileModuleName = moduleName.toLowerCase();
  final file = {
    'source': 'component.dart',
    'destination': path.join('${fileModuleName}_component.dart')
  };

  final templatePath = path.join(templatesDirectory, file['source']);
  final destinationPath = path.join(moduleDirectory.path, file['destination']);

  final templateFile = File(templatePath);
  final destinationFile = File(destinationPath);

  if (!destinationFile.existsSync()) {
    destinationFile.createSync(recursive: true);
    final templateContent = templateFile.readAsStringSync();
    final updatedContent =
        templateContent.replaceAll('{{moduleName}}', moduleName);
    final updatedContentWithImport =
        updatedContent.replaceAll('{{fileModuleName}}', fileModuleName);

    destinationFile.writeAsStringSync(updatedContentWithImport);
  }
}

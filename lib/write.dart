  import 'dart:io';

Future<void> _incrementCounter() async {
    final directory = Platform.resolvedExecutable;
    final cd = directory.trim().split("fpga_matrix_multiplier.exe")[0];
    print(cd);
    final File file = File('${cd}out.txt');
    await file.writeAsString('');
    for (var i = 0; i < 5; i++) {
      await file.writeAsString('$i\n', mode: FileMode.append);
    }
  }

import 'package:flutter/material.dart';
import 'package:adaptive_design_widgets/adaptive_design_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DesignAncestor(
        initialDesignSystem: DesignSystem.material,
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            StatefulBuilder(builder: (context, setState) {
              DesignSystem system = DesignSystem.of(context);
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    key: const ValueKey('Refresh'),
                    onTap: () {
                      setState(() {});
                    },
                    child: const Icon(Icons.refresh),
                  ),
                  Text(
                    'Direct Access: Design system is ${system.name}',
                  ),
                ],
              );
            }),
            ValueListenableBuilder(
              valueListenable: DesignAncestor.valueNotifierOf(context),
              builder: (
                context,
                value,
                child,
              ) {
                return Text('Design System is ${value.name}');
              },
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: List<TextButton>.generate(
                DesignSystem.values.length,
                (index) => TextButton(
                  key: ValueKey<DesignSystem>(DesignSystem.values[index]),
                  onPressed: () {
                    DesignAncestor.setDesignSystemOf(
                        context, DesignSystem.values[index]);
                  },
                  child: Text(DesignSystem.values[index].name),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

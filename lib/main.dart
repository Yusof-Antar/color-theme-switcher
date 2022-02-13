import 'package:color_changer/color_changer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => ColorChanger(
                  primary: prefs.getInt('Primary') ?? Colors.teal.value,
                  secondary: prefs.getInt('Secondary') ?? Colors.amber.value,
                ))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorChanger>(builder: (context, colorChanger, _) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Color(colorChanger.getPrimary),
                secondary: Color(colorChanger.getSecondary),
              ),
        ),
        home: const MyHomePage(),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Color _selectedPrimaryColor;
  late Color _selectedSecondaryColor;

  @override
  Widget build(BuildContext context) {
    ColorChanger colorChanger = Provider.of<ColorChanger>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Color Changer"),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Flexible(
                  child: Text(
                    "Primary Color",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                TextButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              icon: const Icon(Icons.check),
                            )
                          ],
                          content: SingleChildScrollView(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                              child: MaterialColorPicker(
                                circleSize: 50,
                                selectedColor: Color(colorChanger.getPrimary),
                                onColorChange: (Color color) {
                                  setState(() {
                                    _selectedPrimaryColor = color;
                                    colorChanger.changePrimaryColor(
                                        _selectedPrimaryColor.value);
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                  child: CircleAvatar(
                    child: const Icon(
                      Icons.color_lens,
                      color: Colors.white54,
                    ),
                    backgroundColor: Color(colorChanger.getPrimary),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Flexible(
                  child: Text(
                    "Secondary Color",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                TextButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              icon: const Icon(Icons.check),
                            )
                          ],
                          content: SingleChildScrollView(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                              child: MaterialColorPicker(
                                circleSize: 50,
                                selectedColor: Color(colorChanger.getSecondary),
                                onColorChange: (Color color) {
                                  setState(() {
                                    _selectedSecondaryColor = color;
                                    colorChanger.changePrimaryColor(
                                        _selectedSecondaryColor.value);
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                  child: CircleAvatar(
                    child: const Icon(
                      Icons.color_lens,
                      color: Colors.white54,
                    ),
                    backgroundColor: Color(colorChanger.getSecondary),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Container(
                    color: Theme.of(context).colorScheme.primary,
                    height: 150,
                    child: const Center(
                      child: Text(
                        "Primary",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    color: Theme.of(context).colorScheme.secondary,
                    height: 150,
                    child: const Center(
                      child: Text(
                        "Secondary",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// THANK YOU SO MUCH <3

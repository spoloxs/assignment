import 'package:assignment/bloc/widgets_bloc.dart';
import 'package:assignment/widgets_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

bool _checkboxValue1 = false;
bool _checkboxValue2 = false;
bool _checkboxValue3 = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MultiBlocProvider(providers: [BlocProvider<WidgetBloc>(
      create: (context) {
        WidgetBloc widgetBloc = WidgetBloc();
        return(
          widgetBloc
        );
      })], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Assignment App",
      home: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(
        child: Text(
                "Assignment App",
                style: TextStyle(fontSize: 40),
              ),
      ),),
        body: Column(children: [
          const Spacer(),
          Center(
            child: Container(
                color: Colors.black12,
                width: MediaQuery.of(context).size.width - 50,
                height: MediaQuery.of(context).size.height - 200,
                child: const WidgetsScreen()),
          ),
              const Spacer(),
          FloatingActionButton.extended(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                content: DialogBoxOptions(),
              ),
            ),
            label: const Text("Add Widgets"),
          ),
          const Spacer()
        ]),
      );
  }
}

class DialogBoxOptions extends StatefulWidget{
  const DialogBoxOptions({super.key});
  @override
  State<StatefulWidget> createState() => _DialogBoxOptions();

}

class _DialogBoxOptions extends State<DialogBoxOptions>{

  _DialogBoxOptions();
  @override
  Widget build(BuildContext context) {
    return 
    SizedBox(
      height: 250,
      child: Column(
        children: [
          CheckboxListTile(
            value: _checkboxValue1,
          title: const Text("Text Widget"), 
          onChanged: (bool? value) { 
            setState(() {
              _checkboxValue1 = value!;
            });
           },
          ),
          CheckboxListTile(
            value: _checkboxValue2,
          title: const Text("Image Widget"), 
          onChanged: (bool? value) { 
            setState(() {
              _checkboxValue2 = value!;
            });
           },
          ),
          CheckboxListTile(
            value: _checkboxValue3,
          title: const Text("Button Widget"), 
          onChanged: (bool? value) { 
            setState(() {
              _checkboxValue3 = value!;
            });
           },
          ),
          const Spacer(),
          FloatingActionButton.extended(
            label: const Text("Import Widgets"),
            onPressed: ()
            {
              BlocProvider.of<WidgetBloc>(context).
              unlockWidget(_checkboxValue1,
                _checkboxValue2,
                _checkboxValue3);
              Navigator.pop(context);
            }
             )]
      ),
    );
  }
}
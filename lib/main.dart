import 'package:flutter/material.dart';
import 'package:hola/Equipo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo de tienda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Tienda de equipos'),
    );
  }
}

// FUNCION PARA CREAR UN FORMULARIO
void _showFormDialog(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  String? name;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Formulario'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre de Equipo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
              ),
              // Puedes agregar más campos aquí
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo
            },
          ),
          TextButton(
            child: Text('Aceptar'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Aquí puedes usar el valor del formulario
                print('Nombre ingresado: $name');
                Navigator.of(context).pop(); // Cierra el diálogo
              }
            },
          ),
        ],
      );
    },
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// CREACION DEL LISTVIEW
Widget _buildItem(Equipo equipo) {
  return new ListTile(
    title: new Text(equipo.name),
    subtitle: new Text('Precio: ${equipo.precio}'),
    leading: new Icon(Icons.map),
    onTap: () {
      print(equipo.name);
    },
  );
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: new ListView(
        //LLAMADO DEL LISTVIEW
        children: equipos.map(_buildItem).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context); //LLAMADO DEL FORMULARIO
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Clase Persona con nombre, apellido y cuenta
class Persona {
  final String nombre;
  final String apellido;
  final int cuenta;

  Persona(this.nombre, this.apellido, this.cuenta);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de alumnos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MyHomePage(title: 'Lista de alumnos'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Persona> _personas = [
    Persona("Raúl", "Santos", 20101234),
    Persona("Mariana", "Hernández", 20104567),
    Persona("Jorge", "Ramírez", 20107890),
    Persona("Claudia", "López", 20105678),
    Persona("Héctor", "González", 20103456),
    Persona("Laura", "Castillo", 20109876),
    Persona("Fernando", "Ortega", 20102345),
    Persona("Andrea", "Silva", 20106543),
    Persona("Ricardo", "Mendoza", 20108765),
    Persona("Sofía", "Díaz", 20104321),
  ];

  void _agregarPersona() {
    setState(() {
      _personas.add(Persona("Nuevo", "Apellido", 999));
    });
  }

  void _eliminarPersona(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final persona = _personas[index];
        return AlertDialog(
          title: const Text("Eliminar persona"),
          content: Text("¿Estás seguro de eliminar a: ${persona.nombre}?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Borrar", style: TextStyle(color: Colors.red)),
              onPressed: () {
                setState(() {
                  _personas.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _personas.length,
        itemBuilder: (context, index) {
          final persona = _personas[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                persona.nombre[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text('${persona.nombre} ${persona.apellido}'),
            subtitle: Text('${persona.cuenta}'),
            trailing: IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () => _eliminarPersona(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarPersona,
        backgroundColor: Colors.green,
        tooltip: 'Agregar Persona',
        child: const Icon(Icons.person_add),
      ),
    );
  }
}

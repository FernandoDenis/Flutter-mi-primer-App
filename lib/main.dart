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

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _cuentaController = TextEditingController();

  // Método para mostrar el formulario de agregar persona
  void _mostrarFormularioAgregarPersona() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar persona'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _apellidoController,
                decoration: const InputDecoration(labelText: 'Apellido'),
              ),
              TextField(
                controller: _cuentaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Cuenta'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
            ),
            TextButton(
              child: const Text('Agregar'),
              onPressed: () {
                _agregarPersona();
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  // Método para agregar una persona a la lista con los datos del formulario
  void _agregarPersona() {
    final String nombre = _nombreController.text;
    final String apellido = _apellidoController.text;
    final int? cuenta = int.tryParse(_cuentaController.text);

    if (nombre.isNotEmpty && apellido.isNotEmpty && cuenta != null) {
      setState(() {
        _personas.add(Persona(nombre, apellido, cuenta));
      });
      _nombreController.clear();
      _apellidoController.clear();
      _cuentaController.clear();
    }
  }

  // Método para mostrar el diálogo de confirmación de eliminación
  void _eliminarPersona(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar persona'),
          content:
              Text('¿Estás seguro de eliminar a: ${_personas[index].nombre}?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
            ),
            TextButton(
              child: const Text('Borrar', style: TextStyle(color: Colors.red)),
              onPressed: () {
                setState(() {
                  _personas.removeAt(index); // Eliminar la persona de la lista
                });
                Navigator.of(context).pop(); // Cerrar el diálogo
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
              onPressed: () {
                _eliminarPersona(
                    index); // Mostrar diálogo para eliminar persona
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarFormularioAgregarPersona,
        backgroundColor: Colors.green,
        tooltip: 'Agregar Persona',
        child: const Icon(Icons.person_add),
      ),
    );
  }
}

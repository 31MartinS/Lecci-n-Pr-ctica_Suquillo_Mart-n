import 'package:flutter/material.dart';
import '../logica/promedio.dart';

class Interfaz extends StatefulWidget {
  @override
  _InterfazState createState() => _InterfazState();
}

class _InterfazState extends State<Interfaz> {
  final List<Map<String, double>> listaTemperaturas = [];
  final TextEditingController controladorT1 = TextEditingController();
  final TextEditingController controladorT2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  double? promedioT1;
  double? promedioT2;

  void calcularPromediosFinales() {
    final promedios = calcularPromedios(listaTemperaturas);
    setState(() {
      promedioT1 = promedios[0];
      promedioT2 = promedios[1];
    });
  }

  void agregarTemperatura() {
    if (_formKey.currentState!.validate()) {
      final t1 = double.parse(controladorT1.text);
      final t2 = double.parse(controladorT2.text);

      setState(() {
        listaTemperaturas.add({'t1': t1, 't2': t2});
      });

      controladorT1.clear();
      controladorT2.clear();

      if (listaTemperaturas.length == 10) {
        calcularPromediosFinales();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promedio de Temperaturas'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ingrese las temperaturas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controladorT1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Temperatura T1',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese T1';
                      }
                      if (double.tryParse(value) == null) {
                        return 'T1 debe ser un número';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: controladorT2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Temperatura T2',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese T2';
                      }
                      if (double.tryParse(value) == null) {
                        return 'T2 debe ser un número';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: agregarTemperatura,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: Text('Agregar Temperaturas'),
            ),
            SizedBox(height: 16),
            if (promedioT1 != null && promedioT2 != null)
              Card(
                color: Colors.blue[50],
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Promedios Calculados',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Promedio de T1: ${promedioT1!.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Promedio de T2: ${promedioT2!.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: listaTemperaturas.length,
                itemBuilder: (context, index) {
                  final temperatura = listaTemperaturas[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Text((index + 1).toString()),
                      ),
                      title: Text(
                        'T1: ${temperatura['t1']} - T2: ${temperatura['t2']}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

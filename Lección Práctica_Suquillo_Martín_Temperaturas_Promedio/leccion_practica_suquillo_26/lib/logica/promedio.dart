List<double> calcularPromedios(List<Map<String, double>> temperaturas) {
  double sumaT1 = 0;
  double sumaT2 = 0;

  for (var temperatura in temperaturas) {
    sumaT1 += temperatura['t1']!;
    sumaT2 += temperatura['t2']!;
  }

  int cantidad = temperaturas.length;

  return [
    sumaT1 / cantidad, // Promedio de t1
    sumaT2 / cantidad, // Promedio de t2
  ];
}

import 'package:flutter/material.dart';
import 'package:myapp/widgets/drawer_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home View",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 90, 133, 207),
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const Image(
                height: 200, // Cambiado de 350 a 200
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlvfAfKXCHUgeX79aBMFyJT82VSETUe2cEtw&s"),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 15,
              ),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                "Ofrecer una gama completa de productos y servicios automotrices que cumplan los principios de calidad, seguridad, eficiencia, competitividad y economía para garantizar la habilitación integra del Sistema Airbag, incursionando además en la oferta de otros equipos, dispositivos y técnicas automotrices que permitan mejorar la seguridad, el confort y la experiencia que tienen nuestros clientes en el uso y conducción de sus vehículos.",
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                "Explora las opciones del menú 👌",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TODO Implement this library.
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("J.AAP.B.E")),
      body: GridView.count(
        padding: EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _MenuCard(
            icon: Icons.people,
            title: "Usuarios",
            onTap: () => Navigator.pushNamed(context, "/usuario/list"),
          ),
          _MenuCard(
            icon: Icons.water_damage,
            title: "Sectores",
            onTap: () => Navigator.pushNamed(context, "/sector/list"),
          ),
          _MenuCard(
            icon: Icons.electrical_services,
            title: "Medidores",
            onTap: () => Navigator.pushNamed(context, "/medidor/list"),
          ),
          _MenuCard(
            icon: Icons.analytics,
            title: "Lecturas",
            onTap: () => Navigator.pushNamed(context, "/lectura/list"),
          ),
          _MenuCard(
            icon: Icons.payment,
            title: "Pagos",
            onTap: () => Navigator.pushNamed(context, "/pago/list"),
          ),
          _MenuCard(
            icon: Icons.people_outline,
            title: "Reuniones",
            onTap: () => Navigator.pushNamed(context, "/asistencia/list"),
          ),
          _MenuCard(
            icon: Icons.event,
            title: "Eventos",
            onTap: () => Navigator.pushNamed(context, "/evento/list"),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Theme.of(context).primaryColor),
            SizedBox(height: 16),
            Text(title, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

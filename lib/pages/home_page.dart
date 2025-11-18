import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  final Widget child;
  const HomePage({required this.child, super.key});

  @override
  Widget build(BuildContext context) { // ici build souligne en rouge

    final String fullPath = GoRouterState.of(context).uri.path;

    int selectedIndex = 0;

    if (fullPath.startsWith('/profile')) {
      selectedIndex = 2;
    } else if (fullPath.startsWith('/report')) {
      selectedIndex = 1;
    } else {
      selectedIndex = 0;
    }
    return Scaffold(
      body: child,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/report');
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.map_outlined),
              color: selectedIndex == 0 ? Theme.of(context).colorScheme.primary : Colors.grey,
              onPressed: () => context.go('/home'),
            ),

            const SizedBox(width: 48),

            IconButton(
              icon: const Icon(Icons.person_outline),
              color: selectedIndex == 2 ? Theme.of(context).colorScheme.primary : Colors.grey,
              onPressed: () => context.go('/profile'),
            ),
            // Note: Le bouton Report n'est plus dans la barre, il est le FAB (+)
          ],
        ),
      ),
    );
  }
}
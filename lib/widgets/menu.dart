import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  MenuItem({Key? key}) : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
            child: Text('Main Menu'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            selected: ModalRoute.of(context)!.settings.name == 'homestack/home'
                ? true
                : false,
            title: const Text('หน้าหลัก'),
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.production_quantity_limits),
            selected:
                ModalRoute.of(context)!.settings.name == 'productstack/product'
                    ? true
                    : false,
            title: const Text('สินค้า'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil('/productstack', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

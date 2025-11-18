import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PrimaryDrawer extends StatelessWidget {
  const PrimaryDrawer({super.key});
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //drawer header
              DrawerHeader(
                child: Icon(
                  Icons.compass_calibration,
                  size: 100,
                  // color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              SizedBox(height: 24),
              // home tile
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: ListTile(
                  leading: Icon(
                    Icons.home_outlined,
                    // color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text("F E E D"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              //profile tile
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    // color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text("P R O F I L E"),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),
              //user tile
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: ListTile(
                  leading: Icon(
                    Icons.group,
                    // color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text("U S E R S"),
                  onTap: () {
                    Navigator.pushNamed(context, '/users_page');
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 24),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                // color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text("L O G O U T"),
              onTap: () {
                Navigator.pop(context);
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}

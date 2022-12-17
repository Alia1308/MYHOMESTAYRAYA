import 'package:flutter/material.dart';
import 'package:myhomestay_raya/models/user.dart';

class MainScreen extends StatefulWidget {
 const MainScreen({super.key, required User user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var colorScheme2 = Theme.of(context).colorScheme;
    return Scaffold(
          appBar: AppBar(title: const Text("Main Page")),
          body: const Center(child: Text("Main Page")),
          drawer: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountEmail:
                      const Text('test@gmail.com'), 
                  accountName : Row(
                    children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: const Icon(
                        Icons.check,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('user'),
                      const Text('@user'),
                    ],//<Widget>[]
                  ),
                  ],
                ),
              ),
              ListTile(
                title: const Text("Item1"),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Item2"),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Item3"),
                onTap: (){
                  Navigator.pop(context);
                },
              ),

              ],   
            ),
          ),
        );
  }  
}
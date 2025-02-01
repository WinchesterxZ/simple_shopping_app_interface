import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_interface/firebase_user_model.dart';

class UserRealTimeDisplay extends StatefulWidget {
  const UserRealTimeDisplay({super.key});

  @override
  State<UserRealTimeDisplay> createState() => _UserRealTimeDisplayState();
}

class _UserRealTimeDisplayState extends State<UserRealTimeDisplay> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(tr('users_list')),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data found'));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              // Convert document to UserModel
              final user =
                  UserModel.fromJson(document.data() as Map<String, dynamic>);

              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 5,
                child: ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: Card(
                      color: Colors.blue,
                      elevation: 5,
                      shape: CircleBorder(),
                      child: Center(
                        child: Text(
                          user.name[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name),
                      const SizedBox(width: 10),
                      Text(user.age),
                    ],
                  ),
                  subtitle: Text(user.phone),
                  trailing: Text(user.favoriteHobby),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

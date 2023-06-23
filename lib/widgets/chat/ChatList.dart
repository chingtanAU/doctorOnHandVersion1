import 'package:flutter/material.dart';
import 'chats.dart';
import 'const_chat.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    String time = "${DateTime.now().hour} : ${DateTime.now().minute}";
    String symbol = DateTime.now().hour < 12 ? "am" : "pm";
    return Scaffold(
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Chats(
                    profile: profiles[index],
                  );
                })),
            child: ListTile(
              leading: Hero(
                tag: profiles[index].hashCode,
                child: CircleAvatar(
                  radius: 30,

                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage(profiles[index].imgpath!),
                ),
              ),
              title: Text(
                profiles[index].name!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Hello I'm ${profiles[index].name}",
                overflow: TextOverflow.ellipsis,

                style: const TextStyle(
                  color: Colors.grey,

                ),
              ),

              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$time ${symbol.toUpperCase()}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Badge(
                    isLabelVisible: true,
                    largeSize: 20,

                    backgroundColor: Color.fromARGB(255, 0, 168, 132),
                    label: Text("3"),
                  ),

                ],
              ),
            ),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: const Color.fromARGB(255, 0, 168, 132),
      //   onPressed: () {},
      //   child: const Icon(Icons.message),
      // ),
    );
  }
}
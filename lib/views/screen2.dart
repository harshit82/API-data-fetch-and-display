import 'package:flutter/material.dart';
import 'package:zigy/services/fetcher.dart';

import '../model/people.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

Future fetchData() async {
  return await Fetcher(query: "users").getData();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            debugPrint("Snapshot Data = ${snapshot.data}");

            People people =
                People.fromJson(snapshot.data as Map<String, dynamic>);

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              shrinkWrap: false,
              itemCount: people.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return GridTile(
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                            child: Image.network(
                          people.data![index].avatar.toString(),
                          fit: BoxFit.cover,
                        )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${people.data![index].firstName} "),
                                  Text(people.data![index].lastName.toString()),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text(
                                  "${people.data![index].email}",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.cyanAccent[100]),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Text(
                                          "ID: ${people.data![index].id.toString()}"),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

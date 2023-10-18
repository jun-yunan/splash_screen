import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(MyGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter App"),
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() => Text(
                  "Counter: ${controller.count}",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              onPressed: () => controller.increment(),
              label: const Text("Increment"),
              icon: const Icon(Icons.add),
            ),
            ElevatedButton.icon(
              onPressed: () => controller.decrease(),
              label: const Text("Decreased"),
              icon: const Icon(Icons.add),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 300,
              height: 400,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black87,
                      blurRadius: 18,
                      offset: Offset(8, 4))
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Info Account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   height: 1,
                  //   color: Colors.black,
                  // ),
                  const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    // mainAxisAlignment: Mai.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text("Name: ${controller.person_nak['name']}")),
                      Obx(() => Text("Age: ${controller.person_nak['age']}")),
                      Text("Address: ${controller.person_nak['address']}"),
                      // Spacer(),
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                        onPressed: () => controller.incrementAge(),
                        icon: const Icon(Icons.edit),
                        label: const Text("Edit")),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: controller.increment,
      ),
    );
  }
}

class Person {
  final String id;
  final String name;
  final String age;
  final String address;

  Person({
    required this.id,
    required this.name,
    required this.age,
    required this.address,
  });

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        id: json["id"],
        name: json["name"],
        age: json["age"],
        address: json["address"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "age": age,
        "address": address,
      };
}

class MyGetController extends GetxController {
  var count = 0.obs;

  Map<String, dynamic> person_nak = {
    "id": 123,
    "name": "Nguyen Anh Kiet".obs,
    "age": 20.obs,
    "address": "Vinh Long"
  };

  incrementAge() {
    person_nak['age']++;
    person_nak['name'] = "fsdqqqfsf";
    print(person_nak["age"].runtimeType);
  }

  increment() => count++;
  decrease() => count--;

  updateInfo(Person person) => person_nak = person.toMap();
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit,
              size: 80,
              color: Colors.white,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

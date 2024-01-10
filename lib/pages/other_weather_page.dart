import 'package:flutter/material.dart';
import 'package:meteo_app/components/my_textfield.dart';

class OtherWeatherPage extends StatefulWidget {
  const OtherWeatherPage({super.key});

  @override
  State<OtherWeatherPage> createState() => _OtherWeatherPageState();
}

class _OtherWeatherPageState extends State<OtherWeatherPage> {

  // controller
  final TextEditingController _cityNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            MyTextField(hintText: "Type a city",obscureText: false,controller: _cityNameController),
            IconButton(onPressed: (){}, icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}

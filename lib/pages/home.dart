import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    // get data from intent extra
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;

    //set Background
    String bgImage = data["isDayTime"] ? "day.png" : "night.png";
    Color? bgColor = data["isDayTime"] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/$bgImage"),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    // similar to router in react and intent in kotlin android
                    // pushing activity to backstack

                    // getting the result/data from finishedActivity
                    // consider navigating to new activity as big asynchronous task, so we use async and await keyword
                    // similar with StartActivityForResult and overriding OnActivityResult in kotlin
                    dynamic result = await Navigator.pushNamed(context, "/location");
                    setState(() {
                      data = {
                        "time": result["time"],
                        "location": result["location"],
                        "flag": result["flag"],
                        "isDayTime": result["isDayTime"]
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    "Edit Location",
                    style: TextStyle(
                      color: Colors.grey[300]
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data["location"],
                      style: TextStyle(
                        fontSize: 28,
                        letterSpacing: 2,
                        color: Colors.white
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  data["time"],
                  style: TextStyle(
                    fontSize: 66,
                    color: Colors.white
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

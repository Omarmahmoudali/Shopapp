import 'package:flutter/material.dart';

class TeamName extends StatelessWidget {
  const TeamName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Team Name :-',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.red
                ),

              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Omar Mahmoud',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),

              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Ahmed Nassar',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),

              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Omar Alaa',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),

              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Mohamed Hisham',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),

              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Maha Dawa',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),

              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Manar Nazeeh',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),

              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),

    );
  }
}

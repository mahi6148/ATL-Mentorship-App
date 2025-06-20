import 'package:flutter/material.dart';


class AchievementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEEF1F5),
        appBar: AppBar(
          backgroundColor:  Colors.blue,
          title: const Text('Achievements',style: TextStyle(
            fontSize: 24,color: Colors.white
          ),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [

            const SizedBox(height: 20,),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset(
                  'assets/images/Achievements.png',
                  // width: double.infinity,
                ),

              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: Material(
            //     color: Colors.white,
            //     elevation: 4,
            //     child: ListTile(
            //       leading: const Icon(Icons.emoji_events_outlined),
            //       title: const Text('certificate of appreciation'),
            //       trailing: const Icon(Icons.download),
            //       onTap: () {
            //         // Add download logic
            //       },
            //     ),
            //   ),
            // ),

            const SizedBox(height: 20,),
            const Center(
                child: Text('Certificates not available yet.')
            )

          ],

        )
    );
  }
}
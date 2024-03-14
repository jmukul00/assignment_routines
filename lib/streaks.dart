import 'package:assignment/line_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Streaks extends StatelessWidget {
  const Streaks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Streaks",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Today's Goal: 3 streak days",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFf2e8eb),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Streak Days",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "3",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Daily Streak",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "3",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text("Last 30 Days ",
                      style: TextStyle(color: Color(0xff8f4c61), fontSize: 17)),
                  Text("+100%",
                      style: TextStyle(color: Colors.green, fontSize: 17))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            SizedBox(height: 200,
              child: LineChartSample2()
            ),
        
              const SizedBox(
                height: 20,
              ),
        
            const Text("Keep it up! You're on roll.",
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFf2e8eb)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    child: const Text("Get Started",
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

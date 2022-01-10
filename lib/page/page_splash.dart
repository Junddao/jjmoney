import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PageSplash extends StatefulWidget {
  const PageSplash({Key? key}) : super(key: key);

  @override
  _PageSplashState createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  @override
  void initState() {
    Future.microtask(() async {
      await readConfigFile();
      await Future.delayed(Duration(milliseconds: 2000), () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('PageHome', (route) => false);
      });
    });

    super.initState();
  }

  Future<void> readConfigFile() async {
    // final jobsJson = await rootBundle.loadString('assets/texts/jobs.json');
    // print(jobsJson);
    // final jobsObject = jsonDecode(jobsJson);
    // context.read<ProviderCompany>().getModelCompany(jobsObject);

    // final majorJson = await rootBundle.loadString('assets/texts/major.json');
    // print(majorJson);
    // final majorObject = jsonDecode(majorJson);
    // context.read<ProviderCompany>().getModelTeam(majorObject);

    // final schoolJson = await rootBundle.loadString('assets/texts/school.json');
    // print(schoolJson);
    // final schoolObject = jsonDecode(schoolJson);
    // context.read<ProviderCompany>().getModelSchool(schoolObject);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/money.png',
                width: size.width * 0.7,
              ),
              SizedBox(height: 50),
              Text(
                '미래 나의 자산은?',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

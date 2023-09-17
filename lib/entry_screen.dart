import 'package:flutter/material.dart';
import 'package:plant_sense_1/disease_classification.dart';

class Entry extends StatefulWidget {
  const Entry({super.key});

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/img4.jpeg',
            width: 200,
            // color: const Color.fromARGB(150, 255, 255, 255),
          ),
          const SizedBox(
            height: 70,
          ),
          const Text(
            'PLANT SENSE',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          const SizedBox(height: 30),
          FilledButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DiseaseClassification()),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('DISEASE CLASSIFICATION'),
          ),
        ],
      ),
    );
  }
}

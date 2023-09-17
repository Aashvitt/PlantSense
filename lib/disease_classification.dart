import 'package:flutter/material.dart';
import 'package:plant_sense_1/image_input.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class DiseaseClassification extends StatefulWidget {
  const DiseaseClassification({super.key});

  @override
  State<DiseaseClassification> createState() => _DiseaseClassificationState();
}

class _DiseaseClassificationState extends State<DiseaseClassification> {
  File? _selectedImage;
  List<dynamic>? classes = ['Image Not Selected'];
  List<dynamic>? scores = ['Please select an Image'];
  String? response;
  void infrenceModel() async {
    if (_selectedImage == null) {
      setState(() {
        classes = ['Image Not Selected'];
        scores = ['Please select an Image'];
      });
    } else {
      File file = _selectedImage!;

      // for local server
      // String addr = 'http://192.168.1.39:8080/';

      // for hosted api
      String addr = 'https://plant-sense-api.onrender.com/';

      Uri url = Uri.parse('${addr}api/test');
      String contentType = 'image/jpeg';

      Map<String, String> headers = {'content-type': contentType};

      Uint8List imgBytes = await file.readAsBytes();

      var res = await http.post(url, body: imgBytes, headers: headers);

      var jsonResponse = jsonDecode(res.body);
      if(res.statusCode == 200)
      {
        setState(() {
        scores = jsonResponse['score'];
        classes = jsonResponse['labels'];
      });
      }
      else
      {
        setState(() {
           scores = jsonResponse['Server is '];
           classes = jsonResponse['Down'];
        });
      }
      
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 127, 60, 39),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "DISEASE CLASSIFICATION",
              style: TextStyle(color: Colors.green, fontSize: 30),
            ),
            const SizedBox(
              height: 25,
            ),
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            FilledButton(
              onPressed: infrenceModel,
              style: FilledButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                'Find Possible Diseases',
                style: TextStyle(fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(
                      classes?[index] + '      ' + scores?[index],
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  );
                },
                itemCount: classes?.length,
                itemExtent: 50,
                scrollDirection: Axis.vertical,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

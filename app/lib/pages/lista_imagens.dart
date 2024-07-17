import 'dart:convert';
import 'package:app/infra/model/imagem.dart';
import 'package:app/infra/rfeign/imagem_feign.dart';
import 'package:app/pages/mapa.dart';
import 'package:flutter/material.dart';

class ListaImagensPage extends StatefulWidget {
  const ListaImagensPage({super.key, required this.title});

  final String title;

  @override
  State<ListaImagensPage> createState() => ListaImagensPageState();
}

class ListaImagensPageState extends State<ListaImagensPage> {
  late Future<List<Imagem>> _futureImageData;

  final ImagemFeign _feign = ImagemFeign();

  @override
  void initState() {
    super.initState();
    _futureImageData = _feign.fetchImageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Imagem>>(
        future: _futureImageData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final imageData = snapshot.data!.where((data) {
              // Check if all parameters are present and base64 can be converted
              try {
                base64Decode(data.imagem);
                return data.usuario != null &&
                    data.latitude != null &&
                    data.longitude != null;
              } catch (e) {
                // If base64 cannot be converted, exclude the image
                return false;
              }
            }).toList();

            return ListView.builder(
              itemCount: imageData.length,
              itemBuilder: (context, index) {
                final data = imageData[index];
                final bytes = base64Decode(data.imagem);
                return Card(
                  child: ListTile(
                    leading: Image.memory(bytes),
                    title: Text(data.usuario),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Latitude: ${data.latitude}'),
                        Text('Longitude: ${data.longitude}'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapaPage(
                            title: 'Mapa',
                            latitude: data.latitude,
                            longitude: data.longitude,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

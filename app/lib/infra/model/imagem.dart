class Imagem {
  final String usuario;
  final String imagem;
  final double latitude;
  final double longitude;

  Imagem({
    required this.usuario,
    required this.imagem,
    required this.latitude,
    required this.longitude,
  });

  // Function to convert JSON data to ImageData object
  factory Imagem.fromJson(Map<String, dynamic> json) {
    return Imagem(
      usuario: json['usuario'],
      imagem: json['imagem'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

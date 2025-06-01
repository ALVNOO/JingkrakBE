import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Order.dart';
import 'test_drive.dart';
import 'order_confirmation.dart';
import 'favorite_cars.dart';

class CarDetailPage extends StatefulWidget {
  final String carModel;
  final String carPrice;
  final String carImage;

  const CarDetailPage({
    Key? key,
    required this.carModel,
    required this.carPrice,
    required this.carImage,
  }) : super(key: key);

  @override
  State<CarDetailPage> createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  late YoutubePlayerController _youtubeController;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _initYoutube();
    _loadFavoriteStatus();
  }

  void _initYoutube() {
    const videoUrl = 'https://www.youtube.com/watch?v=jHvOqDgVxE8';
    final videoId = YoutubePlayer.convertUrlToId(videoUrl)!;
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorite_cars') ?? [];
    setState(() {
      _isFavorite = favorites.contains(widget.carModel);
    });
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorite_cars') ?? [];

    setState(() {
      if (_isFavorite) {
        favorites.remove(widget.carModel);
        _isFavorite = false;
      } else {
        favorites.add(widget.carModel);
        _isFavorite = true;
      }
    });

    await prefs.setStringList('favorite_cars', favorites);
    await prefs.setInt('favorite_count', favorites.length);
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: _toggleFavorite,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    widget.carImage,
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.3),
                    colorBlendMode: BlendMode.darken,
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.carModel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.carPrice,
                          style: TextStyle(
                            color: Colors.red[600],
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SPECIFICATIONS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ..._getCarSpecifications(widget.carModel),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TestDriveScreen(
                                  carModel: widget.carModel,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[900],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.grey[800]!),
                            ),
                          ),
                          child: const Text('BOOK TEST DRIVE'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PaymentScreen(
                                  carModel: widget.carModel,
                                  carPrice: widget.carPrice,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[800],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('ORDER NOW'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Review',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.red,
                          width: 4,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      'FITRA ERI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '1000PS',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'FIRST IMPRESSION',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.carModel.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: YoutubePlayer(
                      controller: _youtubeController,
                      showVideoProgressIndicator: true,
                      progressColors: const ProgressBarColors(
                        playedColor: Colors.red,
                        handleColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getCarSpecifications(String model) {
    final specs = <Map<String, String>>[];

    switch (model) {
      case 'Ferrari SF90 Stradale':
        specs.addAll([
          {'Engine': '4.0L V8 Twin-Turbo + 3 Electric Motors'},
          {'Power': '1000 PS (986 hp)'},
          {'0-100 km/h': '2.5 seconds'},
          {'Top Speed': '340 km/h'},
          {'Electric Range': '25 km'},
        ]);
        break;
      case 'Ferrari Roma':
        specs.addAll([
          {'Engine': '3.9L V8 Twin-Turbo'},
          {'Power': '620 PS (612 hp)'},
          {'0-100 km/h': '3.4 seconds'},
          {'Top Speed': '320 km/h'},
          {'Transmission': '8-Speed Dual-Clutch'},
        ]);
        break;
      default:
        specs.addAll([
          {'Engine': 'V8/V12 Engine'},
          {'Power': '600+ PS'},
          {'0-100 km/h': 'Under 3.5 seconds'},
          {'Top Speed': '320+ km/h'},
        ]);
    }

    return specs.map((spec) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                spec.keys.first,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            Expanded(
              child: Text(
                spec.values.first,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

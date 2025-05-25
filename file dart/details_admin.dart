import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CarDetailAdminPage extends StatefulWidget {
  final String carModel;
  final String carPrice;
  final String carImage;

  const CarDetailAdminPage({
    Key? key,
    required this.carModel,
    required this.carPrice,
    required this.carImage,
  }) : super(key: key);

  @override
  State<CarDetailAdminPage> createState() => _CarDetailAdminPageState();
}

class _CarDetailAdminPageState extends State<CarDetailAdminPage> {
  late YoutubePlayerController _youtubeController;
  List<Map<String, String>> _specifications = [];
  String _videoUrl = 'https://www.youtube.com/watch?v=jHvOqDgVxE8';

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    _specifications = _getCarSpecifications(widget.carModel);
    final videoId = YoutubePlayer.convertUrlToId(_videoUrl)!;
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  void _editSpecifications() async {
    TextEditingController specKeyController = TextEditingController();
    TextEditingController specValueController = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Add New Specification', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: specKeyController,
              decoration: const InputDecoration(
                labelText: 'Specification Title',
                labelStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            TextField(
              controller: specValueController,
              decoration: const InputDecoration(
                labelText: 'Specification Value',
                labelStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _specifications.add({
                  specKeyController.text: specValueController.text,
                });
              });
              Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  void _editVideoUrl() async {
    TextEditingController videoUrlController = TextEditingController(text: _videoUrl);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Edit Video URL', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: videoUrlController,
          decoration: const InputDecoration(
            labelText: 'YouTube Video URL',
            labelStyle: TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _videoUrl = videoUrlController.text;
                final newVideoId = YoutubePlayer.convertUrlToId(_videoUrl)!;
                _youtubeController.load(newVideoId);
              });
              Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Car Detail Admin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _editSpecifications,
            tooltip: 'Add Specification',
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editVideoUrl,
            tooltip: 'Edit Video',
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                widget.carImage,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.3),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
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
                  const SizedBox(height: 20),
                  const Text(
                    'SPECIFICATIONS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ..._specifications.map((spec) {
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
                  }).toList(),
                  const SizedBox(height: 30),
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

  List<Map<String, String>> _getCarSpecifications(String model) {
    switch (model) {
      case 'Ferrari SF90 Stradale':
        return [
          {'Engine': '4.0L V8 Twin-Turbo + 3 Electric Motors'},
          {'Power': '1000 PS (986 hp)'},
          {'0-100 km/h': '2.5 seconds'},
          {'Top Speed': '340 km/h'},
          {'Electric Range': '25 km'},
        ];
      case 'Ferrari Roma':
        return [
          {'Engine': '3.9L V8 Twin-Turbo'},
          {'Power': '620 PS (612 hp)'},
          {'0-100 km/h': '3.4 seconds'},
          {'Top Speed': '320 km/h'},
          {'Transmission': '8-Speed Dual-Clutch'},
        ];
      default:
        return [
          {'Engine': 'V8/V12 Engine'},
          {'Power': '600+ PS'},
          {'0-100 km/h': 'Under 3.5 seconds'},
          {'Top Speed': '320+ km/h'},
        ];
    }
  }
}

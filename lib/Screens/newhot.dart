import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Model/model.dart';
import '../utils/Animation_helper.dart';

class NewHotScreen extends StatefulWidget {
  final Movie movie;
  const NewHotScreen({super.key, required this.movie});

  @override
  State<NewHotScreen> createState() => _NewHotScreenState();
}

class _NewHotScreenState extends State<NewHotScreen> {
  bool isExpanded = false;

  Future<void> _launchTrailer() async {
    if (widget.movie.trailerKey != null) {
      try {
        final webUri = Uri.https(
          'www.youtube.com',
          '/watch',
          {'v': widget.movie.trailerKey},
        );

        if (await canLaunchUrl(webUri)) {
          await launchUrl(
            webUri,
            mode: LaunchMode.externalApplication,
          );
        } else {
          throw 'Could not launch trailer';
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to open trailer. Please try again later.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Movie Image
          SizedBox(
            height: size.height * 0.6,
            width: size.width,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: widget.movie.title,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.movie.backdropPath.isNotEmpty
                              ? widget.movie.backdropPath
                              : widget.movie.image,
                        ),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.8),
                        Colors.black,
                      ],
                      stops: const [0.0, 0.3, 0.5, 0.8, 1.0],
                    ),
                  ),
                ),
                if (widget.movie.trailerKey != null)
                  Center(
                    child: IconButton(
                      onPressed: _launchTrailer,
                      icon: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      iconSize: 60,
                    ),
                  ),
              ],
            ),
          ),

          // Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Spacer for image
                SizedBox(height: size.height * 0.5),

                // Movie Details
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeSlide(
                        child: Text(
                          widget.movie.title,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0, 1),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Rating and Release Date Row
                      FadeSlide(
                        delay: const Duration(milliseconds: 200),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 8),
                            Text(
                              widget.movie.rating,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (widget.movie.releaseDate.isNotEmpty) ...[
                              const SizedBox(width: 20),
                              Text(
                                widget.movie.releaseDate.substring(0, 4),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Description
                      FadeSlide(
                        delay: const Duration(milliseconds: 400),
                        child: Text(
                          widget.movie.desc,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Action Buttons
                      FadeSlide(
                        delay: const Duration(milliseconds: 600),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (widget.movie.trailerKey != null)
                              _buildActionButton(
                                icon: Icons.play_arrow,
                                label: 'Watch Trailer',
                                isPrimary: true,
                                onTap: _launchTrailer,
                              ),
                            _buildActionButton(
                              icon: isExpanded ? Icons.favorite : Icons.favorite_border,
                              label: isExpanded ? 'Added' : 'My List',
                              onTap: () => setState(() => isExpanded = !isExpanded),
                            ),
                            _buildActionButton(
                              icon: Icons.share,
                              label: 'Share',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Back Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    bool isPrimary = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isPrimary ? Colors.red : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

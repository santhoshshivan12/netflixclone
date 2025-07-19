import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            child: Column(
              children: [
                Image.network(
                  widget.movie.image,
                  height: size.height * 0.5,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: FadeSlide(
                                  child: Text(
                                    widget.movie.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  width: 50.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    color: isExpanded ? Colors.cyan : Colors.blue,
                                    borderRadius: BorderRadius.circular(isExpanded ? 30 : 10.0),
                                  ),
                                  child: Icon(
                                    isExpanded
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: isExpanded ? Colors.redAccent : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          FadeSlide(
                            delay: const Duration(milliseconds: 500),
                            child: Text(
                              widget.movie.desc,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Text(
                                "Check Out",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Back button
          Positioned(
            top: 40,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.4),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

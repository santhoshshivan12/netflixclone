import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflixclone/Screens/newhot.dart';
import '../Model/model.dart';
import '../utils/MovieService.dart';
import '../widgets/Webview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int current = 0;
  int currentPage = 1;
  bool isLoadingMore = false;
  List<Movie> movies = [];
  final PageController _pageController = PageController(viewportFraction: 0.7);

  @override
  void initState() {
    super.initState();
    fetchInitialMovies();
  }

  Future<void> fetchInitialMovies() async {
    final newMovies = await MovieService().fetchTopRatedMovies(page: currentPage);
    setState(() {
      movies = newMovies;
    });
  }

  Future<void> loadMoreMovies() async {
    if (isLoadingMore) return;

    setState(() => isLoadingMore = true);
    currentPage += 1;
    final newMovies = await MovieService().fetchTopRatedMovies(page: currentPage);

    setState(() {
      movies.addAll(newMovies);
      isLoadingMore = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: movies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          Image.network(
            movies[current].image,
            fit: BoxFit.cover,
          ),

          Container(
            height: size.height,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Webview()),
              ),
              child: const Icon(Icons.public, size: 50, color: Colors.redAccent),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: size.height * 0.7,
              child: PageView.builder(
                controller: _pageController,
                itemCount: movies.length,
                onPageChanged: (index) {
                  setState(() {
                    current = index;
                  });
                  if (index == movies.length - 1) {
                    loadMoreMovies();
                  }
                },
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  final isCurrent = index == current;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GestureDetector(
                      onTap: () => context.push('/new-hot', extra: movie),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Hero(
                              tag: movie.title,
                              child: Container(
                                height: 350,
                                width: size.width * 0.55,
                                margin: const EdgeInsets.only(top: 20),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.network(
                                  movie.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              movie.title,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 800),
                              opacity: isCurrent ? 1.0 : 0.0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.amber, size: 20),
                                        const SizedBox(width: 5),
                                        Text(
                                          movie.rating,
                                          style: const TextStyle(fontSize: 15, color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: const [
                                        Icon(Icons.play_circle, color: Colors.black, size: 20),
                                        SizedBox(width: 5),
                                        Text("Watch", style: TextStyle(fontSize: 15, color: Colors.black45)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (isLoadingMore)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}

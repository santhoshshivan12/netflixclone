import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/search_cubit.dart';
import '../Model/model.dart';
import '../utils/MovieService.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  final MovieService _movieService = MovieService();
  List<Genre> _genres = [];
  Genre? _selectedGenre;
  bool _isLoadingGenres = true;

  @override
  void initState() {
    super.initState();
    _searchFocus.requestFocus();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
    _loadGenres();
  }

  Future<void> _loadGenres() async {
    try {
      final genres = await _movieService.fetchGenres();
      setState(() {
        _genres = genres;
        _isLoadingGenres = false;
      });
    } catch (e) {
      print('Error loading genres: $e');
      setState(() => _isLoadingGenres = false);
    }
  }

  void _onSearch(String query) {
    final genreId = _selectedGenre?.id.toString();
    context.read<SearchCubit>().search(query, genreId: genreId);
  }

  void _onGenreSelected(Genre? genre) {
    setState(() => _selectedGenre = genre);
    _onSearch(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          focusNode: _searchFocus,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.red,
          decoration: InputDecoration(
            hintText: 'Search for movies...',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: Colors.white),
              onPressed: () {
                _searchController.clear();
                context.read<SearchCubit>().clearSearch();
              },
            ),
          ),
          onChanged: _onSearch,
        ),
      ),
      body: Column(
        children: [
          // Genre Filter
          if (!_isLoadingGenres && _genres.isNotEmpty)
            Container(
              height: 50,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + kToolbarHeight + 8,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _genres.length + 1, // +1 for "All" option
                itemBuilder: (context, index) {
                  final isAll = index == 0;
                  final genre = isAll ? null : _genres[index - 1];
                  final isSelected = isAll ? _selectedGenre == null : genre == _selectedGenre;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(
                        isAll ? 'All' : genre!.name,
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (_) => _onGenreSelected(genre),
                      backgroundColor: Colors.white.withOpacity(0.1),
                      selectedColor: Colors.white,
                      checkmarkColor: Colors.black,
                    ),
                  );
                },
              ),
            ),

          // Search Results
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 100, color: Colors.white.withOpacity(0.5)),
                        const SizedBox(height: 20),
                        Text(
                          'Search for your favorite movies',
                          style: TextStyle(color: Colors.white.withOpacity(0.5)),
                        ),
                        if (!_isLoadingGenres) ...[
                          const SizedBox(height: 20),
                          Text(
                            'Or browse by genre',
                            style: TextStyle(color: Colors.white.withOpacity(0.5)),
                          ),
                        ],
                      ],
                    ),
                  );
                }

                if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                }

                if (state is SearchError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red, size: 60),
                          const SizedBox(height: 16),
                          Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (state is SearchLoaded) {
                  if (state.results.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.movie_filter, size: 60, color: Colors.white.withOpacity(0.5)),
                          const SizedBox(height: 16),
                          Text(
                            'No results found for "${state.query}"${_selectedGenre != null ? ' in ${_selectedGenre!.name}' : ''}',
                            style: TextStyle(color: Colors.white.withOpacity(0.5)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: state.results.length,
                    itemBuilder: (context, index) {
                      final movie = state.results[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => context.push('/new-hot', extra: movie),
                            borderRadius: BorderRadius.circular(12),
                            child: Row(
                              children: [
                                Hero(
                                  tag: movie.title,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      movie.image,
                                      height: 150,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          height: 150,
                                          width: 100,
                                          color: Colors.grey[900],
                                          child: const Icon(Icons.error, color: Colors.white),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.amber, size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              movie.rating,
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(0.7),
                                              ),
                                            ),
                                            if (movie.releaseDate.isNotEmpty) ...[
                                              const SizedBox(width: 12),
                                              Text(
                                                movie.releaseDate.substring(0, 4),
                                                style: TextStyle(
                                                  color: Colors.white.withOpacity(0.7),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          movie.desc,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.7),
                                          ),
                                        ),
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
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

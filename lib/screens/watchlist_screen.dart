import 'package:flutter/material.dart';
import '../data/movies_data.dart';
import '../models/movie.dart';
import 'details_screen.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  Future<void> _openDetails(Movie movie) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailsScreen(movie: movie)),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final movies = sampleMovies.where((m) => m.isWatchlisted).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Watchlist',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: movies.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bookmark_border, size: 64),
                    SizedBox(height: 16),
                    Text(
                      'Your watchlist is empty',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Open a movie and tap the bookmark to save it for later.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white60, height: 1.5),
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: movies.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Card(
                  color: const Color(0xFF242424),
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        movie.posterPath,
                        width: 54,
                        height: 72,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      movie.title,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text('${movie.year} • ${movie.genre}'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _openDetails(movie),
                  ),
                );
              },
            ),
    );
  }
}

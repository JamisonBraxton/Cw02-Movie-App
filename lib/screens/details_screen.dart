import 'package:flutter/material.dart';
import '../models/movie.dart';

class DetailsScreen extends StatefulWidget {
  final Movie movie;

  const DetailsScreen({super.key, required this.movie});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Movie get movie => widget.movie;

  void _toggleWatchlist() {
    setState(() {
      movie.isWatchlisted = !movie.isWatchlisted;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            movie.isWatchlisted
                ? '${movie.title} added to your watchlist.'
                : '${movie.title} removed from your watchlist.',
          ),
          duration: const Duration(seconds: 1),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        actions: [
          IconButton(
            tooltip: movie.isWatchlisted
                ? 'Remove from Watchlist'
                : 'Add to Watchlist',
            onPressed: _toggleWatchlist,
            icon: Icon(
              movie.isWatchlisted ? Icons.bookmark : Icons.bookmark_border,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: movie.title,
              child: Image.asset(
                movie.posterPath,
                height: 390,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(label: Text('${movie.year}')),
                      Chip(label: Text(movie.genre)),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const _SectionTitle('Cast'),
                  const SizedBox(height: 10),
                  ...movie.cast.map(
                    (person) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.person_outline, size: 20),
                          const SizedBox(width: 10),
                          Text(person),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const _SectionTitle('Synopsis'),
                  const SizedBox(height: 10),
                  Text(
                    movie.synopsis,
                    style: const TextStyle(
                      height: 1.6,
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _toggleWatchlist,
                      icon: Icon(
                        movie.isWatchlisted
                            ? Icons.bookmark_remove
                            : Icons.bookmark_add,
                      ),
                      label: Text(
                        movie.isWatchlisted
                            ? 'Remove from Watchlist'
                            : 'Add to Watchlist',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
    );
  }
}

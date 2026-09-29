import 'package:flutter/material.dart';
import '../data/movies_data.dart';
import '../models/movie.dart';
import 'details_screen.dart';
import 'watchlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _details(Movie movie) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (_) => DetailsScreen(movie: movie)));
    if (mounted) setState(() {});
  }

  Future<void> _watchlist() async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (_) => const WatchlistScreen()));
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final count = sampleMovies.where((m) => m.isWatchlisted).length;
    return Scaffold(
      body: SafeArea(child: LayoutBuilder(builder: (context, box) {
        final wide = box.maxWidth >= 700;
        return Row(children: [
          if (wide) Container(
            width: 230, color: const Color(0xFF090909),
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('MOVIE NIGHT', style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w900,
                  letterSpacing: 1.2)),
                const SizedBox(height: 30),
                const ListTile(leading: Icon(Icons.home_filled,
                  color: Color(0xFF1DB954)), title: Text('Home')),
                ListTile(leading: const Icon(Icons.bookmark_outline),
                  title: const Text('Your Watchlist'), onTap: _watchlist),
                const Divider(height: 32),
                Text('$count saved movies',
                  style: const TextStyle(color: Colors.white54)),
              ]),
          ),
          Expanded(child: Container(
            margin: EdgeInsets.all(wide ? 8 : 0),
            decoration: BoxDecoration(color: const Color(0xFF181818),
              borderRadius: BorderRadius.circular(wide ? 10 : 0)),
            child: CustomScrollView(slivers: [
              SliverToBoxAdapter(child: Container(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
                decoration: const BoxDecoration(gradient: LinearGradient(
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                  colors: [Color(0xFF246B43), Color(0xFF242424),
                    Color(0xFF181818)])),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!wide) const Text('MOVIE NIGHT',
                      style: TextStyle(fontWeight: FontWeight.w900,
                        letterSpacing: 1.2)),
                    if (!wide) const SizedBox(height: 24),
                    const Text('Good evening', style: TextStyle(fontSize: 30,
                      fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    const Text('Find your next favorite film.',
                      style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 20),
                    FilledButton.icon(onPressed: _watchlist,
                      icon: const Icon(Icons.bookmark_outline),
                      label: const Text('Your Watchlist')),
                  ]),
              )),
              const SliverToBoxAdapter(child: Padding(
                padding: EdgeInsets.fromLTRB(24, 14, 24, 18),
                child: Text('Made for movie night', style: TextStyle(
                  fontSize: 23, fontWeight: FontWeight.w800)),
              )),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                sliver: SliverLayoutBuilder(builder: (context, box) {
                  final width = box.crossAxisExtent;
                  final columns = width >= 1050 ? 5 : width >= 720 ? 4
                    : width >= 470 ? 3 : 2;
                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns, crossAxisSpacing: 12,
                      mainAxisSpacing: 12, childAspectRatio: 0.66),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final movie = sampleMovies[index];
                      return Material(color: const Color(0xFF242424),
                        borderRadius: BorderRadius.circular(8),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(onTap: () => _details(movie),
                          child: Padding(padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: Stack(
                                  fit: StackFit.expand, children: [
                                    Hero(tag: movie.title, child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(movie.posterPath,
                                        fit: BoxFit.cover))),
                                    if (movie.isWatchlisted)
                                      const Positioned(right: 6, top: 6,
                                        child: Icon(Icons.bookmark,
                                          color: Color(0xFF1DB954))),
                                  ])),
                                const SizedBox(height: 9),
                                Text(movie.title, maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                                const SizedBox(height: 3),
                                Text('${movie.year} • ${movie.genre}',
                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12,
                                    color: Colors.white60)),
                              ]),
                          ),
                        ),
                      );
                    }, childCount: sampleMovies.length),
                  );
                }),
              ),
            ]),
          )),
        ]);
      })),
      bottomNavigationBar: MediaQuery.sizeOf(context).width < 700
        ? NavigationBar(backgroundColor: const Color(0xFF090909),
          selectedIndex: 0, onDestinationSelected: (index) {
            if (index == 1) _watchlist();
          }, destinations: [
            const NavigationDestination(icon: Icon(Icons.home_filled),
              label: 'Home'),
            NavigationDestination(icon: Badge(isLabelVisible: count > 0,
              label: Text('$count'), child: const Icon(Icons.bookmark_outline)),
              label: 'Watchlist'),
          ])
        : null,
    );
  }
}

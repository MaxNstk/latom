



import 'package:flutter/material.dart';
import 'package:latom/models/anime.dart';
import 'package:latom/services/anime_service.dart';
import 'package:latom/ui/widgets/anime_detail_card.dart';
import 'package:latom/ui/widgets/lt_scaffold.dart';

class TopAnimeScreen extends StatefulWidget {
  const TopAnimeScreen({super.key});

  @override
  State<TopAnimeScreen> createState() => _TopAnimeScreenState();
}

class _TopAnimeScreenState extends State<TopAnimeScreen> {

  final AnimeService animeService = AnimeService();
  final ScrollController _scrollController = ScrollController();
  final List<Anime> _items = [];
  bool _isLoadingMore = false;
  int _currentPage = 1;
  final int _itemsPerPage = 20;

  @override
  void initState() {
    super.initState();
    _loadMoreItems();
    _scrollController.addListener(_onScroll);
  }

  void _loadMoreItems() async {
    setState(() => _isLoadingMore = true);
    
    Iterable<Anime> animeList = await animeService.fetchTopAnimes(page: _currentPage, limit: _itemsPerPage);

    setState(() {
      _items.addAll(animeList);
      _currentPage++;
      _isLoadingMore = false;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      _loadMoreItems();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LtScaffold(
      title: 'TOP ANIMES',
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _items.isEmpty? 1 : _items.length,
        itemBuilder: (context, index){
          if (_items.isEmpty){
            return Padding(
              padding: EdgeInsets.all(16), 
              child: Column(
                children: [
                  SizedBox(width:30, height: 30, child: CircularProgressIndicator()),
                  Padding(padding: EdgeInsets.only(top: 12), child: Text("Loading..."),)
                ]
              )
            );
          }
          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: AnimeDetailCard(anime: _items[index])),
                ],
              ),
              SizedBox(height: 8, width: 8,)
            ],
          );
        }
      )
    );
  }
  
}


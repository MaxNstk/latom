

import 'dart:math';

class Anime {
  
  int id;
  String englishTitle;
  String japaneseTitle;
  double score;
  List<String> imageList = [];


  Anime({
    required this.id
  , required this.englishTitle
  , required this.japaneseTitle
  , required this.score
  });

  factory Anime.fromJson(Map<String, dynamic> json){
    Anime anime =  Anime(
        id: json['mal_id'] 
      , englishTitle: json['title'] 
      , japaneseTitle: json.containsKey('title_japanese')? json['title_japanese'] : ''
      , score: json.containsKey('score')? json['score'] : 0 
    );

    anime.imageList.add((json['images'].containsKey('webp')? json['images']['webp']: json['images']['jpg'])?["image_url"]);
    return anime;
  }

  static Iterable<Anime> fromJsonList(List<dynamic> jsonList)  {
    final List<Anime> animeList = jsonList.map((item) => Anime.fromJson(item)).toList();
    return animeList;                                      
  }

  @override
  String toString() {
    return '$id - $englishTitle | $japaneseTitle. ($score)';
  }

  String getRandomImage(){
    return imageList[Random().nextInt(imageList.length)];
  }

  void addImages(List<String> animeList){
    imageList.addAll(animeList);
  }

  void addImage(String img){
    imageList.add(img);
  }

}
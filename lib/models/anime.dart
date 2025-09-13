

class Anime {
  
  int id;
  String englishTitle;
  String japaneseTitle;
  double score;
  String webpImage;


  Anime({
    required this.id
  , required this.englishTitle
  , required this.japaneseTitle
  , required this.score
  , required this.webpImage
  });

  factory Anime.fromJson(Map<String, dynamic> json){
    return Anime(
        id: json['mal_id'] 
      , englishTitle: json['title'] 
      , japaneseTitle: json['title_japanese'] 
      , score: json['score'] 
      , webpImage: json['images']["webp"]["image_url"]
    );
  }

  static Iterable<Anime> fromJsonList(List<dynamic> jsonList)  {
    final List<Anime> animeList = jsonList.map((item) => Anime.fromJson(item)).toList();
    return animeList;                                      
  }

  @override
  String toString() {
    return '$id - $englishTitle | $japaneseTitle. ($score)';
  }
}
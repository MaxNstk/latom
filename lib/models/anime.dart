

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

  Anime toEntity(){
    return Anime(
        id: id
      , englishTitle: englishTitle
      , japaneseTitle: japaneseTitle
      , score: score
      , webpImage: webpImage
    );
  }
}
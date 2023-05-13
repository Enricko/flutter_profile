
class Media {
  String? key;
  String? image;
  String? link;

  Media({this.key,this.image,this.link});

  // factory Media.fromJSON(Map<dynamic, dynamic> media) => Media(key:media['key'],image: media["image"], link: media["link"]);

  // Media.fromJson(Map<String, dynamic> json) {
  //   if(json["key"] is Map) {
  //     key = json["key"] == null ? null : Key.fromJson(json["key"]);
  //   }
  // }

  @override
  String toString() {
    return "{$key:{'image':$image,'link':$link}";
  }
  // Map<String, Map<String, String?>> toList() {
  //   return {
  //     "$key":{
  //       "image":image,
  //       "link":link
  //     }
  //   };
  // }
}

class TvSingleShow {
  TvShow? tvShow;

  TvSingleShow({this.tvShow});

  TvSingleShow.fromJson(Map<String, dynamic> json) {
    tvShow =
        json['tvShow'] != null ? new TvShow.fromJson(json['tvShow']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tvShow != null) {
      data['tvShow'] = this.tvShow!.toJson();
    }
    return data;
  }
}

class TvShow {
  int? id;
  String? name;
  String? permalink;
  String? url;
  String? description;
  String? descriptionSource;
  String? startDate;
  Null? endDate;
  String? country;
  String? status;
  int? runtime;
  String? network;
  Null? youtubeLink;
  String? imagePath;
  String? imageThumbnailPath;
  String? rating;
  String? ratingCount;
  Null? countdown;
  List<String>? genres;
  List<String>? pictures;
  List<Episodes>? episodes;

  TvShow(
      {this.id,
      this.name,
      this.permalink,
      this.url,
      this.description,
      this.descriptionSource,
      this.startDate,
      this.endDate,
      this.country,
      this.status,
      this.runtime,
      this.network,
      this.youtubeLink,
      this.imagePath,
      this.imageThumbnailPath,
      this.rating,
      this.ratingCount,
      this.countdown,
      this.genres,
      this.pictures,
      this.episodes});

  TvShow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    permalink = json['permalink'];
    url = json['url'];
    description = json['description'];
    descriptionSource = json['description_source'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    country = json['country'];
    status = json['status'];
    runtime = json['runtime'];
    network = json['network'];
    youtubeLink = json['youtube_link'];
    imagePath = json['image_path'];
    imageThumbnailPath = json['image_thumbnail_path'];
    rating = json['rating'];
    ratingCount = json['rating_count'];
    countdown = json['countdown'];
    genres = json['genres'].cast<String>();
    pictures = json['pictures'].cast<String>();
    if (json['episodes'] != null) {
      episodes = <Episodes>[];
      json['episodes'].forEach((v) {
        episodes!.add(new Episodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['permalink'] = this.permalink;
    data['url'] = this.url;
    data['description'] = this.description;
    data['description_source'] = this.descriptionSource;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['country'] = this.country;
    data['status'] = this.status;
    data['runtime'] = this.runtime;
    data['network'] = this.network;
    data['youtube_link'] = this.youtubeLink;
    data['image_path'] = this.imagePath;
    data['image_thumbnail_path'] = this.imageThumbnailPath;
    data['rating'] = this.rating;
    data['rating_count'] = this.ratingCount;
    data['countdown'] = this.countdown;
    data['genres'] = this.genres;
    data['pictures'] = this.pictures;
    if (this.episodes != null) {
      data['episodes'] = this.episodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Episodes {
  int? season;
  int? episode;
  String? name;
  String? airDate;

  Episodes({this.season, this.episode, this.name, this.airDate});

  Episodes.fromJson(Map<String, dynamic> json) {
    season = json['season'];
    episode = json['episode'];
    name = json['name'];
    airDate = json['air_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['season'] = this.season;
    data['episode'] = this.episode;
    data['name'] = this.name;
    data['air_date'] = this.airDate;
    return data;
  }
}

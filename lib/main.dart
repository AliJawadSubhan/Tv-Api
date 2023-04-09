import 'dart:convert';

import 'package:flutter/material.dart';
// import 'h';
import 'package:http/http.dart' as http;
import 'package:tvshowapi/singletvshow.dart';

void main(List<String> args) {
  runApp(TvApi());
}

class TvApi extends StatelessWidget {
  const TvApi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<TvShow> getMovieData() async {
    final http.Response response = await http
        .get(Uri.parse("https://www.episodate.com/api/most-popular?page=2"));
    return TvShow.fromJson(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieApp'),
      ),
      body: FutureBuilder(
        future: getMovieData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.tvShows!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image(
                          image: NetworkImage(snapshot
                              .data!.tvShows![index].imageThumbnailPath
                              .toString()),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data!.tvShows![index].name.toString(),
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              snapshot.data!.tvShows![index].startDate
                                  .toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DetailedArea(
                                permalink: snapshot
                                    .data!.tvShows![index].permalink
                                    .toString(),
                              );
                            },
                          ));
                        },
                        icon: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailedArea extends StatelessWidget {
  const DetailedArea({super.key, required this.permalink});

  final String permalink;

  Future<TvSingleShow> getDetailData() async {
    final http.Response response = await http.get(
        Uri.parse("https://www.episodate.com/api/show-details?q=$permalink"));
    return TvSingleShow.fromJson(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.orangeAccent,
      body: FutureBuilder(
        future: getDetailData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  SizedBox(
                    height: 300,
                    child: Container(
                      color: Colors.grey.shade300,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            snapshot.data?.tvShow?.imagePath ??
                                'https://media.giphy.com/media/RgzryV9nRCMHPVVXPV/giphy.gif',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 240.0),
                    child: Container(
                      padding: const EdgeInsets.all(28.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            snapshot.data?.tvShow?.name ?? 'Show Name',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            snapshot.data?.tvShow?.network ?? 'Network Name',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 20,
                              letterSpacing: 0.3,
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Description:',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            snapshot.data?.tvShow?.description ?? 'Description',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 16,
                              letterSpacing: 0.3,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: 120.0,
                            height: 2.0,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TvShow {
  String? total;
  int? page;
  int? pages;
  List<TvShows>? tvShows;

  TvShow({this.total, this.page, this.pages, this.tvShows});

  TvShow.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    pages = json['pages'];
    if (json['tv_shows'] != null) {
      tvShows = <TvShows>[];
      json['tv_shows'].forEach((v) {
        tvShows!.add(TvShows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    data['pages'] = this.pages;
    if (this.tvShows != null) {
      data['tv_shows'] = this.tvShows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TvShows {
  int? id;
  String? name;
  String? permalink;
  String? startDate;
  Null? endDate;
  String? country;
  String? network;
  String? status;
  String? imageThumbnailPath;

  TvShows(
      {this.id,
      this.name,
      this.permalink,
      this.startDate,
      this.endDate,
      this.country,
      this.network,
      this.status,
      this.imageThumbnailPath});

  TvShows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    permalink = json['permalink'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    country = json['country'];
    network = json['network'];
    status = json['status'];
    imageThumbnailPath = json['image_thumbnail_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['permalink'] = this.permalink;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['country'] = this.country;
    data['network'] = this.network;
    data['status'] = this.status;
    data['image_thumbnail_path'] = this.imageThumbnailPath;
    return data;
  }
}

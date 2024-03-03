import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class JioSaavnSongs extends StatefulWidget {
  const JioSaavnSongs({Key? key}) : super(key: key);

  @override
  State<JioSaavnSongs> createState() => _JioSaavnSongsState();
}

class _JioSaavnSongsState extends State<JioSaavnSongs> {
    List<Album> albums = [];

  Future<void> fetchAlbums() async {
    final response = await http.get(Uri.parse('https://saavn.dev/modules?language=malayalam,tamil'));
    if (response.statusCode == 200) {
      setState(() {
        albums = (json.decode(response.body)['data']['albums'] as List)
            .map((albumJson) => Album.fromJson(albumJson))
            .toList();
      });
    } else {
      throw Exception('Failed to load albums');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Jio Albums'),
      ),
      body: Center(
        child: albums.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  final album = albums[index];
                  return ListTile(
                    title: Text(album.name),
                    subtitle: Text(album.artists.join(', ')),
                    leading: Image.network(album.imageUrl),
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlbumSongsPage(album: album),
                        ),
                      );
                      // Handle onTap event
                      // You can navigate to a new page to display details of the selected album
                    },
                  );
                },
              ),
      ),
    );
  }
}

class Album {
  final String id;
  final String name;
  final List<String> artists;
  final String imageUrl;
  final List<Song> songs;

  Album({
    required this.id,
    required this.name,
    required this.artists,
    required this.imageUrl,
    required this.songs,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      name: json['name'],
      artists: (json['artists'] as List).map((artist) => artist['name'].toString()).toList(),
      imageUrl: json['image'][2]['link'],
      songs: (json['songs'] as List).map((songJson) => Song.fromJson(songJson)).toList(),
    );
  }
}

class Song {
  final String id;
  final String name;
  final String artist;

  Song({
    required this.id,
    required this.name,
    required this.artist,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      name: json['name'],
      artist: json['artists'].join(', '),
    );
  }
}

class AlbumSongsPage extends StatelessWidget {
  final Album album;

  const AlbumSongsPage({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${album.name} Songs'),
      ),
      body: ListView.builder(
        itemCount: album.songs.length,
        itemBuilder: (context, index) {
          final song = album.songs[index];
          return ListTile(
            title: Text(song.name),
            subtitle: Text(song.artist),
            onTap: () {
              // Handle onTap event for each song
            },
          );
        },
      ),
    );
  }
}
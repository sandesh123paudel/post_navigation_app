// TODO Implement this library.import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:post_navigation_app/deep_link_handler.dart';
import 'package:post_navigation_app/post_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PostPage(type: 'Text', content: 'This is a sample text post.'),
    PostPage(
        type: 'Video',
        content:
            'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
    PostPage(type: 'Image', content: 'https://picsum.photos/200/300'),
  ];

  @override
  void initState() {
    super.initState();
    DeepLinkHandler.instance.init(
      onLink: (String link) {
        final postType = DeepLinkHandler.instance.getPostTypeFromLink(link);
        if (postType != null) {
          setState(() {
            _currentIndex = ['text', 'video', 'image'].indexOf(postType);
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.text_fields),
            label: 'Text',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Image',
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

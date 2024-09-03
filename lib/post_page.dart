import 'package:flutter/material.dart';
import 'package:share/share.dart';

class PostPage extends StatelessWidget {
  final String type;
  final String content;

  PostPage({required this.type, required this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('$type Post'),
          SizedBox(height: 20),
          _buildContent(),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _sharePost(context),
            child: Text('Share'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (type) {
      case 'Text':
        return Text(content);
      case 'Video':
        return Text('Video player placeholder: $content');
      case 'Image':
        return Image.network(content, width: 200, height: 200);
      default:
        return SizedBox.shrink();
    }
  }

  void _sharePost(BuildContext context) {
    final String postType = type.toLowerCase();
    final String shareLink = 'https://myapp.com/$postType';
    Share.share('Check out this $type post: $shareLink');
  }
}

import 'package:uni_links/uni_links.dart';

class DeepLinkHandler {
  DeepLinkHandler._();
  static final instance = DeepLinkHandler._();

  Function(String)? _onLink;

  void init({required Function(String) onLink}) {
    _onLink = onLink;
    _initUniLinks();
  }

  Future<void> _initUniLinks() async {
    try {
      final initialLink = await getInitialUri();
      if (initialLink != null) {
        _handleLink(initialLink.toString());
      }
    } catch (e) {
      print('Error handling initial deep link: $e');
    }

    uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleLink(uri.toString());
      }
    }, onError: (err) {
      print('Error handling deep link: $err');
    });
  }

  void _handleLink(String link) {
    if (_onLink != null) {
      _onLink!(link);
    }
  }

  String? getPostTypeFromLink(String link) {
    final uri = Uri.parse(link);
    if (uri.pathSegments.isNotEmpty) {
      final postType = uri.pathSegments.first.toLowerCase();
      if (['text', 'video', 'image'].contains(postType)) {
        return postType;
      }
    }
    return null;
  }
}
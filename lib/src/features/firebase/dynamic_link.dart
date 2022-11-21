// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app_startup.dart';
import '../../exceptions/error_logger.dart';

//* https://firebase.google.com/docs/dynamic-links/flutter/create
final dynamicLinkProvider = Provider<DynamicLink>(DynamicLink.new);

class DynamicLink {
  DynamicLink(this.ref) {
    _init();
  }
  final Ref ref;

  Future<void> _init() async {
    final shortDynamicLink = await createDynamicLink();
    logger.i('DynamicLink _init: $shortDynamicLink');
  }

  Future<ShortDynamicLink?> createDynamicLink({
    String link = 'https://fruitshop.app/',
    String uriPrefix = 'https://fruitshop.app/links',
    String title = 'title',
    String description = 'description',
    String? imageUrl,
  }) async {
    try {
      final packageInfo = ref.read(packageInfoProvider);
      final dynamicLinkParams = DynamicLinkParameters(
        link: Uri.parse(link),
        uriPrefix: uriPrefix,
        androidParameters:
            AndroidParameters(packageName: packageInfo.packageName),
        iosParameters: IOSParameters(bundleId: packageInfo.packageName),
        // imageUrl	링크와 관련된 이미지의 URL입니다. 이미지는 300x200픽셀 이상, 300KB 미만
        socialMetaTagParameters: SocialMetaTagParameters(
          title: title,
          description: description,
          imageUrl: imageUrl != null ? Uri.parse(imageUrl) : null,
        ),
        // googleAnalyticsParameters: const GoogleAnalyticsParameters(
        // campaign: 'promo',
        // source: 'twitter',
        // medium: 'social',
        // ),
      );
      logger.i('DynamicLink dynamicLinkParams: $dynamicLinkParams');
      final unguessableDynamicLink =
          await FirebaseDynamicLinks.instance.buildShortLink(
        dynamicLinkParams,
        shortLinkType: ShortDynamicLinkType.unguessable,
      );
      logger.i(
          'DynamicLink unguessableDynamicLink: ${unguessableDynamicLink.shortUrl}');
      return unguessableDynamicLink;
    } catch (e) {
      logger.i('createDynamicLink e: $e');
    }
    return null;
  }
}

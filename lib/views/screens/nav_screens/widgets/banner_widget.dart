import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/controller/banner_controller.dart';
import 'package:multi_store_app/models/banner_model.dart';
import 'package:multi_store_app/provider/banners_provider.dart';

class BannerWidget extends ConsumerStatefulWidget {
  const BannerWidget({super.key});

  @override
  ConsumerState<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends ConsumerState<BannerWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchBanners();
  }

  Future<void> _fetchBanners() async {
    final BannerController bannerController = BannerController();
    final banners = await bannerController.loadBanners();
    ref.read(bannerProvider.notifier).setBanners(banners);
  }

  @override
  Widget build(BuildContext context) {
    final banners = ref.watch(bannerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
          height: 170,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Color(0xFFF7F7F7)),
          child: PageView.builder(
            itemCount: banners!.length,
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child:
                    // Image.network(
                    //   banner.image,
                    //   fit: BoxFit.cover,
                    // )

                    // the code below for the cashing images

                    CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: banner.image,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                          child: Center(
                    child: CircularProgressIndicator(
                        color: Colors.blue, value: downloadProgress.progress),
                  )),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              );
            },
          )),
    );
  }
}

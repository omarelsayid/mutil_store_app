import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/controller/banner_controller.dart';
import 'package:multi_store_app/models/banner_model.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<List<BannerModel>> futureBanner;
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureBanner = BannerController().loadBanners();
    log('Done');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 170,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Color(0xFFF7F7F7)),
        child: FutureBuilder(
          future: futureBanner,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
              ));
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No banners'),
              );
            } else {
              final banners = snapshot.data;
              return PageView.builder(
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
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(
                              child: Center(
                        child: CircularProgressIndicator(
                            color: Colors.blue,
                            value: downloadProgress.progress),
                      )),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jomhack/services/api_service.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/news.dart';
import '../../themes/colors.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> with AutomaticKeepAliveClientMixin {
  Future<List<NewsModel>> getNews() async {
    return await APIService.getNews();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      child: FutureBuilder(
          future: getNews(),
          builder: (context, AsyncSnapshot<List<NewsModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SpinKitFadingCube(
                color: AppColor.tertiary,
                size: 30.sp,
              );
            }

            List<NewsModel> news = snapshot.data ?? [];

            return Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'News',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.tertiary,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                news.isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        child: const Text('No news available'),
                      )
                    : Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              NewsModel n = news[index];

                              String url = n.link.toString();

                              Uri uri = Uri.parse(url);

                              return GestureDetector(
                                onTap: () async {
                                  if (await canLaunchUrl(uri)) {
                                    launchUrl(uri);
                                  }
                                },
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.sp),
                                  ),
                                  child: Container(
                                    height: 17.h,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 1.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.sp),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          n.title.toString(),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.tertiary,
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        Text(
                                          n.about.toString(),
                                          maxLines: 4,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: AppColor.secondary,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              uri.host,
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: AppColor.secondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              if (index < news.length) {
                                return SizedBox(height: 1.h);
                              }

                              return const SizedBox.shrink();
                            },
                            itemCount: news.length),
                      ),
              ],
            );
          }),
    );
  }
}

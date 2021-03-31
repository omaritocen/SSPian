import 'package:flutter/material.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:provider/provider.dart';
import 'package:sspian/src/models/announcement.dart';
import 'package:sspian/src/providers/announcement.dart';
import 'package:sspian/src/providers/deadline.dart';
import 'package:sspian/src/utils/utils.dart';

import 'announcement_item.dart';

class AnnouncementsList extends StatefulWidget {
  final int index;

  AnnouncementsList({this.index});

  @override
  _AnnouncementsListState createState() => _AnnouncementsListState();
}

class _AnnouncementsListState extends State<AnnouncementsList> {
  List<Announcement> announcementList = [];

  @override
  Widget build(BuildContext context) {
    _setList();

    final announcemntsProvider = Provider.of<AnnouncementProvider>(context);

    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Utils.size.height * 0.04),
        padding: EdgeInsets.symmetric(horizontal: Utils.size.width * 0.05),
        child: PaginationView<Announcement>(
          preloadedItems: announcementList,
          itemBuilder: (ctx, announcement, index) {
            return AnnouncementItem(announcement);
          },
          paginationViewType: PaginationViewType.listView,
          pageFetch: announcemntsProvider.pageFetch,
          onError: (dynamic error) => Center(
            child: Text('Some error occured'),
          ),
          onEmpty: Center(
            child: Text('Sorry! This is empty'),
          ),
          bottomLoader: Center(
            // optional
            child: CircularProgressIndicator(),
          ),
          initialLoader: Center(
            // optional
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  void _setList() {
    List<Announcement> list = [];
    final announcemntsProvider = Provider.of<AnnouncementProvider>(context);

    switch (widget.index) {
      case 0:
        list = announcemntsProvider.allAnnoumcements;
        break;
      case 1:
        list = announcemntsProvider.deadlines;
        break;
      case 2:
        list = announcemntsProvider.assignments;
        break;
      case 3:
        list = announcemntsProvider.projects;
        break;
      case 4:
        list = announcemntsProvider.quizes;
        break;
      case 5:
        list = announcemntsProvider.announcements;
        break;
    }

    setState(() {
      announcementList = list;
    });

    //return announcemntsProvider.announcements;
  }
}

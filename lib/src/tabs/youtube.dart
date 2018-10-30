import 'package:flutter/material.dart';

import 'package:youtube_clone_app/src/commons/colors.dart';
import 'package:youtube_clone_app/src/commons/transparent_image.dart';
import 'package:youtube_clone_app/src/models/VideoData.dart';
import 'package:youtube_clone_app/src/models/ChannelData.dart';

class YoutubeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => YoutubeState();
}

class YoutubeState extends State<YoutubeScreen> {
  List<VideoData> videos = [];

  @override
  Widget build(BuildContext context) {
    return _createListBuilder();
  }

  _createListBuilder() {
    return ListView.builder(
        itemCount: videos.length,
        itemBuilder: (BuildContext context, int index) => _buildListItem(context, index)
    );
  }

  _buildListItem(context, index) {
    return InkWell(
      onTap: () {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("clicked : $index")));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: BorderColor)),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                _buildItemVideoThumbnail(index),
                _myTubeVideoContent(index)
              ],
            )
        ),
      ),
    );
  }

  _buildItemVideoThumbnail(int index) => AspectRatio(
    aspectRatio: 1.8,
    child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: videos[index].getThumbnailUrl,
        fit: BoxFit.cover
    )
  );

  /// Video Content View builder at ListView Item Widget
  _myTubeVideoContent(int index) => Container(
    alignment: Alignment.topCenter,
    margin: EdgeInsets.only(top: 10.0),
    child: Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: BorderColor,
              image: DecorationImage(
                image: NetworkImage(videos[index].getChannelData.getThumbnailUrl),
                fit: BoxFit.contain,
              )
          ),
          width: 32.0,
          height: 32.0,
        ),
        Flexible(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    videos[index].getTitle,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: TextColor
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${videos[index].getChannelData.getName}",
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: TextColor,),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          flex: 1,
        ),
        InkWell(
            child: Container(child: Icon(Icons.more_vert, size: 20.0, color: BorderColor),),
            onTap: () {
              print("clicked");
            },
            borderRadius: BorderRadius.circular(20.0)
        )
      ],
    ),
  );


}
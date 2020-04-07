import 'package:flutter/material.dart';

import 'package:clean_architecture_sample/framework_driver/ui/widget/widgets.dart';
// NOTE: UI から Entity(本当は Model とか) への依存は順方向.
import 'package:clean_architecture_sample/entity/entity.dart';

class ArticleItem extends StatelessWidget {
  final QiitaItem _qiitaItem;
  final Function(QiitaItem) _onTap;

  ArticleItem(
    this._qiitaItem,
    this._onTap,
  ): assert(_qiitaItem != null);

  Widget _buildTitle() {
    return Text(
      _qiitaItem.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600
      ),
    );
  }

  Widget _buildContent() {
    return Text(
      _qiitaItem.body,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 14,
      ),
    );
  }

  Widget _buildBottomWidgets() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // User icon
        UserIcon(_qiitaItem.user.profileImageURL),
        // Spacer
        SizedBox(width: 8),
        // User name
        Text(_qiitaItem.user.name),
        // Stretch spacer
        Expanded(child: SizedBox()),
        // Likes
        LikesCount(_qiitaItem.likes),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: RippleCard(
        onTap: () {_onTap(_qiitaItem);},
        height: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Title
            _buildTitle(),
            // Spacer
            SizedBox(height: 8),
            // Content
            _buildContent(),
            // Stretch Spacer
            Expanded(child: SizedBox(height: 8)),
            // Bottom
            _buildBottomWidgets(),
          ],
        ),
      ),
    );
  }
}
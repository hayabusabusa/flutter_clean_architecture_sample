import 'package:equatable/equatable.dart';
import 'package:clean_architecture_sample/entity/entity.dart';

class QiitaAllItems extends Equatable {
  final List<QiitaItem> items;
  final int totalCount;

  QiitaAllItems({
    this.items,
    this.totalCount,
  });

  @override
  List<Object> get props => [
    items,
    totalCount,
  ];
}
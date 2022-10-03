import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class PaginationView extends StatelessWidget {
  final bool showLoadMoreWidget;
  final bool showLoadMoreEndWidget;
  final Widget child;
  final EndOfPageListenerCallback loadMoreData;
  final Color textColor;
  final EdgeInsetsDirectional? loadMorePadding;
  final EdgeInsetsDirectional? loadMoreEndPadding;

  const PaginationView({
    this.showLoadMoreWidget = false,
    this.showLoadMoreEndWidget = false,
    required this.loadMoreData,
    this.loadMorePadding,
    this.loadMoreEndPadding,
    required this.child,
    this.textColor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LazyLoadScrollView(
            onEndOfPage: loadMoreData,
            child: child,
          ),
        ),
        Visibility(
          visible: showLoadMoreWidget,
          child: Padding(
            padding: loadMorePadding ??
                const EdgeInsetsDirectional.only(
                  start: 12.0,
                  end: 12.0,
                  bottom: 28.0,
                  top: 18.0,
                ),
            child: const CircularProgressIndicator.adaptive(),
          ),
        ),
        Visibility(
          visible: showLoadMoreEndWidget,
          child: Padding(
            padding: loadMoreEndPadding ??
                const EdgeInsetsDirectional.only(
                  start: 12.0,
                  end: 12.0,
                  bottom: 28.0,
                  top: 18.0,
                ),
            child: const LinearProgressIndicator(),
          ),
        ),
      ],
    );
  }
}

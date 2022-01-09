import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sociocon/core/models/post_model.dart';

class DescriptionText extends StatefulWidget {
  const DescriptionText({
    Key? key,
    required this.post,
    required this.trimLines,
  }) : super(key: key);

  final PostModel post;
  final int trimLines;

  @override
  _DescriptionTextState createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {
  bool _readMore = true;
  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    TextSpan link = TextSpan(
      text: _readMore ? "... read more" : " read less",
      style: TextStyle(
        color: Colors.grey[500],
      ),
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        final text = TextSpan(
          text: widget.post.description,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            // color: ThemeService.getValue()
            //     ? Colors.white.withOpacity(0.8)
            //     : Colors.black87,
          ),
        );
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection.rtl,
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        int endIndex;
        final pos = textPainter.getPositionForOffset(
          Offset(
            textSize.width - linkSize.width,
            textSize.height,
          ),
        );
        endIndex = textPainter.getOffsetBefore(pos.offset)!;
        var textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore
                ? widget.post.description.substring(0, endIndex)
                : widget.post.description,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              // color: ThemeService.getValue()
              //     ? Colors.white.withOpacity(0.8)
              //     : Colors.black87,
            ),
            children: [
              link,
            ],
          );
        } else {
          textSpan = TextSpan(
            text: widget.post.description,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              // color: ThemeService.getValue()
              //     ? Colors.white.withOpacity(0.8)
              //     : Colors.black87,
            ),
          );
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: TextSpan(
            text: widget.post.personName,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              //color: ThemeService.getValue() ? Colors.white : Colors.black87,
            ),
            children: [
              TextSpan(
                text: " ",
              ),
              textSpan,
            ],
          ),
        );
      },
    );
    return result;
  }
}

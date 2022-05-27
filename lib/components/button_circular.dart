import 'package:ecos12_chat_app/app/app_color.dart';
import 'package:flutter/material.dart';

class ButtonCircular extends StatefulWidget {
  final String text;
  final Future<void> Function()? onTap;
  final Color? colorButton;
  final double radius;
  final double? fontSize;
  final double width;
  final double height;
  final bool isAnimation;

  const ButtonCircular({
    Key? key,
    required this.text,
    this.onTap,
    this.colorButton,
    this.radius = 25,
    this.fontSize = 20,
    this.width = 250,
    this.height = 55,
    this.isAnimation = true,
  }) : super(key: key);

  @override
  State<ButtonCircular> createState() => _ButtonCircularState();
}

class _ButtonCircularState extends State<ButtonCircular> with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  late final Animation<double> animation;
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween<double>(begin: widget.width, end: widget.height * 2).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            color: widget.colorButton ?? AppColor.greenTurquoise,
          ),
          width: animation.value,
          height: widget.height,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: _isLoading
                ? () {}
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    if (widget.isAnimation) controller.forward();
                    if (widget.onTap != null) {
                      await widget.onTap!();
                      await Future.delayed(const Duration(milliseconds: 100));
                    }
                    if (widget.isAnimation) controller.reverse();
                    setState(() {
                      _isLoading = false;
                    });
                  },
            child: _isLoading
                ? Center(
                    child: SizedBox(
                      height: widget.height * 0.5,
                      width: widget.height * 0.5,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      widget.text,
                      style: TextStyle(fontSize: widget.fontSize, color: Colors.white),
                    ),
                  ),
          ),
        );
      },
    );
  }
}

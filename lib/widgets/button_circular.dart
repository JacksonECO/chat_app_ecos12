import 'package:ecos12_chat_app/app/color_app.dart';
import 'package:ecos12_chat_app/widgets/button_simple.dart';
import 'package:flutter/material.dart';

class ButtonCircular extends StatefulWidget {
  final String? text;
  final Widget? child;

  final Function()? onTap;
  final Color? colorButton;
  final double radius;
  final double? fontSize;
  final double width;
  final double height;
  final bool isAnimation;

  const ButtonCircular({
    Key? key,
    this.text,
    this.child,
    this.onTap,
    this.colorButton,
    this.radius = 25,
    this.fontSize = 20,
    this.width = 250,
    this.height = 55,
    this.isAnimation = true,
  })  : assert(text != null || child != null),
        super(key: key);

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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            color: widget.colorButton ?? ColorApp.greenTurquoise,
          ),
          width: animation.value,
          height: widget.height,
          child: ButtonSimple(
            onTap: _isLoading
                ? () {}
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      if (widget.isAnimation) controller.forward();
                      if (widget.onTap != null) {
                        await widget.onTap!();
                        await Future.delayed(const Duration(milliseconds: 100));
                      }
                      if (widget.isAnimation) controller.reverse();
                    } catch (_) {}
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
                    child: widget.child ??
                        Text(
                          widget.text!,
                          style: TextStyle(fontSize: widget.fontSize, color: Colors.white),
                        ),
                  ),
          ),
        );
      },
    );
  }
}

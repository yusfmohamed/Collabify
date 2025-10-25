import 'package:flutter/material.dart';
import '../config/theme.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? errorText;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.controller,
    this.errorText,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(35),
            border: Border.all(
              color: widget.errorText != null 
                  ? Colors.red 
                  : AppColors.inputBorder,
              width: 2,
            ),
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: _obscureText,
            style: AppTextStyles.input,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyles.hint,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: Icon(
                  widget.icon,
                  color: widget.errorText != null 
                      ? Colors.red 
                      : AppColors.primaryPurple,
                  size: 26,
                ),
              ),
              suffixIcon: widget.isPassword
                  ? Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        icon: Icon(
                          _obscureText 
                              ? Icons.visibility_off_outlined 
                              : Icons.visibility_outlined,
                          color: widget.errorText != null 
                              ? Colors.red 
                              : AppColors.primaryPurple,
                          size: 26,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 8),
            child: Text(
              widget.errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
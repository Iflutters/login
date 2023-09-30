import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme/theme_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.onSaved,
    this.textInputType,
    this.obscureText,
    this.btnVisible,
    this.validator,
  });

  final String? hintText;
  final IconData icon;
  final TextInputType? textInputType;
  final bool? obscureText;
  final Function()? btnVisible;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10).w,
      child: TextFormField(
        cursorColor: primaryColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: greyColor,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.w),
            borderSide: BorderSide(color: greenLigthColor),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.w),
              borderSide: BorderSide(color: greenLigthColor)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.w),
              borderSide: const BorderSide(color: primaryColor)),    
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.w),
              borderSide: const BorderSide(color: primaryColor)),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(
            icon,
            color: primaryColor,
            size: 20.sp,
          ),
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 14.sp
          ),
          suffixIcon: obscureText != null
              ? IconButton(
                  color: obscureText! ? Colors.grey : primaryColor,
                  onPressed: btnVisible,
                  icon: !obscureText!
                      ? Icon(
                          Icons.visibility,
                          size: 20.sp,
                        )
                      : Icon(
                          Icons.visibility_off,
                          size: 20.sp,
                        ))
              : null,
        ),
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14.sp
        ),
        textInputAction: TextInputAction.next,
        keyboardType: textInputType ?? TextInputType.text,
        obscureText: obscureText ?? false,
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }
}

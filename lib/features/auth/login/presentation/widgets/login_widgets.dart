import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTap;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.focusNode,
    this.onFieldSubmitted,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFf1faee),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackCommon.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: controller,
                obscureText: obscureText,
                keyboardType: keyboardType,
                validator: validator,
                focusNode: focusNode,
                onFieldSubmitted: onFieldSubmitted,
                onTap: onTap,
                enableInteractiveSelection: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  fillColor: AppColors.whiteCommon,
                  hintStyle: const TextStyle(color: AppColors.greyCommon),
                  errorStyle: const TextStyle(height: 0.7),
                ),
                style: const TextStyle(
                  color: AppColors.blackCommon,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          if (suffixIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: suffixIcon,
            ),
        ],
      ),
    );
  }
}

class DepartmentDropdown extends StatefulWidget {
  final String selectedDepartment;
  final List<String> departments;
  final ValueChanged<String?> onChanged;

  const DepartmentDropdown({
    super.key,
    required this.selectedDepartment,
    required this.departments,
    required this.onChanged,
  });
  
  @override
  State<DepartmentDropdown> createState() => _DepartmentDropdownState();
}

class _DepartmentDropdownState extends State<DepartmentDropdown> {

  String _getDepartmentLabel(BuildContext context, String key) {
    switch (key) {
      case 'qualityControl':
        return AppLocalizations.of(context).qualityControlLabel;
      case 'warehouseManager':
        return AppLocalizations.of(context).warehouseManagerLabel;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackCommon.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          _showDepartmentModal();
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _getDepartmentLabel(context, widget.selectedDepartment),
                  style: const TextStyle(
                    color: AppColors.blackCommon,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: AppColors.greyCommon),
            ],
          ),
        ),
      ),
    );
  }
  
  void _showDepartmentModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.scaffoldBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          AppLocalizations.of(context).selectDepartmentLabel,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(),
                      ...widget.departments.map((department) => ListTile(
                        title: Text(
                          _getDepartmentLabel(context, department),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                        ),
                        selected: department == widget.selectedDepartment,
                        onTap: () {
                          widget.onChanged(department);
                          Navigator.of(context).pop();
                        },
                      )),
                     
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    ).then((_) {
      if (mounted) {
        FocusScope.of(context).canRequestFocus = true;
      }
    });
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const LoginButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackCommon.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(color: AppColors.scaffoldBackground)
                : Text(
                    AppLocalizations.of(context).loginButton,
                    style: TextStyle(
                      color: AppColors.whiteCommon,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
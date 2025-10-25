import 'package:flutter/material.dart';
import '../config/theme.dart';

class DropdownField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final String? selectedValue;
  final Function(String?) onChanged;

  final bool hasError;

  const DropdownField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.selectedValue,
    required this.onChanged,
    this.hasError = false,
  }) : super(key: key);

  static final List<String> nationalities = [
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Germany',
    'France',
    'Italy',
    'Spain',
    'Netherlands',
    'Switzerland',
    'Sweden',
    'Norway',
    'Denmark',
    'Finland',
    'Belgium',
    'Austria',
    'Ireland',
    'Portugal',
    'Greece',
    'Poland',
    'Czech Republic',
    'Hungary',
    'Romania',
    'Bulgaria',
    'Croatia',
    'Serbia',
    'Ukraine',
    'Russia',
    'Turkey',
    'Egypt',
    'South Africa',
    'Nigeria',
    'Kenya',
    'Morocco',
    'Algeria',
    'Tunisia',
    'Ethiopia',
    'Ghana',
    'Tanzania',
    'Uganda',
    'China',
    'Japan',
    'South Korea',
    'India',
    'Pakistan',
    'Bangladesh',
    'Indonesia',
    'Thailand',
    'Vietnam',
    'Philippines',
    'Malaysia',
    'Singapore',
    'Myanmar',
    'Cambodia',
    'Nepal',
    'Sri Lanka',
    'Afghanistan',
    'Iraq',
    'Iran',
    'Saudi Arabia',
    'UAE',
    'Qatar',
    'Kuwait',
    'Oman',
    'Bahrain',
    'Jordan',
    'Lebanon',
    'Syria',
    'Yemen',
    'Israel',
    'Palestine',
    'Brazil',
    'Mexico',
    'Argentina',
    'Colombia',
    'Chile',
    'Peru',
    'Venezuela',
    'Ecuador',
    'Bolivia',
    'Paraguay',
    'Uruguay',
    'Costa Rica',
    'Panama',
    'Guatemala',
    'Honduras',
    'El Salvador',
    'Nicaragua',
    'Cuba',
    'Dominican Republic',
    'Jamaica',
    'Trinidad and Tobago',
    'New Zealand',
  ]..sort();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: hasError ? Colors.red : AppColors.inputBorder,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 15),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(
                icon,
                color: hasError ? Colors.red : AppColors.primaryPurple,
                size: 26,
              ),
            ),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedValue,
                  hint: Text(
                    hintText,
                    style: AppTextStyles.hint,
                  ),
                  isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.primaryPurple,
                    size: 30,
                  ),
                  style: AppTextStyles.input,
                  dropdownColor: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  menuMaxHeight: 300,
                  items: nationalities.map((String nationality) {
                    return DropdownMenuItem<String>(
                      value: nationality,
                      child: Text(
                        nationality,
                        style: AppTextStyles.input,
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
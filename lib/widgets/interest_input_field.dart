import 'package:flutter/material.dart';
import '../config/theme.dart';

class InterestInputField extends StatefulWidget {
  final TextEditingController interestController;
  final List<String> hashtags;
  final String? errorText;
  final Function(List<String>) onHashtagsChanged;

  const InterestInputField({
    Key? key,
    required this.interestController,
    required this.hashtags,
    required this.onHashtagsChanged,
    this.errorText,
  }) : super(key: key);

  @override
  State<InterestInputField> createState() => _InterestInputFieldState();
}

class _InterestInputFieldState extends State<InterestInputField> {
  final TextEditingController _hashtagController = TextEditingController();

  @override
  void dispose() {
    _hashtagController.dispose();
    super.dispose();
  }

  void _addHashtag() {
    String hashtag = _hashtagController.text.trim();
    if (hashtag.isNotEmpty && widget.hashtags.length < 5) {
      // Add # if not present
      if (!hashtag.startsWith('#')) {
        hashtag = '#$hashtag';
      }
      
      // Check for duplicates
      if (!widget.hashtags.contains(hashtag)) {
        List<String> updatedTags = [...widget.hashtags, hashtag];
        widget.onHashtagsChanged(updatedTags);
        _hashtagController.clear();
      }
    }
  }

  void _removeHashtag(int index) {
    List<String> updatedTags = [...widget.hashtags];
    updatedTags.removeAt(index);
    widget.onHashtagsChanged(updatedTags);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Interest Description Field
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
            controller: widget.interestController,
            style: AppTextStyles.input,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'What\'s your interest? (e.g., Graphic Design)',
              hintStyle: AppTextStyles.hint,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 20, right: 15, top: 12),
                child: Icon(
                  Icons.interests_outlined,
                  color: AppColors.primaryPurple,
                  size: 26,
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 15),
        
        // Hashtag Input Field
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(35),
            border: Border.all(
              color: widget.hashtags.length >= 5 
                  ? AppColors.inputBorder.withOpacity(0.5)
                  : AppColors.inputBorder,
              width: 2,
            ),
          ),
          child: TextField(
            controller: _hashtagController,
            style: AppTextStyles.input,
            enabled: widget.hashtags.length < 5,
            onSubmitted: (_) => _addHashtag(),
            decoration: InputDecoration(
              hintText: widget.hashtags.length < 5 
                  ? 'Add hashtag (e.g., Adobe Photoshop)' 
                  : 'Maximum 5 hashtags reached',
              hintStyle: AppTextStyles.hint,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 20, right: 15),
                child: Icon(
                  Icons.tag,
                  color: AppColors.primaryPurple,
                  size: 26,
                ),
              ),
              suffixIcon: widget.hashtags.length < 5
                  ? Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add_circle,
                          color: AppColors.primaryPurple,
                          size: 28,
                        ),
                        onPressed: _addHashtag,
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
        
        // Hashtags Display
        if (widget.hashtags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.hashtags.asMap().entries.map((entry) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF6B2FD9),
                        Color(0xFF00BCD4),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        entry.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => _removeHashtag(entry.key),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        
        // Character count for hashtags
        if (widget.hashtags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 5),
            child: Text(
              '${widget.hashtags.length}/5 hashtags',
              style: TextStyle(
                fontSize: 12,
                color: widget.hashtags.length >= 5 
                    ? Colors.orange 
                    : AppColors.textLight,
              ),
            ),
          ),
        
        // Error message
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
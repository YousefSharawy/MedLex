import 'package:flutter/material.dart';
import 'package:transly/presentation/base/components.dart';
import 'package:transly/presentation/home/widgets/recently_view_item.dart';
import 'package:transly/presentation/search/widgets/presistent_search_bar.dart';
import 'package:transly/presentation/resources/color_manager.dart';
import 'package:transly/presentation/resources/font_manager.dart';
import 'package:transly/presentation/resources/style_manager.dart';
import 'package:transly/presentation/resources/values_manager.dart';
import 'package:transly/presentation/search/search_view.dart';

class DictionaryView extends StatefulWidget {
  const DictionaryView({super.key});

  @override
  State<DictionaryView> createState() => _DictionaryViewState();
}

class _DictionaryViewState extends State<DictionaryView> {
  bool _isSearching = false;
  String _selectedCategory = 'All';
  final ScrollController _scrollController = ScrollController();

  final List<String> _categories = [
    'All',
    'Anatomy',
    'Diseases',
    'Procedures',
    'Cardiology',
  ];

  final List<String> _alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  final Map<String, GlobalKey> _letterKeys = {};

  @override
  void initState() {
    super.initState();
    for (var letter in _alphabet) {
      _letterKeys[letter] = GlobalKey();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchStart() {
    setState(() => _isSearching = true);
  }

  void _onSearchClose() {
    setState(() => _isSearching = false);
  }

  void _scrollToLetter(String letter) {
    final key = _letterKeys[letter];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppHeight.s4),
            // Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.s14),
              child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState:
                    _isSearching
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                firstChild: Text(
                  'Dictionary',
                  style: getBoldStyle(
                    fontSize: FontSize.s24,
                    fontFamily: FontConstants.interFamily,
                    color: ColorManager.primaryText,
                  ),
                ),
                secondChild: Text(
                  'Search',
                  style: getBoldStyle(
                    fontSize: FontSize.s24,
                    fontFamily: FontConstants.interFamily,
                    color: ColorManager.primaryText,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppHeight.s12),

            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.s14),
              child: PersistentSearchBar(
                isSearching: _isSearching,
                onSearchStart: _onSearchStart,
                onSearchClose: _onSearchClose,
              ),
            ),
            SizedBox(height: AppHeight.s16),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _isSearching
                    ? Padding(
                      padding:  EdgeInsets.symmetric(horizontal: AppWidth.s16),
                      child: const SearchView(key: ValueKey('search')),
                    )
                    : _buildDictionaryContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDictionaryContent() {
    return Column(
      key: const ValueKey('dictionary'),
      children: [
        SizedBox(
          height: AppHeight.s32,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppWidth.s16),
            itemCount: _categories.length,
            separatorBuilder: (_, __) => SizedBox(width: AppWidth.s10),
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = _selectedCategory == category;
              return GestureDetector(
                onTap: () => setState(() => _selectedCategory = category),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: AppWidth.s15),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? ColorManager.tealSoft
                            : ColorManager.lightGrey,
                    borderRadius: BorderRadius.circular(AppRadius.s32),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    category,
                    style: getRegularStyle(
                      fontSize: FontSize.s14,
                      fontFamily: FontConstants.interFamily,
                      color:
                          isSelected
                              ? ColorManager.primaryText
                              : ColorManager.secondaryText,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: AppHeight.s18),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.only(
                    left: AppWidth.s21,
                    right: AppWidth.s4,
                  ),
                  itemCount: _alphabet.length,
                  itemBuilder: (context, index) {
                    final letter = _alphabet[index];
                    final terms = _getTermsForLetter(letter);
                    if (terms.isEmpty) return const SizedBox.shrink();
                    return Column(
                      key: _letterKeys[letter],
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          letter,
                          style: getBoldStyle(
                            fontSize: FontSize.s20,
                            fontFamily: FontConstants.interFamily,
                            color: ColorManager.primaryText,
                          ),
                        ),
                        ...terms.map(
                          (term) => RecentlyViewedItem(
                            title: term.title,
                            category: term.category,
                          ),
                        ),
                        SizedBox(height: AppHeight.s24),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                width: AppWidth.s20,
                child: ListView.builder(
                  itemCount: _alphabet.length,
                  padding: EdgeInsets.symmetric(vertical: AppHeight.s4),
                  itemBuilder: (context, index) {
                    final letter = _alphabet[index];
                    final hasTerms = _getTermsForLetter(letter).isNotEmpty;
                    return GestureDetector(
                      onTap: hasTerms ? () => _scrollToLetter(letter) : null,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: AppHeight.s8),
                        child: Text(
                          letter,
                          textAlign: TextAlign.center,
                          style: getRegularStyle(
                            fontSize: FontSize.s8,
                            fontFamily: FontConstants.interFamily,
                            color:
                                hasTerms
                                    ? ColorManager.primary
                                    : ColorManager.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
              SizedBox(height: AppHeight.s80,)

      ],
    );
  }

  List<MedicalTerm> _getTermsForLetter(String letter) {
    final allTerms = [
      MedicalTerm(title: 'Anatomy', category: 'Basic Science', letter: 'A'),
      MedicalTerm(title: 'Anesthesia', category: 'Procedure', letter: 'A'),
      MedicalTerm(title: 'Antibiotics', category: 'Pharmacology', letter: 'A'),
      MedicalTerm(title: 'Arrhythmia', category: 'Cardiology', letter: 'A'),
      MedicalTerm(title: 'Biopsy', category: 'Procedure', letter: 'B'),
      MedicalTerm(title: 'Cardiology', category: 'Specialty', letter: 'C'),
    ];
    return allTerms
        .where((term) => term.letter == letter)
        .where(
          (term) =>
              _selectedCategory == 'All' || term.category == _selectedCategory,
        )
        .toList();
  }
}

class MedicalTerm {
  final String title;
  final String category;
  final String letter;
  final String? imagePath;

  MedicalTerm({
    required this.title,
    required this.category,
    required this.letter,
    this.imagePath,
  });
}
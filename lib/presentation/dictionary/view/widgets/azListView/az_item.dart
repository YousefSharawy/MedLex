import 'package:azlistview/azlistview.dart';
import 'package:transly/domain/models.dart';
import 'package:transly/presentation/dictionary/view/widgets/azListView/az_list_constants.dart';

class AzItem extends ISuspensionBean {
  final TermModel? term;
  final String tag;
  final bool isLoadingIndicator;

  AzItem({
    this.term,
    required this.tag,
    this.isLoadingIndicator = false,
  });

  @override
  String getSuspensionTag() => tag;

  static String getFirstLetter(String term) {
    if (term.isEmpty) return '#';
    final firstChar = term[0].toUpperCase();
    return AzListConstants.letterRegex.hasMatch(firstChar) ? firstChar : '#';
  }
}
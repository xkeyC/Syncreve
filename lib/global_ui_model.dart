import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base/ui_model.dart';

final globalUIModel = AppGlobalUIModel();
final globalUIModelProvider = ChangeNotifierProvider((ref) => globalUIModel);

class AppGlobalUIModel extends BaseUIModel {

}
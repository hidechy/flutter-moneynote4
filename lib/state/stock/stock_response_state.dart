import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/assets_data.dart';
import '../../models/stock.dart';
import '../../models/stock_record.dart';

part 'stock_response_state.freezed.dart';

@freezed
class StockResponseState with _$StockResponseState {
  const factory StockResponseState({
    Stock? lastStock,
    StockRecord? lastStockRecord,
    @Default({}) Map<String, AssetsData> stockMap,
  }) = _StockResponseState;
}

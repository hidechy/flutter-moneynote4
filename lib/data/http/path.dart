enum APIPath {
  amazonPurchase,
  bankSearch,
  getAllBank,
  benefit,
  uccardspend,
  getYearCreditSummarySummary,
  getcompanycredit,
  getDutyData,
  getgolddata,
  getholiday,
  homeFix,
  mercaridata,
  moneydl,
  getEverydayMoney,
  moneyinsert,
  seiyuuPurchaseList,
  getDataShintaku,
  monthsummary,
  getmonthSpendItem,
  getYearSpend,
  getYearSpendSummaySummary,
  getDataStock,
  getmonthlytimeplace,
  gettrainrecord,
  yearsummary,
  getUdemyData,
  updateBankMoney,
  setBankMove,
  getBankMove,
  timeplacezerousedate,
  getSeiyuuPurchaseItemList,
  balanceSheetRecord,
  carditemlist,
  getSamedaySpend,
  getWellsRecord,
  spendItemInsert,
  timeplaceInsert
}

extension APIPathExtension on APIPath {
  String? get value {
    switch (this) {
      case APIPath.amazonPurchase:
        return 'amazonPurchaseList';
      case APIPath.bankSearch:
        return 'bankSearch';
      case APIPath.getAllBank:
        return 'getAllBank';
      case APIPath.benefit:
        return 'benefit';
      case APIPath.uccardspend:
        return 'uccardspend';
      case APIPath.getYearCreditSummarySummary:
        return 'getYearCreditSummarySummary';
      case APIPath.getcompanycredit:
        return 'getcompanycredit';
      case APIPath.getDutyData:
        return 'getDutyData';
      case APIPath.getgolddata:
        return 'getgolddata';
      case APIPath.getholiday:
        return 'getholiday';
      case APIPath.homeFix:
        return 'homeFix';
      case APIPath.mercaridata:
        return 'mercaridata';
      case APIPath.moneydl:
        return 'moneydl';
      case APIPath.getEverydayMoney:
        return 'getEverydayMoney';
      case APIPath.moneyinsert:
        return 'moneyinsert';
      case APIPath.seiyuuPurchaseList:
        return 'seiyuuPurchaseList';
      case APIPath.getDataShintaku:
        return 'getDataShintaku';
      case APIPath.monthsummary:
        return 'monthsummary';
      case APIPath.getmonthSpendItem:
        return 'getmonthSpendItem';
      case APIPath.getYearSpend:
        return 'getYearSpend';
      case APIPath.getYearSpendSummaySummary:
        return 'getYearSpendSummaySummary';
      case APIPath.getDataStock:
        return 'getDataStock';
      case APIPath.getmonthlytimeplace:
        return 'getmonthlytimeplace';
      case APIPath.gettrainrecord:
        return 'gettrainrecord';
      case APIPath.yearsummary:
        return 'yearsummary';
      case APIPath.getUdemyData:
        return 'getUdemyData';
      case APIPath.updateBankMoney:
        return 'updateBankMoney';
      case APIPath.setBankMove:
        return 'setBankMove';
      case APIPath.getBankMove:
        return 'getBankMove';
      case APIPath.timeplacezerousedate:
        return 'timeplacezerousedate';
      case APIPath.getSeiyuuPurchaseItemList:
        return 'getSeiyuuPurchaseItemList';
      case APIPath.balanceSheetRecord:
        return 'balanceSheetRecord';
      case APIPath.carditemlist:
        return 'carditemlist';
      case APIPath.getSamedaySpend:
        return 'getSamedaySpend';
      case APIPath.getWellsRecord:
        return 'getWellsRecord';
      case APIPath.spendItemInsert:
        return 'spendItemInsert';
      case APIPath.timeplaceInsert:
        return 'timeplaceInsert';
    }
  }
}

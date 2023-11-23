enum APIPath {
  amazonPurchase,
  balanceSheetRecord,
  bankSearch,
  benefit,
  carditemlist,
  getAllBank,
  getBankMove,
  getcompanycredit,
  getDataShintaku,
  getDataStock,
  getDutyData,
  getEverydayMoney,
  getgolddata,
  getholiday,
  getMonthlyBankRecord,
  getmonthlytimeplace,
  getmonthSpendItem,
  getSamedaySpend,
  getSeiyuuPurchaseItemList,
  getSpendCheckItem,
  gettrainrecord,
  getUdemyData,
  getWellsRecord,
  getYearCreditSummarySummary,
  getYearSpend,
  getYearSpendSummaySummary,
  homeFix,
  inputSpendCheckItem,
  mercaridata,
  moneydl,
  moneyinsert,
  monthsummary,
  seiyuuPurchaseList,
  setBankMove,
  spendItemInsert,
  timeplaceInsert,
  timeplacezerousedate,
  uccardspend,
  updateBankMoney,
  yearsummary,
  updateKeihiCategory,
  selectSpendCheckItem,
  inputTaxPaymentItem,
  getTaxPaymentItem,
  getAllMoney,
  getTimeLocation,
  getSameYearMonthDay,
  getAllTemple,
  getAllStation,
  getTempleDatePhoto,
  getTempleLatLng,
  getLifetimeRecordItem,
  insertLifetime,
  getLifetimeDateRecord,
  getLifetimeYearlyRecord,
  getWalkRecord2,
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
      case APIPath.inputSpendCheckItem:
        return 'inputSpendCheckItem';
      case APIPath.getSpendCheckItem:
        return 'getSpendCheckItem';
      case APIPath.getMonthlyBankRecord:
        return 'getMonthlyBankRecord';
      case APIPath.updateKeihiCategory:
        return 'updateKeihiCategory';
      case APIPath.selectSpendCheckItem:
        return 'selectSpendCheckItem';
      case APIPath.inputTaxPaymentItem:
        return 'inputTaxPaymentItem';
      case APIPath.getTaxPaymentItem:
        return 'getTaxPaymentItem';
      case APIPath.getAllMoney:
        return 'getAllMoney';
      case APIPath.getTimeLocation:
        return 'getTimeLocation';
      case APIPath.getSameYearMonthDay:
        return 'getSameYearMonthDay';
      case APIPath.getAllTemple:
        return 'getAllTemple';
      case APIPath.getAllStation:
        return 'getAllStation';
      case APIPath.getTempleDatePhoto:
        return 'getTempleDatePhoto';
      case APIPath.getTempleLatLng:
        return 'getTempleLatLng';
      case APIPath.getLifetimeRecordItem:
        return 'getLifetimeRecordItem';
      case APIPath.insertLifetime:
        return 'insertLifetime';
      case APIPath.getLifetimeDateRecord:
        return 'getLifetimeDateRecord';
      case APIPath.getLifetimeYearlyRecord:
        return 'getLifetimeYearlyRecord';
      case APIPath.getWalkRecord2:
        return 'getWalkRecord2';
    }
  }
}

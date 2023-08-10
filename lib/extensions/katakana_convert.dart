// ignore_for_file: parameter_assignments

String halfKatakanaToFullLength({required String val}) {
  val = val.replaceAllMapped(RegExp('[ｳｶ-ﾄﾊ-ﾎ]ﾞ'), (Match m) {
    final dakuten = <String, String>{
      'ｳﾞ': 'ヴ',
      'ｶﾞ': 'ガ',
      'ｷﾞ': 'ギ',
      'ｸﾞ': 'グ',
      'ｹﾞ': 'ゲ',
      'ｺﾞ': 'ゴ',
      'ｻﾞ': 'ザ',
      'ｼﾞ': 'ジ',
      'ｽﾞ': 'ズ',
      'ｾﾞ': 'ゼ',
      'ｿﾞ': 'ゾ',
      'ﾀﾞ': 'ダ',
      'ﾁﾞ': 'ヂ',
      'ﾂﾞ': 'ヅ',
      'ﾃﾞ': 'デ',
      'ﾄﾞ': 'ド',
      'ﾊﾞ': 'バ',
      'ﾋﾞ': 'ビ',
      'ﾌﾞ': 'ブ',
      'ﾍﾞ': 'ベ',
      'ﾎﾞ': 'ボ',
    };

    return dakuten[m.group(0)!] ?? m.group(0)!;
  });

  val = val.replaceAllMapped(RegExp('[ﾊ-ﾎ]ﾟ'), (Match m) {
    final handakuten = <String, String>{
      'ﾊﾟ': 'パ',
      'ﾋﾟ': 'ピ',
      'ﾌﾟ': 'プ',
      'ﾍﾟ': 'ペ',
      'ﾎﾟ': 'ポ',
    };
    return handakuten[m.group(0)!] ?? m.group(0)!;
  });

  val = val.replaceAllMapped(RegExp('[ｦ-ﾝｰ]'), (Match m) {
    final other = <String, String>{
      'ｱ': 'ア',
      'ｲ': 'イ',
      'ｳ': 'ウ',
      'ｴ': 'エ',
      'ｵ': 'オ',
      'ｧ': 'ァ',
      'ｨ': 'ィ',
      'ｩ': 'ゥ',
      'ｪ': 'ェ',
      'ｫ': 'ォ',
      'ｶ': 'カ',
      'ｷ': 'キ',
      'ｸ': 'ク',
      'ｹ': 'ケ',
      'ｺ': 'コ',
      'ｻ': 'サ',
      'ｼ': 'シ',
      'ｽ': 'ス',
      'ｾ': 'セ',
      'ｿ': 'ソ',
      'ﾀ': 'タ',
      'ﾁ': 'チ',
      'ﾂ': 'ツ',
      'ﾃ': 'テ',
      'ﾄ': 'ト',
      'ﾅ': 'ナ',
      'ﾆ': 'ニ',
      'ﾇ': 'ヌ',
      'ﾈ': 'ネ',
      'ﾉ': 'ノ',
      'ﾊ': 'ハ',
      'ﾋ': 'ヒ',
      'ﾌ': 'フ',
      'ﾍ': 'ヘ',
      'ﾎ': 'ホ',
      'ﾏ': 'マ',
      'ﾐ': 'ミ',
      'ﾑ': 'ム',
      'ﾒ': 'メ',
      'ﾓ': 'モ',
      'ﾔ': 'ヤ',
      'ﾕ': 'ユ',
      'ﾖ': 'ヨ',
      'ﾗ': 'ラ',
      'ﾘ': 'リ',
      'ﾙ': 'ル',
      'ﾚ': 'レ',
      'ﾛ': 'ロ',
      'ﾜ': 'ワ',
      'ｦ': 'ヲ',
      'ﾝ': 'ン',
      'ｯ': 'ッ',
      'ｬ': 'ャ',
      'ｭ': 'ュ',
      'ｮ': 'ョ',
      'ｰ': 'ー',
    };
    return other[m.group(0)!] ?? m.group(0)!;
  });

  return val;
}
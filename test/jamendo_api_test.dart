import 'package:flutter_test/flutter_test.dart';
import 'package:senada/core/data/jamendo_api.dart';

void main() {
  test('unescapeHtml mengembalikan entitas HTML dari Jamendo', () {
    expect(unescapeHtml('John Dada &amp; the Weathermen'), 'John Dada & the Weathermen');
    expect(unescapeHtml('Don&#39;t &quot;Stop&quot;'), 'Don\'t "Stop"');
    expect(unescapeHtml('caf&#xE9;'), 'café');
    expect(unescapeHtml('&lt;3'), '<3');
    expect(unescapeHtml('&amp;lt;'), '&lt;'); // tidak di-unescape dua kali
    expect(unescapeHtml('&#99999999999;'), '&#99999999999;'); // kode tak valid dibiarkan
    expect(unescapeHtml('tanpa entitas'), 'tanpa entitas');
  });
}

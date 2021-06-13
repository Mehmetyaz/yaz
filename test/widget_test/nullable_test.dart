




import 'package:flutter_test/flutter_test.dart';
import 'package:yaz/src/listenable/listenable.dart';
import 'package:yaz/yaz.dart';
void main(){



  group("nullable test", ()  {


   test("nullable", () async {
     var myNotifier = YazNotifier<int?>(null);
     var count = 0;

     myNotifier.addListener(() {
       count++;
     });
     await Future.delayed(const Duration(milliseconds: 300));
     myNotifier.value = 0;
     expect(myNotifier.value, equals(0));
     expect(count, equals(1));
   });




  });





}
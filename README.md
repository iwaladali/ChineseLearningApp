# flutter\_project

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

* [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
* [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
* [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



📁 models/



🔹 تمثل البيانات اللي بتستخدمها في كل التطبيق (كلمة، فاكهة، نطق، نتائج التقييم).



مثلاً:



class Word {

&#x20; final String id;

&#x20; final String text;

&#x20; final String imageUrl;

&#x20; final String audioUrl;



&#x20; Word({required this.id, required this.text, required this.imageUrl, required this.audioUrl});

}



💡 Models فقط “تمثيل بيانات”، ما فيها منطق تواصل مع الـ Firebase.



📁 services/



📌 هنا تضع كل الوظائف اللي تتعامل مع Firebase + APIs.



مثال:



FirebaseService (Firestore)

StorageService (رفع الصور/الصوت)

SpeechService (تقييم النطق – SpeechSuper/Whisper)

TranslationService (ترجمة النص)



📍 كل تواصل مباشر مع Firebase/API يصير هنا (مش في UI).

مثال:



class FirebaseService {

&#x20; Future<List<Word>> getWords() async { ... }

}

📁 screens/



📌 هنا صفحات التطبيق — كل صفحة UI (Widget) مستقلة.

مثال:



/screens

&#x20; - home\_screen.dart

&#x20; - vocabulary\_screen.dart

&#x20; - pronunciation\_screen.dart

&#x20; - speak\_screen.dart

&#x20; - progress\_screen.dart



📍 كل صفحة هنا تتعامل مع Providers/State فقط ولا تتصل مباشرة بـ Firebase.



📁 providers/ (أو blocs/ لو تستعمل Bloc)



📌 هذا المكان اللي تتحط فيه المنطق اللي يربط بين UI والـ services



مثل Provider أو Bloc — مسؤول عن:

✔ جلب البيانات من الـ service

✔ تحديث الـ UI عند تغيّر القيم

✔ تعامل مع حالات Loading/Success/Error



💡 مثال بسيط (Provider):



class WordsProvider with ChangeNotifier {

&#x20; List<Word> words = \[];

&#x20; bool isLoading = false;



&#x20; loadWords() async {

&#x20;   isLoading = true;

&#x20;   notifyListeners();

&#x20;   words = await FirebaseService().getWords();

&#x20;   isLoading = false;

&#x20;   notifyListeners();

&#x20; }

}

📁 widgets/



📌 هنا تضع Widgets اللي تتكرر في أكثر من صفحة

مثل:

✔️ Cards للكلمة

✔️ Buttons مخصصة

✔️ Widget لتقييم النطق

✔️ Loading Spinner



هذا يساعدك تعيد استخدام الكود بدل تكراره.



📁 utils/



📌 وظائف مساعدة عامة

مثل:

✔️ تحويل النص

✔️ helper functions

✔️ configurations



📁 main.dart



📌 نقطة دخول التطبيق — تهيئة كل شيء

هنا:

✔ initialize Firebase

✔ تهيئة Providers / Bloc

✔ runApp



مثال سريع:



void main() async {

&#x20; WidgetsFlutterBinding.ensureInitialized();

&#x20; await Firebase.initializeApp();



&#x20; runApp(

&#x20;   MultiProvider(

&#x20;     providers: \[

&#x20;       ChangeNotifierProvider(create: (\_) => WordsProvider()),

&#x20;     ],

&#x20;     child: MyApp(),

&#x20;   ),

&#x20; );

}

📌 ليش هذه الهيكلية كويسة؟



✅ سهلة الفهم 👶



كل فولدر له غرض واضح



✅ قابلة للتطوير لاحقًا 🛠️



إذا المشروع كبر، تقدر بعدها تطوّرها لـ Clean Architecture أصغر



✅ UI منفصل عن الـ Data/API logic



الـ screens ما تعرف من أين تأتي البيانات

Providers يتعاملون مع services فقط

→ هذا يقلل الالتباس ويخلي الكود نظيف.

📌 مثال تدفق بسيط للبيانات



1️⃣ المستخدم يفتح صفحة VocabularyScreen

2️⃣ الصفحة تستدعي Provider

3️⃣ Provider يستدعي FirebaseService

4️⃣ FirebaseService يرجّع الكلمات

5️⃣ Provider يحدث الحالة

6️⃣ UI يعرض الكلمات



📌 هذا يعني:



UI ما تتصل بـ Firebase مباشرة

فقط الـ services تتصل بـ Firebase

Providers هم الوسطاء بين الـ UI و الـ Data

📌 بعدين لو بدك تتطور



يمكنك إضافة طبقة Domain أو UseCases لو المشروع صار كبير جدًا.

لكن حاليًا المهم البساطة والمفهومية 🔑



إذا بدك، اقدر أعمل لك مخطط بصري (Flowchart) يوضح كيف تتحرك البيانات من الواجهة إلى Firebase وبالعكس، خطوة بخطوة.


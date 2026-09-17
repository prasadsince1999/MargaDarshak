import 'app_locale.dart';

/// Lightweight, compile-time offline bilingual/multilingual dictionary for Margadarshak.
class AppStrings {
  const AppStrings._();

  static String tr(String key, AppLanguage lang) {
    final map = _translations[key];
    if (map == null) return key;
    return map[lang] ?? map[AppLanguage.english] ?? key;
  }

  static const Map<String, Map<AppLanguage, String>> _translations = {
    'app_name': {
      AppLanguage.english: 'MĀRGADARSHAK',
      AppLanguage.hindi: 'मार्गदर्शक',
      AppLanguage.odia: 'ମାର୍ଗଦର୍ଶକ',
      AppLanguage.telugu: 'మార్గదర్శక్',
      AppLanguage.tamil: 'மார்கதர்ஷக்',
      AppLanguage.bengali: 'মার্গদর্শক',
      AppLanguage.marathi: 'मार्गदर्शक',
      AppLanguage.kannada: 'ಮಾರ್ಗದರ್ಶಕ್',
    },
    'tagline': {
      AppLanguage.english:
          'Free, verified, offline-first career navigation for India.',
      AppLanguage.hindi:
          'भारत के लिए निःशुल्क, सत्यापित, ऑफ़लाइन करियर मार्गदर्शन।',
      AppLanguage.odia:
          'ଭାରତ ପାଇଁ ମାଗଣା, ଯାଞ୍ଚ ହୋଇଥିବା ଅଫଲାଇନ୍ କ୍ୟାରିଅର୍ ମାର୍ଗଦର୍ଶନ।',
      AppLanguage.telugu:
          'భారతదేశం కోసం ఉచిత, ధృవీకరించబడిన ఆఫ్‌లైన్ కెరీర్ నావిగేషన్.',
      AppLanguage.tamil:
          'இந்தியாவிற்கான இலவச, சரிபார்க்கப்பட்ட ஆஃப்லைன் தொழில் வழிகாட்டுதல்.',
      AppLanguage.bengali:
          'ভারতের জন্য বিনামূল্যে, যাচাইকৃত অফলাইন ক্যারিয়ার নেভিগেশন।',
      AppLanguage.marathi:
          'भारतासाठी मोफत, पडताळणी केलेले ऑफलाइन करिअर मार्गदर्शन.',
      AppLanguage.kannada:
          'ಭಾರತಕ್ಕಾಗಿ ಉಚಿತ, ಪರಿಶೀಲಿಸಿದ ಆಫ್‌ಲೈನ್ ವೃತ್ತಿ ಮಾರ್ಗದರ್ಶನ.',
    },
    'nav_home': {
      AppLanguage.english: 'HOME',
      AppLanguage.hindi: 'होम',
      AppLanguage.odia: 'ହୋମ୍',
      AppLanguage.telugu: 'హోమ్',
      AppLanguage.tamil: 'முகப்பு',
      AppLanguage.bengali: 'হোম',
      AppLanguage.marathi: 'होम',
      AppLanguage.kannada: 'ಮುಖಪುಟ',
    },
    'nav_explore': {
      AppLanguage.english: 'EXPLORE',
      AppLanguage.hindi: 'खोजें',
      AppLanguage.odia: 'ଅନୁସନ୍ଧାନ',
      AppLanguage.telugu: 'అన్వేషించండి',
      AppLanguage.tamil: 'ஆராய்க',
      AppLanguage.bengali: 'অন্বেষণ',
      AppLanguage.marathi: 'शोधा',
      AppLanguage.kannada: 'ಅನ್ವೇಷಿಸಿ',
    },
    'nav_roadmaps': {
      AppLanguage.english: 'ROADMAPS',
      AppLanguage.hindi: 'रोडमैप',
      AppLanguage.odia: 'ରୋଡମ୍ୟାପ୍',
      AppLanguage.telugu: 'రోడ్‌మ్యాప్‌లు',
      AppLanguage.tamil: 'வழிகாட்டி',
      AppLanguage.bengali: 'রোডম্যাপ',
      AppLanguage.marathi: 'रोडमॅप्स',
      AppLanguage.kannada: 'ಮಾರ್ಗಸೂಚಿಗಳು',
    },
    'nav_profile': {
      AppLanguage.english: 'PROFILE',
      AppLanguage.hindi: 'प्रोफ़ाइल',
      AppLanguage.odia: 'ପ୍ରୋଫାଇଲ୍',
      AppLanguage.telugu: 'ప్రొఫైల్',
      AppLanguage.tamil: 'சுயவிவரம்',
      AppLanguage.bengali: 'প্রোফাইল',
      AppLanguage.marathi: 'प्रोफाइल',
      AppLanguage.kannada: 'ಪ್ರೊಫೈಲ್',
    },
    'nav_colleges': {
      AppLanguage.english: 'COLLEGES',
      AppLanguage.hindi: 'कॉलेज',
      AppLanguage.odia: 'କଲେଜ୍',
      AppLanguage.telugu: 'కళాశాలలు',
      AppLanguage.tamil: 'கல்லூரிகள்',
      AppLanguage.bengali: 'কলেজ',
      AppLanguage.marathi: 'महाविद्यालये',
      AppLanguage.kannada: 'ಕಾಲೇಜುಗಳು',
    },
    'goal_bridge_title': {
      AppLanguage.english: 'GOAL BRIDGE',
      AppLanguage.hindi: 'लक्ष्य सेतु (गोल ब्रिज)',
      AppLanguage.odia: 'ଲକ୍ଷ୍ୟ ସେତୁ',
      AppLanguage.telugu: 'లక్ష్య వంతెన',
      AppLanguage.tamil: 'இலக்கு பாலம்',
      AppLanguage.bengali: 'লক্ষ্য সেতু',
      AppLanguage.marathi: 'ध्येय सेतू',
      AppLanguage.kannada: 'ಗುರಿ ಸೇತುವೆ',
    },
    'exam_stack_title': {
      AppLanguage.english: 'EXAM STACK PLANNER',
      AppLanguage.hindi: 'परीक्षा स्टैक प्लानर',
      AppLanguage.odia: 'ପରୀକ୍ଷା ଷ୍ଟାକ୍ ପ୍ଲାନର୍',
      AppLanguage.telugu: 'పరీక్షల స్టాక్ ప్లానర్',
      AppLanguage.tamil: 'தேர்வு அடுக்கு திட்டம்',
      AppLanguage.bengali: 'পরীক্ষা স্ট্যাক প্ল্যানার',
      AppLanguage.marathi: 'परीक्षा स्टॅक प्लॅनर',
      AppLanguage.kannada: 'ಪರೀಕ್ಷಾ ಸ್ಟ್ಯಾಕ್ ಯೋಜಕ',
    },
    'common_ground': {
      AppLanguage.english: 'COMMON GROUND',
      AppLanguage.hindi: 'समान आधार',
      AppLanguage.odia: 'ସାଧାରଣ ଆଧାର',
      AppLanguage.telugu: 'సాధారణ మైదానం',
      AppLanguage.tamil: 'பொதுவான தளம்',
      AppLanguage.bengali: 'সাধারণ ভিত্তি',
      AppLanguage.marathi: 'समान पाया',
      AppLanguage.kannada: 'ಸಾಮಾನ್ಯ ಆಧಾರ',
    },
    'shared_subjects': {
      AppLanguage.english: 'SHARED SUBJECTS',
      AppLanguage.hindi: 'साझा विषय',
      AppLanguage.odia: 'ଅଂଶୀଦାର ବିଷୟଗୁଡ଼ିକ',
      AppLanguage.telugu: 'భాగస్వామ్య సబ్జెక్టులు',
      AppLanguage.tamil: 'பகிரப்பட்ட பாடங்கள்',
      AppLanguage.bengali: 'শেয়ার করা বিষয়',
      AppLanguage.marathi: 'सामायिक विषय',
      AppLanguage.kannada: 'ಹಂಚಿಕೊಂಡ ವಿಷಯಗಳು',
    },
    'for_the_student': {
      AppLanguage.english: 'FOR THE STUDENT',
      AppLanguage.hindi: 'छात्र के लिए',
      AppLanguage.odia: 'ଛାତ୍ରଙ୍କ ପାଇଁ',
      AppLanguage.telugu: 'విద్యార్థి కోసం',
      AppLanguage.tamil: 'மாணவருக்கு',
      AppLanguage.bengali: 'ছাত্রের জন্য',
      AppLanguage.marathi: 'विद्यार्थ्यांसाठी',
      AppLanguage.kannada: 'ವಿದ್ಯಾರ್ಥಿಗಾಗಿ',
    },
    'for_the_parent': {
      AppLanguage.english: 'FOR THE PARENT',
      AppLanguage.hindi: 'अभिभावक के लिए',
      AppLanguage.odia: 'ଅଭିଭାବକଙ୍କ ପାଇଁ',
      AppLanguage.telugu: 'తల్లిదండ్రుల కోసం',
      AppLanguage.tamil: 'பெற்றோருக்கு',
      AppLanguage.bengali: 'অভিভাবকের জন্য',
      AppLanguage.marathi: 'पालकांसाठी',
      AppLanguage.kannada: 'ಪೋಷಕರಿಗಾಗಿ',
    },
    'single_prep': {
      AppLanguage.english: 'SINGLE PREPARATION',
      AppLanguage.hindi: 'एकल तैयारी',
      AppLanguage.odia: 'ଗୋଟିଏ ପ୍ରସ୍ତୁତି',
      AppLanguage.telugu: 'ఒకే తయారీ',
      AppLanguage.tamil: 'ஒற்றை தயாரிப்பு',
      AppLanguage.bengali: 'একক প্রস্তুতি',
      AppLanguage.marathi: 'एकच तयारी',
      AppLanguage.kannada: 'ಒಂದೇ ತಯಾರಿ',
    },
    'switch_language': {
      AppLanguage.english: 'CHANGE LANGUAGE',
      AppLanguage.hindi: 'भाषा बदलें',
      AppLanguage.odia: 'ଭାଷା ବଦଳାନ୍ତୁ',
      AppLanguage.telugu: 'భాషను మార్చండి',
      AppLanguage.tamil: 'மொழியை மாற்றவும்',
      AppLanguage.bengali: 'ভাষা পরিবর্তন করুন',
      AppLanguage.marathi: 'भाषा बदला',
      AppLanguage.kannada: 'ಭಾಷೆಯನ್ನು ಬದಲಾಯಿಸಿ',
    },
    'scholarships_title': {
      AppLanguage.english: 'SCHOLARSHIPS & AID',
      AppLanguage.hindi: 'छात्रवृत्ति एवं वित्तीय सहायता',
      AppLanguage.odia: 'ଛାତ୍ରବୃତ୍ତି ଏବଂ ସହାୟତା',
      AppLanguage.telugu: 'స్కాలర్‌షిప్‌లు & సహాయం',
      AppLanguage.tamil: 'உதவித்தொகை & நிதி உதவி',
      AppLanguage.bengali: 'বৃত্তি এবং আর্থিক সাহায্য',
      AppLanguage.marathi: 'शिष्यवृत्ती आणि मदत',
      AppLanguage.kannada: 'ವಿದ್ಯಾರ್ಥಿವೇತನಗಳು ಮತ್ತು ನೆರವು',
    },
    'documents_radar_title': {
      AppLanguage.english: 'DOCUMENTS RADAR',
      AppLanguage.hindi: 'दस्तावेज़ सत्यापन रडार',
      AppLanguage.odia: 'ଦଲିଲ ଯାଞ୍ଚ ରାଡାର',
      AppLanguage.telugu: 'పత్రాల రాడార్',
      AppLanguage.tamil: 'ஆவணங்கள் ரேடார்',
      AppLanguage.bengali: 'নথি যাচাই রাডার',
      AppLanguage.marathi: 'कागदपत्रे रडार',
      AppLanguage.kannada: 'ದಾಖಲೆಗಳ ರಾಡಾರ್',
    },
    'april_1_warning': {
      AppLanguage.english:
          'CRUCIAL: OBC-NCL & EWS certificates must be dated on or after April 1 of the admission financial year.',
      AppLanguage.hindi:
          'महत्वपूर्ण: ओबीसी-एनसीएल और ईडब्ल्यूएस प्रमाण पत्र प्रवेश वित्तीय वर्ष के 1 अप्रैल के बाद के होने चाहिए।',
      AppLanguage.odia:
          'ଗୁରୁତ୍ୱପୂର୍ଣ୍ଣ: OBC-NCL ଏବଂ EWS ସାର୍ଟିଫିକେଟ୍ ପ୍ରବେଶ ଆର୍ଥିକ ବର୍ଷର ଏପ୍ରିଲ ୧ ପରେ ଜାରି ହେବା ଆବଶ୍ୟକ।',
      AppLanguage.telugu:
          'ముఖ్యమైనది: OBC-NCL & EWS సర్టిఫికెట్లు ప్రవేశ ఆర్థిక సంవత్సరం ఏప్రిల్ 1న లేదా ఆ తర్వాత జారీ చేయబడాలి.',
      AppLanguage.tamil:
          'முக்கியமானது: OBC-NCL & EWS சான்றிதழ்கள் சேர்க்கை நிதியாண்டின் ஏப்ரல் 1 அல்லது அதற்குப் பிறகு தேதியிடப்பட்டிருக்க வேண்டும்.',
      AppLanguage.bengali:
          'জরুরী: OBC-NCL এবং EWS শংসাপত্রগুলি অবশ্যই ভর্তির আর্থিক বছরের ১ এপ্রিল বা তার পরে তারিখযুক্ত হতে হবে।',
      AppLanguage.marathi:
          'महत्त्वाचे: OBC-NCL आणि EWS प्रमाणपत्रे प्रवेश आर्थिक वर्षाच्या १ एप्रिल रोजी किंवा नंतरची असावीत.',
      AppLanguage.kannada:
          'ಮುಖ್ಯವಾದದ್ದು: OBC-NCL & EWS ಪ್ರಮಾಣಪತ್ರಗಳು ಪ್ರವೇಶ ಹಣಕಾಸು ವರ್ಷದ ಏಪ್ರಿಲ್ 1 ರಂದು ಅಥವಾ ನಂತರ ದಿನಾಂಕವನ್ನು ಹೊಂದಿರಬೇಕು.',
    },
    'offline_engine_badge': {
      AppLanguage.english: '100% OFFLINE BHARAT ENGINE',
      AppLanguage.hindi: '100% ऑफ़लाइन भारत इंजन',
      AppLanguage.odia: '୧୦୦% ଅଫଲାଇନ୍ ଭାରତ ଇଞ୍ଜିନ୍',
      AppLanguage.telugu: '100% ఆఫ్‌లైన్ భారత్ ఇంజిన్',
      AppLanguage.tamil: '100% ஆஃப்லைன் பாரத் எஞ்சின்',
      AppLanguage.bengali: '১০০% অফলাইন ভারত ইঞ্জিন',
      AppLanguage.marathi: '१००% ऑफलाइन भारत इंजिन',
      AppLanguage.kannada: '100% ಆಫ್‌ಲೈನ್ ಭಾರತ್ ಎಂಜಿನ್',
    },
  };
}

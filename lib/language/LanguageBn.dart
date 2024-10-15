// import 'BaseLanguage.dart';

// class LanguageBn extends BaseLanguage {
//   @override
//   String get appName => 'শক্তিশালী রাইডার';
//   @override
//   String get thisFieldRequired => 'ঘরটি অবশ্যই পূরণ করতে হবে';
//   @override
//   String get email => 'ইমেল';
//   @override
//   String get password => 'পাসওয়ার্ড';
//   @override
//   String get forgotPassword => 'পাসওয়ার্ড ভুলে গেছেন?';
//   @override
//   String get logIn => 'প্রবেশ করুন';
//   @override
//   String get orLogInWith => 'বা সাথে লগইন';
//   @override
//   String get donHaveAnAccount => 'কোন অ্যাকাউন্ট নেই?';
//   @override
//   String get signUp => 'নিবন্ধন করুন';
//   @override
//   String get createAccount => 'হিসাব তৈরি কর';
//   @override
//   String get firstName => 'নামের প্রথম অংশ';
//   @override
//   String get lastName => 'নামের শেষাংশ';
//   @override
//   String get userName => 'ব্যবহারকারীর নাম';
//   @override
//   String get phoneNumber => 'ফোন নম্বর';
//   @override
//   String get alreadyHaveAnAccount => 'ইতিমধ্যে একটি সদস্যপদ আছে?';
//   @override
//   String get changePassword => 'পাসওয়ার্ড পরিবর্তন করুন';
//   @override
//   String get oldPassword => 'পুরানো পাসওয়ার্ড';
//   @override
//   String get newPassword => 'নতুন পাসওয়ার্ড';
//   @override
//   String get confirmPassword => 'পাসওয়ার্ড নিশ্চিত করুন';
//   @override
//   String get passwordDoesNotMatch => 'পাসওয়ার্ড মেলে না';
//   @override
//   String get passwordInvalid => 'সর্বনিম্ন পাসওয়ার্ডের দৈর্ঘ্য 8 হওয়া উচিত';
//   @override
//   String get yes => 'হ্যাঁ';
//   @override
//   String get no => 'না';
//   @override
//   String get writeMessage => 'বার্তা লিখুন';
//   @override
//   String get enterTheEmailAssociatedWithYourAccount =>
//       'আপনার অ্যাকাউন্টের সাথে সম্পর্কিত ইমেলটি প্রবেশ করান';
//   @override
//   String get submit => 'জমা দিন';
//   @override
//   String get language => 'ভাষা';
//   @override
//   String get notification => 'বিজ্ঞপ্তি';
//   @override
//   String get useInCaseOfEmergency => 'জরুরী ক্ষেত্রে ব্যবহার করুন';
//   @override
//   String get notifyAdmin => 'অ্যাডমিনকে অবহিত করুন';
//   @override
//   String get notifiedSuccessfully => 'সফলভাবে অবহিত';
//   @override
//   String get complain => 'অভিযোগ';
//   @override
//   String get pleaseEnterSubject => 'বিষয় লিখুন দয়া করে';
//   @override
//   String get writeDescription => 'একটি বিবরণ লিখুন ....';
//   @override
//   String get saveComplain => 'অভিযোগ সংরক্ষণ করুন';
//   @override
//   String get editProfile => 'জীবন বৃত্তান্ত সম্পাদনা';
//   @override
//   String get address => 'ঠিকানা';
//   @override
//   String get updateProfile => 'প্রফাইল হালনাগাদ';
//   @override
//   String get notChangeUsername =>
//       'আপনি ব্যবহারকারীর নাম পরিবর্তন করতে পারবেন না';
//   @override
//   String get notChangeEmail => 'আপনি ইমেল আইডি পরিবর্তন করতে পারবেন না';
//   @override
//   String get profileUpdateMsg => 'প্রোফাইল সফলভাবে আপডেট করা হয়েছে';
//   @override
//   String get emergencyContact => 'জরুরী যোগাযোগ';
//   @override
//   String get areYouSureYouWantDeleteThisNumber =>
//       'আপনি কি নিশ্চিত যে আপনি এই নম্বরটি মুছতে চান?';
//   @override
//   String get addContact => 'পরিচিতি যোগ করুন';
//   @override
//   String get save => 'সংরক্ষণ';
//   @override
//   String get availableBalance => 'পর্যাপ্ত টাকা';
//   @override
//   String get recentTransactions => 'সাম্প্রতিক লেনদেন';
//   @override
//   String get moneyDeposited => 'অর্থ জমা';
//   @override
//   String get addMoney => 'টাকা যোগ করুন';
//   @override
//   String get cancel => 'বাতিল';
//   @override
//   String get pleaseSelectAmount => 'পরিমাণ নির্বাচন করুন';
//   @override
//   String get amount => 'পরিমাণ';
//   @override
//   String get capacity => 'ক্ষমতা';
//   @override
//   String get paymentMethod => 'মূল্যপরিশোধ পদ্ধতি';
//   @override
//   String get chooseYouPaymentLate =>
//       'এখনই বা দেরিতে আপনার অর্থ প্রদান চয়ন করুন';
//   @override
//   String get enterPromoCode => 'প্রচার কোড লিখুন';
//   @override
//   String get confirm => 'নিশ্চিত করুন';
//   @override
//   String get forInstantPayment => 'তাত্ক্ষণিক অর্থ প্রদানের জন্য';
//   @override
//   String get bookNow => 'এখনই বুক করুন';
//   @override
//   String get wallet => 'ওয়ালেট';
//   @override
//   String get paymentDetail => 'অর্থ প্রদানের বিশদ';
//   @override
//   String get rideId => 'রাইড আইডি';
//   @override
//   String get viewHistory => 'ইতিহাস দেখ';
//   @override
//   String get paymentDetails => 'পেমেন্ট বিবরণ';
//   @override
//   String get paymentType => 'শোধের ধরণ';
//   @override
//   String get paymentStatus => 'লেনদেনের অবস্থা';
//   @override
//   String get priceDetail => 'মূল্য বিশদ';
//   @override
//   String get basePrice => 'মুলদাম';
//   @override
//   String get distancePrice => 'দূরত্বের দাম';
//   @override
//   String get waitTime => 'অপেক্ষা করার সময়';
//   @override
//   String get extraCharges => 'অতিরিক্ত চার্জ';
//   @override
//   String get couponDiscount => 'কুপন ছাড়';
//   @override
//   String get total => 'মোট';
//   @override
//   String get payment => 'অর্থ প্রদান';
//   @override
//   String get cash => 'নগদ';
//   @override
//   String get updatePaymentStatus => 'অর্থ প্রদানের স্থিতি আপডেট করুন';
//   @override
//   String get waitingForDriverConformation =>
//       'ড্রাইভার নিশ্চিতকরণের জন্য অপেক্ষা করছি';
//   @override
//   String get continueNewRide => 'নতুন যাত্রা চালিয়ে যান';
//   @override
//   String get payToPayment => 'অর্থ প্রদান';
//   @override
//   String get tip => 'টিপ';
//   @override
//   String get pay => 'পে';
//   @override
//   String get howWasYourRide => 'আপনার যাত্রা কেমন ছিল?';
//   @override
//   String get wouldYouLikeToAddTip => 'আপনি কি টিপ যুক্ত করতে চান?';
//   @override
//   String get addMoreTip => 'আরও টিপ যোগ করুন';
//   @override
//   String get addMore => 'আরো যোগ করো';
//   @override
//   String get addReviews => 'পর্যালোচনা যুক্ত করুন';
//   @override
//   String get writeYourComments => 'আপনার পর্যালোচনা লিখুন ....';
//   @override
//   String get continueD => 'চালিয়ে যান';
//   @override
//   String get aboutDriver => 'ড্রাইভার সম্পর্কে';
//   @override
//   String get rideHistory => 'রাইড ইতিহাস';
//   @override
//   String get emergencyContacts => 'জরুরী যোগাযোগ';
//   @override
//   String get logOut => 'প্রস্থান';
//   @override
//   String get areYouSureYouWantToLogoutThisApp =>
//       'আপনি কি নিশ্চিত যে আপনি এই অ্যাপটি লগআউট করতে চান?';
//   @override
//   String get whatWouldYouLikeToGo => 'আপনি কোথায় যেতে চান?';
//   @override
//   String get enterYourDestination => 'আপনার গন্তব্য প্রবেশ করুন';
//   @override
//   String get currentLocation => 'এখন যেখানে আছ';
//   @override
//   String get destinationLocation => 'গন্তব্য অবস্থান';
//   @override
//   String get chooseOnMap => 'মানচিত্রে চয়ন করুন';
//   @override
//   String get profile => 'প্রোফাইল';
//   @override
//   String get privacyPolicy => 'গোপনীয়তা নীতি';
//   @override
//   String get helpSupport => 'সাহায্য সহযোগীতা';
//   @override
//   String get termsConditions => 'শর্তাবলী';
//   @override
//   String get aboutUs => 'আমাদের সম্পর্কে';
//   @override
//   String get lookingForNearbyDrivers => 'কাছাকাছি ড্রাইভার খুঁজছেন';
//   @override
//   String get weAreLookingForNearDriversAcceptsYourRide =>
//       'আমরা আপনার যাত্রায় \ nccepts জন্য কাছাকাছি ড্রাইভার খুঁজছি';
//   @override
//   String get get => 'পাওয়া';
//   @override
//   String get rides => 'রাইডস';
//   @override
//   String get people => 'মানুষ';
//   @override
//   String get done => 'সম্পন্ন';
//   @override
//   String get availableOffers => 'উপলব্ধ অফার';
//   @override
//   String get off => 'বন্ধ';
//   @override
//   String get sendOTP => 'ওটিপি প্রেরণ করুন';
//   @override
//   String get carModel => 'গাড়ী মডেল';
//   @override
//   String get sos => 'Sos';
//   @override
//   String get driverReview => 'ড্রাইভার পর্যালোচনা';
//   @override
//   String get signInUsingYourMobileNumber =>
//       'আপনার \ nmobile নম্বর ব্যবহার করে সাইন ইন করুন';
//   @override
//   String get otp => 'ওটিপি';
//   @override
//   String get newRideRequested => 'নতুন রাইড অনুরোধ';
//   @override
//   String get accepted => 'গৃহীত';
//   @override
//   String get arriving => 'আগমন';
//   @override
//   String get arrived => 'পৌঁছেছে';
//   @override
//   String get inProgress => 'চলমান';
//   @override
//   String get cancelled => 'বাতিল';
//   @override
//   String get completed => 'সম্পূর্ণ';
//   @override
//   String get pleaseEnableLocationPermission =>
//       'দয়া করে অবস্থানের অনুমতি সক্ষম করুন';
//   @override
//   String get pending => 'বিচারাধীন';
//   @override
//   String get failed => 'ব্যর্থ';
//   @override
//   String get paid => 'প্রদত্ত';
//   @override
//   String get male => 'পুরুষ';
//   @override
//   String get female => 'মহিলা';
//   @override
//   String get other => 'অন্য';
//   @override
//   String get deleteAccount => 'হিসাব মুছে ফেলা';
//   @override
//   String get account => 'অ্যাকাউন্ট';
//   @override
//   String get areYouSureYouWantPleaseReadAffect =>
//       'আপনি আপনার অ্যাকাউন্ট মুছে ফেলতে চান আপনি কি নিশ্চিত? অ্যাকাউন্ট মুছে ফেলার প্রভাব ফেলবে দয়া করে পড়ুন।';
//   @override
//   String get deletingAccountEmail =>
//       'আপনার অ্যাকাউন্ট মুছে ফেলা আমাদের ডাটাবেস থেকে ব্যক্তিগত তথ্য সরিয়ে দেয়। আপনার ইমেল স্থায়ীভাবে সংরক্ষিত হয়ে যায় এবং একই ইমেলটি নতুন অ্যাকাউন্ট নিবন্ধন করতে পুনরায় ব্যবহার করা যায় না';
//   @override
//   String get areYouSureYouWantDeleteAccount =>
//       'আপনি কি অ্যাকাউন্ট মুছতে চান তা নিশ্চিত?';
//   @override
//   String get yourInternetIsNotWorking => 'আপনার ইন্টারনেট কাজ করছে না';
//   @override
//   String get allow => 'অনুমতি দিন';
//   @override
//   String get mostReliableMightyRiderApp =>
//       'সবচেয়ে নির্ভরযোগ্য শক্তিশালী রাইডার অ্যাপ';
//   @override
//   String get toEnjoyYourRideExperiencePleaseAllowPermissions =>
//       'আপনার রাইডের অভিজ্ঞতা উপভোগ করতে \ n দয়া করে আমাদের নিম্নলিখিত অনুমতিগুলি অনুমতি দিন';
//   @override
//   String get txtURLEmpty => 'ইউআরএল খালি';
//   @override
//   String get lblFollowUs => 'আমাদের অনুসরণ করো';
//   @override
//   String get duration => 'সময়কাল';
//   @override
//   String get paymentVia => 'মাধ্যমে প্রদান';
//   @override
//   String get demoMsg =>
//       'পরীক্ষকের ভূমিকা এই ক্রিয়াটি সম্পাদন করার অনুমতি দেয় না';
//   @override
//   String get findPlace => 'একটি জায়গা সন্ধান করুন ...';
//   @override
//   String get pleaseWait => 'অনুগ্রহপূর্বক অপেক্ষা করুন';
//   @override
//   String get selectPlace => 'জায়গা নির্বাচন করুন';
//   @override
//   String get placeNotInArea => 'জায়গা না জায়গায়';
//   @override
//   String get youCannotChangePhoneNumber =>
//       'আপনি ফোন নম্বর পরিবর্তন করতে পারবেন না';
//   @override
//   String get complainList => 'অভিযোগ তালিকা';
//   @override
//   String get writeMsg => 'বার্তা লিখুন';
//   @override
//   String get pleaseEnterMsg => 'বার্তা লিখুন';
//   @override
//   String get viewAll => 'সব দেখ';
//   @override
//   String get pleaseSelectRating => 'রেটিং নির্বাচন করুন';
//   @override
//   String get moneyDebit => 'অর্থ ডেবিট';
//   @override
//   String get pleaseAcceptTermsOfServicePrivacyPolicy =>
//       'পরিষেবা এবং গোপনীয়তা নীতি শর্তান';
//   @override
//   String get rememberMe => 'আমাকে মনে কর';
//   @override
//   String get iAgreeToThe => 'আমি একমত';
//   @override
//   String get driverInformation => 'ড্রাইভারের তথ্য';
//   @override
//   String get nameFieldIsRequired => 'নাম ক্ষেত্র প্রয়োজন';
//   @override
//   String get phoneNumberIsRequired => 'ফোন নম্বর প্রয়োজন';
//   @override
//   String get enterName => 'নাম লিখুন';
//   @override
//   String get enterContactNumber => 'যোগাযোগ নম্বর লিখুন';
//   @override
//   String get invoice => 'চালান';
//   @override
//   String get customerName => 'ক্রেতার নাম';
//   @override
//   String get sourceLocation => 'উত্স অবস্থান';
//   @override
//   String get invoiceNo => 'চালান নং';
//   @override
//   String get invoiceDate => 'চালান তারিখ';
//   @override
//   String get orderedDate => 'অর্ডার তারিখ';
//   @override
//   String get lblCarNumberPlate => 'গাড়ি নম্বর প্লেট';
//   @override
//   String get lblRide => 'যাত্রা';
//   @override
//   String get lblRideInformation => 'যাত্রা তথ্য';
//   @override
//   String get lblWhereAreYou => 'তুমি কোথায়?';
//   @override
//   String get lblDropOff => 'ড্রপ অফ';
//   @override
//   String get lblDistance => 'দূরত্ব:';
//   @override
//   String get lblSomeoneElse => 'অন্য কেউ';
//   @override
//   String get lblYou => 'আপনি';
//   @override
//   String get lblWhoRidingMsg =>
//       'রাইডারটি নিশ্চিত করুন এবং ভ্রমণের তথ্য নিশ্চিত করুন';
//   @override
//   String get lblNext => 'পরবর্তী';
//   @override
//   String get lblLessWalletAmount =>
//       'দ্রষ্টব্য: আপনার মানিব্যাগে আপনার অপর্যাপ্ত ভারসাম্য রয়েছে। অন্যথায় পরিমাণ যুক্ত করুন, আপনাকে নগদ অর্থের মাধ্যমে দিতে হবে।';
//   @override
//   String get lblPayWhenEnds => 'যখন ট্রিপ শেষ হয়';
//   @override
//   String get maximum => 'সর্বাধিক';
//   @override
//   String get required => 'প্রয়োজনীয়';
//   @override
//   String get minimum => 'সর্বনিম্ন';
//   @override
//   String get withDraw => 'প্রত্যাহার';
//   @override
//   String get withdrawHistory => 'ইতিহাস প্রত্যাহার';
//   @override
//   String get approved => 'অনুমোদিত';
//   @override
//   String get requested => 'অনুরোধ';
//   @override
//   String get minimumFare => 'ন্যূনতম ভাড়া';
//   @override
//   String get cancelRide => 'যাত্রা বাতিল করুন';
//   @override
//   String get cancelledReason => 'বাতিল কারণ';
//   @override
//   String get selectReason => 'কারণ নির্বাচন করুন';
//   @override
//   String get writeReasonHere => 'এখানে কারণ লিখুন ...';
//   @override
//   String get driverGoingWrongDirection => 'ড্রাইভার ভুল দিকে যাচ্ছে';
//   @override
//   String get pickUpTimeTakingTooLong => 'খুব বেশি সময় নেওয়ার সময় তুলুন';
//   @override
//   String get driverAskedMeToCancel => 'ড্রাইভার আমাকে বাতিল করতে বলেছিল';
//   @override
//   String get others => 'অন্যান্য';
//   @override
//   String get baseFare => 'বেস ভাড়া';
//   @override
//   String get perDistance => 'দূরত্ব প্রতি';
//   @override
//   String get perMinDrive => 'প্রতি মিনিট ড্রাইভ';
//   @override
//   String get perMinWait => 'প্রতি মিনিট অপেক্ষা করুন';
//   @override
//   String get min => 'মিনিট';
//   @override
//   String get unsupportedPlateForm => 'অসমর্থিত প্ল্যাটফর্ম';
//   @override
//   String get invoiceCapital => 'চালান';
//   @override
//   String get description => 'বর্ণনা';
//   @override
//   String get price => 'দাম';
//   @override
//   String get gallery => 'গ্যালারী';
//   @override
//   String get camera => 'ক্যামেরা';
//   @override
//   String get bankInfoUpdated => 'ব্যাংক তথ্য সাফল্যের সাথে আপডেট';
//   @override
//   String get bankInfo => 'ব্যাংক তথ্য';
//   @override
//   String get bankName => 'ব্যাংকের নাম';
//   @override
//   String get bankCode => 'ব্যাংেকর সংকেতলিপি';
//   @override
//   String get accountHolderName => 'হিসাব দাতার নাম';
//   @override
//   String get accountNumber => 'হিসাব নাম্বার';
//   @override
//   String get updateBankDetail => 'ব্যাঙ্কের বিশদ আপডেট করুন';
//   @override
//   String get addBankDetail => 'ব্যাঙ্কের বিশদ যুক্ত করুন';
//   @override
//   String get locationNotAvailable => 'অবস্থান উপলব্ধ নেই';
//   @override
//   String get servicesNotFound => 'পরিষেবাগুলি পাওয়া যায় নি';
//   @override
//   String get paymentFailed => 'পেমেন্ট ব্যর্থ হয়েছে';
//   @override
//   String get checkConsoleForError => 'ত্রুটির জন্য কনসোল চেক করুন';
//   @override
//   String get transactionFailed => 'লেনদেন ব্যর্থ হয়েছে';
//   @override
//   String get transactionSuccessful => 'সফল লেনদেন';
//   @override
//   String get payWithCard => 'কার্ড দিয়ে প্রদান করুন';
//   @override
//   String get success => 'সাফল্য';
//   @override
//   String get skip => 'এড়িয়ে যান';
//   @override
//   String get declined => 'প্রত্যাখ্যান';
//   @override
//   String get validateOtp => 'ওটিপি বৈধ করুন';
//   @override
//   String get otpCodeHasBeenSentTo => 'ওটিপি কোড পাঠানো হয়েছে';
//   @override
//   String get pleaseEnterOtp =>
//       'আপনার মোবাইল নম্বর যাচাই করতে দয়া করে নীচে ওটিপি প্রবেশ করুন।';
//   @override
//   String get selectSources => 'উত্স নির্বাচন করুন';
//   @override
//   String get whoWillBeSeated => 'কে বসে থাকবে?';
//   @override
//   String get via => 'মাধ্যমে';
//   @override
//   String get status => 'স্থিতি';
//   @override
//   String get riderInformation => 'রাইডার তথ্য';
//   @override
//   String get minutePrice => 'মিনিট দাম';
//   @override
//   String get waitingTimePrice => 'অপেক্ষা সময় মূল্য';
//   @override
//   String get additionalFees => 'অতিরিক্ত খরচ';
//   @override
//   String get settings => 'সেটিংস';
//   @override
//   String get welcome => 'স্বাগত,';
//   @override
//   String get signContinue => 'চালিয়ে যেতে সাইন ইন করুন';
//   @override
//   String get passwordLength => 'পাসওয়ার্ড দৈর্ঘ্য কমপক্ষে 8 হওয়া উচিত';
//   @override
//   String get bothPasswordNotMatch => 'উভয় পাসওয়ার্ড মিলে যাওয়া উচিত';
//   @override
//   String get missingBankDetail =>
//       'অনুপস্থিত ব্যাঙ্কের বিশদ। প্রত্যাহারের পরিমাণের জন্য আপনার প্রোফাইলটি সম্পূর্ণ করুন';
//   @override
//   String get close => 'বন্ধ';
//   @override
//   String get copied => 'অনুলিপি!';
// }

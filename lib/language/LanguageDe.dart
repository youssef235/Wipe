// import 'BaseLanguage.dart';

// class LanguageDe extends BaseLanguage {
//   @override
//   String get appName => 'Mächtiger Fahrer';
//   @override
//   String get thisFieldRequired => 'Dieses Feld ist erforderlich';
//   @override
//   String get email => 'Email';
//   @override
//   String get password => 'Passwort';
//   @override
//   String get forgotPassword => 'Passwort vergessen?';
//   @override
//   String get logIn => 'Anmeldung';
//   @override
//   String get orLogInWith => 'Oder melden Sie sich mit';
//   @override
//   String get donHaveAnAccount => 'Keinen Konto haben?';
//   @override
//   String get signUp => 'Melden Sie sich an';
//   @override
//   String get createAccount => 'Benutzerkonto erstellen';
//   @override
//   String get firstName => 'Vorname';
//   @override
//   String get lastName => 'Familienname, Nachname';
//   @override
//   String get userName => 'Nutzername';
//   @override
//   String get phoneNumber => 'Telefonnummer';
//   @override
//   String get alreadyHaveAnAccount => 'Sie haben bereits ein Konto?';
//   @override
//   String get changePassword => 'Kennwort ändern';
//   @override
//   String get oldPassword => 'Altes Passwort';
//   @override
//   String get newPassword => 'Neues Kennwort';
//   @override
//   String get confirmPassword => 'Bestätige das Passwort';
//   @override
//   String get passwordDoesNotMatch => 'Passwort stimmt nicht überein';
//   @override
//   String get passwordInvalid => 'Die Mindestkennwortlänge sollte 8 betragen';
//   @override
//   String get yes => 'Ja';
//   @override
//   String get no => 'NEIN';
//   @override
//   String get writeMessage => 'Nachricht schreiben';
//   @override
//   String get enterTheEmailAssociatedWithYourAccount =>
//       'Geben Sie die E -Mail ein, die Ihrem Konto zugeordnet ist';
//   @override
//   String get submit => 'Einreichen';
//   @override
//   String get language => 'Sprache';
//   @override
//   String get notification => 'Benachrichtigung';
//   @override
//   String get useInCaseOfEmergency => 'Verwendung im Notfall';
//   @override
//   String get notifyAdmin => 'Admin benachrichtigen';
//   @override
//   String get notifiedSuccessfully => 'Erfolgreich benachrichtigt';
//   @override
//   String get complain => 'Beschweren';
//   @override
//   String get pleaseEnterSubject => 'Bitte geben Sie Betreff ein';
//   @override
//   String get writeDescription => 'Schreibe eine Beschreibung....';
//   @override
//   String get saveComplain => 'Sparen Sie sich Beschwerden';
//   @override
//   String get editProfile => 'Profil bearbeiten';
//   @override
//   String get address => 'Adresse';
//   @override
//   String get updateProfile => 'Profil aktualisieren';
//   @override
//   String get notChangeUsername => 'Sie können den Benutzernamen nicht ändern';
//   @override
//   String get notChangeEmail => 'Sie können keine E -Mail -ID ändern';
//   @override
//   String get profileUpdateMsg => 'Profil erfolgreich aktualisiert';
//   @override
//   String get emergencyContact => 'Notfallkontakt';
//   @override
//   String get areYouSureYouWantDeleteThisNumber =>
//       'Sind Sie sicher, dass Sie diese Nummer löschen möchten?';
//   @override
//   String get addContact => 'Kontakt hinzufügen';
//   @override
//   String get save => 'Speichern';
//   @override
//   String get availableBalance => 'Verfügbares Guthaben';
//   @override
//   String get recentTransactions => 'kürzliche Transaktionen';
//   @override
//   String get moneyDeposited => 'Geld hinterlegt';
//   @override
//   String get addMoney => 'Geld hinzufügen';
//   @override
//   String get cancel => 'Stornieren';
//   @override
//   String get pleaseSelectAmount => 'Bitte wählen Sie Betrag';
//   @override
//   String get amount => 'Menge';
//   @override
//   String get capacity => 'Kapazität';
//   @override
//   String get paymentMethod => 'Bezahlverfahren';
//   @override
//   String get chooseYouPaymentLate =>
//       'Wählen Sie Ihre Zahlung jetzt oder zu spät';
//   @override
//   String get enterPromoCode => 'Geben Sie den Promo -Code ein';
//   @override
//   String get confirm => 'Bestätigen';
//   @override
//   String get forInstantPayment => 'Zur sofortigen Zahlung';
//   @override
//   String get bookNow => 'buchen Sie jetzt';
//   @override
//   String get wallet => 'Geldbörse';
//   @override
//   String get paymentDetail => 'Zahlungsdetails';
//   @override
//   String get rideId => 'Ride ID';
//   @override
//   String get viewHistory => 'Siehe Verlauf';
//   @override
//   String get paymentDetails => 'Zahlungsdetails';
//   @override
//   String get paymentType => 'Zahlungsart';
//   @override
//   String get paymentStatus => 'Zahlungsstatus';
//   @override
//   String get priceDetail => 'Preisdetail';
//   @override
//   String get basePrice => 'Grundpreis';
//   @override
//   String get distancePrice => 'Entfernungspreis';
//   @override
//   String get waitTime => 'Wartezeit';
//   @override
//   String get extraCharges => 'Extrakosten';
//   @override
//   String get couponDiscount => 'Gutscheinrabatt';
//   @override
//   String get total => 'Gesamt';
//   @override
//   String get payment => 'Zahlung';
//   @override
//   String get cash => 'Kasse';
//   @override
//   String get updatePaymentStatus => 'Zahlungsstatus aktualisieren';
//   @override
//   String get waitingForDriverConformation =>
//       'Warten auf die Bestätigung des Fahrers';
//   @override
//   String get continueNewRide => 'Weitere Fahrt fortsetzen';
//   @override
//   String get payToPayment => 'Bezahlung für die Zahlung';
//   @override
//   String get tip => 'Tipp';
//   @override
//   String get pay => 'Zahlen';
//   @override
//   String get howWasYourRide => 'Wie war deine Fahrt?';
//   @override
//   String get wouldYouLikeToAddTip => 'Möchten Sie Tipp hinzufügen?';
//   @override
//   String get addMoreTip => 'Fügen Sie mehr Tipp hinzu';
//   @override
//   String get addMore => 'Fügen Sie mehr hinzu';
//   @override
//   String get addReviews => 'Bewertungen hinzufügen';
//   @override
//   String get writeYourComments => 'Schreiben Sie Ihre Bewertungen ....';
//   @override
//   String get continueD => 'Weitermachen';
//   @override
//   String get aboutDriver => 'Über den Fahrer';
//   @override
//   String get rideHistory => 'Fahrtgeschichte';
//   @override
//   String get emergencyContacts => 'Notfallkontakte';
//   @override
//   String get logOut => 'Ausloggen';
//   @override
//   String get areYouSureYouWantToLogoutThisApp =>
//       'Sind Sie sicher, dass Sie diese App abmelden möchten?';
//   @override
//   String get whatWouldYouLikeToGo => 'Wohin gehen Sie gerne?';
//   @override
//   String get enterYourDestination => 'Geben Sie Ihr Ziel ein';
//   @override
//   String get currentLocation => 'Aktueller Standort';
//   @override
//   String get destinationLocation => 'Zielort';
//   @override
//   String get chooseOnMap => 'Wählen Sie auf der Karte';
//   @override
//   String get profile => 'Profil';
//   @override
//   String get privacyPolicy => 'Datenschutzrichtlinie';
//   @override
//   String get helpSupport => 'Hilfe Unterstützung';
//   @override
//   String get termsConditions => 'Terms & amp; Bedingungen';
//   @override
//   String get aboutUs => 'Über uns';
//   @override
//   String get lookingForNearbyDrivers =>
//       'Auf der Suche nach nahe gelegenen Fahrern';
//   @override
//   String get weAreLookingForNearDriversAcceptsYourRide =>
//       'Wir suchen nach nahe gelegenen Fahrern, um Ihre Fahrt zu finden';
//   @override
//   String get get => 'Erhalten';
//   @override
//   String get rides => 'Fahrten';
//   @override
//   String get people => 'Menschen';
//   @override
//   String get done => 'Erledigt';
//   @override
//   String get availableOffers => 'Verfügbare Angebote';
//   @override
//   String get off => 'AUS';
//   @override
//   String get sendOTP => 'Senden Sie OTP';
//   @override
//   String get carModel => 'Auto Model';
//   @override
//   String get sos => 'SOS';
//   @override
//   String get driverReview => 'Treiberbewertung';
//   @override
//   String get signInUsingYourMobileNumber =>
//       'Melden Sie sich mit Ihrer \ nmobile Nummer an';
//   @override
//   String get otp => 'OTP';
//   @override
//   String get newRideRequested => 'Neue Fahrt angefordert';
//   @override
//   String get accepted => 'Akzeptiert';
//   @override
//   String get arriving => 'ankommen';
//   @override
//   String get arrived => 'Angekommen';
//   @override
//   String get inProgress => 'Im Gange';
//   @override
//   String get cancelled => 'Abgesagt';
//   @override
//   String get completed => 'Vollendet';
//   @override
//   String get pleaseEnableLocationPermission =>
//       'Bitte aktivieren Sie den Standortgenehmigung';
//   @override
//   String get pending => 'Ausstehend';
//   @override
//   String get failed => 'Fehlgeschlagen';
//   @override
//   String get paid => 'Bezahlt';
//   @override
//   String get male => 'Männlich';
//   @override
//   String get female => 'Weiblich';
//   @override
//   String get other => 'Andere';
//   @override
//   String get deleteAccount => 'Konto löschen';
//   @override
//   String get account => 'Konto';
//   @override
//   String get areYouSureYouWantPleaseReadAffect =>
//       'Sind Sie sicher, dass Sie Ihr Konto löschen möchten? Bitte lesen Sie, wie sich die Löschung des Kontos auswirkt.';
//   @override
//   String get deletingAccountEmail =>
//       'Durch das Löschen Ihres Kontos werden persönliche Daten aus unserer Datenbank entfernt. Ihre E-Mail wird dauerhaft reserviert und dieselbe E-Mail kann nicht wiederverwendet werden, um ein neues Konto zu registrieren';
//   @override
//   String get areYouSureYouWantDeleteAccount =>
//       'Sind Sie sicher, dass Sie Konto löschen möchten?';
//   @override
//   String get yourInternetIsNotWorking => 'Ihr Internet funktioniert nicht';
//   @override
//   String get allow => 'Erlauben';
//   @override
//   String get mostReliableMightyRiderApp => 'Die zuverlässige Mighty Rider App';
//   @override
//   String get toEnjoyYourRideExperiencePleaseAllowPermissions =>
//       'Um Ihr Fahrerlebnis zu genießen. Ermöglichen Sie uns die folgenden Berechtigungen';
//   @override
//   String get txtURLEmpty => 'URL ist leer';
//   @override
//   String get lblFollowUs => 'Folgen Sie uns';
//   @override
//   String get duration => 'Dauer';
//   @override
//   String get paymentVia => 'Zahlung über';
//   @override
//   String get demoMsg => 'Testerrolle nicht erlaubt, diese Aktion auszuführen';
//   @override
//   String get findPlace => 'Einen Ort finden...';
//   @override
//   String get pleaseWait => 'Bitte warten';
//   @override
//   String get selectPlace => 'Wählen Sie Platz aus';
//   @override
//   String get placeNotInArea => 'Nicht in der Gegend platzieren';
//   @override
//   String get youCannotChangePhoneNumber =>
//       'Sie können die Telefonnummer nicht ändern';
//   @override
//   String get complainList => 'Beschwerdeliste';
//   @override
//   String get writeMsg => 'Nachricht schreiben';
//   @override
//   String get pleaseEnterMsg => 'Bitte geben Sie eine Nachricht ein';
//   @override
//   String get viewAll => 'Alle ansehen';
//   @override
//   String get pleaseSelectRating => 'Bitte wählen Sie Bewertung';
//   @override
//   String get moneyDebit => 'Geldanlage';
//   @override
//   String get pleaseAcceptTermsOfServicePrivacyPolicy =>
//       'Bitte akzeptieren Sie die Nutzungsbedingungen für Service- und Datenschutzrichtlinien';
//   @override
//   String get rememberMe => 'Erinnere dich an mich';
//   @override
//   String get iAgreeToThe => 'Ich stimme dem zu';
//   @override
//   String get driverInformation => 'Fahrerinformationen';
//   @override
//   String get nameFieldIsRequired => 'Name des Namens ist erforderlich';
//   @override
//   String get phoneNumberIsRequired => 'Telefonnummer ist erforderlich';
//   @override
//   String get enterName => 'Name eingeben';
//   @override
//   String get enterContactNumber => 'Geben Sie die Kontaktnummer ein';
//   @override
//   String get invoice => 'Rechnung';
//   @override
//   String get customerName => 'Kundenname';
//   @override
//   String get sourceLocation => 'Quellenstandort';
//   @override
//   String get invoiceNo => 'Rechnung Nr';
//   @override
//   String get invoiceDate => 'Rechnungsdatum';
//   @override
//   String get orderedDate => 'Datum bestellt';
//   @override
//   String get lblCarNumberPlate => 'Autonummernschild';
//   @override
//   String get lblRide => 'Fahrt';
//   @override
//   String get lblRideInformation => 'Fahrinformationen';
//   @override
//   String get lblWhereAreYou => 'Wo bist du?';
//   @override
//   String get lblDropOff => 'Abbrechen';
//   @override
//   String get lblDistance => 'Distanz:';
//   @override
//   String get lblSomeoneElse => 'Jemand anderes';
//   @override
//   String get lblYou => 'Du';
//   @override
//   String get lblWhoRidingMsg =>
//       'Bestätigen Sie den Fahrer und stellen Sie sicher';
//   @override
//   String get lblNext => 'Nächste';
//   @override
//   String get lblLessWalletAmount =>
//       'Hinweis: Sie haben eine unzureichende Balance in Ihrer Brieftasche. Fügen Sie den Betrag hinzu, sonst müssen Sie über Bargeld bezahlen.';
//   @override
//   String get lblPayWhenEnds => 'Bezahlung, wenn die Reise endet';
//   @override
//   String get maximum => 'Maximal';
//   @override
//   String get required => 'erforderlich';
//   @override
//   String get minimum => 'Minimum';
//   @override
//   String get withDraw => 'Zurückziehen';
//   @override
//   String get withdrawHistory => 'Geschichte zurückziehen';
//   @override
//   String get approved => 'Genehmigt';
//   @override
//   String get requested => 'Angefordert';
//   @override
//   String get minimumFare => 'Mindestpreis';
//   @override
//   String get cancelRide => 'Fahrt abbrechen';
//   @override
//   String get cancelledReason => 'Stornierte Vernunft';
//   @override
//   String get selectReason => 'Wählen Sie Vernunft';
//   @override
//   String get writeReasonHere => 'Schreiben Sie hier Grund ...';
//   @override
//   String get driverGoingWrongDirection => 'Fahrer, der falsch geht';
//   @override
//   String get pickUpTimeTakingTooLong => 'Die Zeit zu lange dauert';
//   @override
//   String get driverAskedMeToCancel => 'Der Fahrer bat mich zu stornieren';
//   @override
//   String get others => 'Andere';
//   @override
//   String get baseFare => 'Grundfahrpreis';
//   @override
//   String get perDistance => 'Pro Entfernung';
//   @override
//   String get perMinDrive => 'Pro Minute Fahrt';
//   @override
//   String get perMinWait => 'Pro Minute warten';
//   @override
//   String get min => 'Mindest';
//   @override
//   String get unsupportedPlateForm => 'Nicht unterstützte Plattform';
//   @override
//   String get invoiceCapital => 'RECHNUNG';
//   @override
//   String get description => 'Beschreibung';
//   @override
//   String get price => 'Preis';
//   @override
//   String get gallery => 'Galerie';
//   @override
//   String get camera => 'Kamera';
//   @override
//   String get bankInfoUpdated => 'Bankinfo -Update erfolgreich';
//   @override
//   String get bankInfo => 'Bankinfo';
//   @override
//   String get bankName => 'Bank Name';
//   @override
//   String get bankCode => 'Bankleitzahl';
//   @override
//   String get accountHolderName => 'Name des Kontoinhabers';
//   @override
//   String get accountNumber => 'Accountnummer';
//   @override
//   String get updateBankDetail => 'Bankdetails aktualisieren';
//   @override
//   String get addBankDetail => 'Fügen Sie Bankdetails hinzu';
//   @override
//   String get locationNotAvailable => 'Standort nicht verfügbar';
//   @override
//   String get servicesNotFound => 'Dienstleistungen nicht gefunden';
//   @override
//   String get paymentFailed => 'Bezahlung fehlgeschlagen';
//   @override
//   String get checkConsoleForError => 'Überprüfen Sie die Konsole auf Fehler';
//   @override
//   String get transactionFailed => 'Transaktion fehlgeschlagen';
//   @override
//   String get transactionSuccessful => 'Transaktion Erfolgreich';
//   @override
//   String get payWithCard => 'Mit Karte bezahlen';
//   @override
//   String get success => 'Erfolg';
//   @override
//   String get skip => 'Überspringen';
//   @override
//   String get declined => 'Abgelehnt';
//   @override
//   String get validateOtp => 'Validieren Sie OTP';
//   @override
//   String get otpCodeHasBeenSentTo => 'OTP -Code wurde an gesendet an';
//   @override
//   String get pleaseEnterOtp =>
//       'Bitte geben Sie die OTP unten ein, um Ihre Handynummer zu überprüfen.';
//   @override
//   String get selectSources => 'Quellen auswählen';
//   @override
//   String get whoWillBeSeated => 'Wer wird sitzen?';
//   @override
//   String get via => 'Über';
//   @override
//   String get status => 'Status';
//   @override
//   String get riderInformation => 'Fahrerinformationen';
//   @override
//   String get minutePrice => 'Minute Preis';
//   @override
//   String get waitingTimePrice => 'Wartezeitpreis';
//   @override
//   String get additionalFees => 'Zusätzliche Gebühren';
//   @override
//   String get settings => 'Einstellungen';
//   @override
//   String get welcome => 'Willkommen,';
//   @override
//   String get signContinue => 'Sich anmelden, um fortzufahren';
//   @override
//   String get passwordLength => 'Die Passwortlänge sollte mindestens 8 sein';
//   @override
//   String get bothPasswordNotMatch => 'Beide Passwort sollten übereinstimmen';
//   @override
//   String get missingBankDetail =>
//       'Fehlende Bankdetails. Vervollständigen Sie Ihr Profil, um den Auszahlungsbetrag zu entsorgen';
//   @override
//   String get close => 'Schließen';
//   @override
//   String get copied => 'Kopiert!';
// }

// import 'BaseLanguage.dart';

// class LanguageEs extends BaseLanguage {
//   @override
//   String get appName => 'Mighty Rider';
//   @override
//   String get thisFieldRequired => 'Este campo es obligatorio';
//   @override
//   String get email => 'Correo electrónico';
//   @override
//   String get password => 'Contraseña';
//   @override
//   String get forgotPassword => '¿Has olvidado tu contraseña?';
//   @override
//   String get logIn => 'Acceso';
//   @override
//   String get orLogInWith => 'O iniciar sesión con';
//   @override
//   String get donHaveAnAccount => '¿No tienes una cuenta?';
//   @override
//   String get signUp => 'Inscribirse';
//   @override
//   String get createAccount => 'Crear una cuenta';
//   @override
//   String get firstName => 'Nombre de pila';
//   @override
//   String get lastName => 'Apellido';
//   @override
//   String get userName => 'Nombre de usuario';
//   @override
//   String get phoneNumber => 'Número de teléfono';
//   @override
//   String get alreadyHaveAnAccount => '¿Ya tienes una cuenta?';
//   @override
//   String get changePassword => 'Cambiar la contraseña';
//   @override
//   String get oldPassword => 'Contraseña anterior';
//   @override
//   String get newPassword => 'Nueva contraseña';
//   @override
//   String get confirmPassword => 'confirmar Contraseña';
//   @override
//   String get passwordDoesNotMatch => 'Las contraseñas no coinciden';
//   @override
//   String get passwordInvalid =>
//       'La longitud mínima de la contraseña debe ser 8';
//   @override
//   String get yes => 'Sí';
//   @override
//   String get no => 'No';
//   @override
//   String get writeMessage => 'Escribe un mensaje';
//   @override
//   String get enterTheEmailAssociatedWithYourAccount =>
//       'Ingrese el correo electrónico asociado con su cuenta';
//   @override
//   String get submit => 'Entregar';
//   @override
//   String get language => 'Idioma';
//   @override
//   String get notification => 'Notificación';
//   @override
//   String get useInCaseOfEmergency => 'Uso en caso de emergencia';
//   @override
//   String get notifyAdmin => 'Notificar a administrador';
//   @override
//   String get notifiedSuccessfully => 'Notificado con éxito';
//   @override
//   String get complain => 'Quejarse';
//   @override
//   String get pleaseEnterSubject => 'Por favor ingrese sujeto';
//   @override
//   String get writeDescription => 'Escriba una descripción....';
//   @override
//   String get saveComplain => 'Guardar quejarse';
//   @override
//   String get editProfile => 'Editar perfil';
//   @override
//   String get address => 'DIRECCIÓN';
//   @override
//   String get updateProfile => 'Actualización del perfil';
//   @override
//   String get notChangeUsername => 'No puedes cambiar el nombre de usuario';
//   @override
//   String get notChangeEmail =>
//       'No puede cambiar la identificación de correo electrónico';
//   @override
//   String get profileUpdateMsg => 'Perfil actualizado con éxito';
//   @override
//   String get emergencyContact => 'Contacto de emergencia';
//   @override
//   String get areYouSureYouWantDeleteThisNumber =>
//       '¿Estás seguro de que quieres eliminar este número?';
//   @override
//   String get addContact => 'Agregar contacto';
//   @override
//   String get save => 'Ahorrar';
//   @override
//   String get availableBalance => 'Saldo disponible';
//   @override
//   String get recentTransactions => 'Transacciones Recientes';
//   @override
//   String get moneyDeposited => 'Dinero depositado';
//   @override
//   String get addMoney => 'Agregar dinero';
//   @override
//   String get cancel => 'Cancelar';
//   @override
//   String get pleaseSelectAmount => 'Seleccione la cantidad';
//   @override
//   String get amount => 'Cantidad';
//   @override
//   String get capacity => 'Capacidad';
//   @override
//   String get paymentMethod => 'Método de pago';
//   @override
//   String get chooseYouPaymentLate => 'Elija su pago ahora o tarde';
//   @override
//   String get enterPromoCode => 'Introduce el código de promoción';
//   @override
//   String get confirm => 'Confirmar';
//   @override
//   String get forInstantPayment => 'Para pago instantáneo';
//   @override
//   String get bookNow => 'Reservar ahora';
//   @override
//   String get wallet => 'Billetera';
//   @override
//   String get paymentDetail => 'Detalles de pago';
//   @override
//   String get rideId => 'ID de viaje';
//   @override
//   String get viewHistory => 'Ver historial';
//   @override
//   String get paymentDetails => 'Detalles del pago';
//   @override
//   String get paymentType => 'Tipo de pago';
//   @override
//   String get paymentStatus => 'Estado de pago';
//   @override
//   String get priceDetail => 'Detalle del precio';
//   @override
//   String get basePrice => 'Precio base';
//   @override
//   String get distancePrice => 'Precio de distancia';
//   @override
//   String get waitTime => 'Tiempo de espera';
//   @override
//   String get extraCharges => 'Cargos extras';
//   @override
//   String get couponDiscount => 'Descuento de cupón';
//   @override
//   String get total => 'Total';
//   @override
//   String get payment => 'Pago';
//   @override
//   String get cash => 'Dinero';
//   @override
//   String get updatePaymentStatus => 'Actualizar el estado de pago';
//   @override
//   String get waitingForDriverConformation =>
//       'Esperando a la confirmación del conductor';
//   @override
//   String get continueNewRide => 'Continuar con un nuevo viaje';
//   @override
//   String get payToPayment => 'Pagar al pago';
//   @override
//   String get tip => 'Consejo';
//   @override
//   String get pay => 'Pagar';
//   @override
//   String get howWasYourRide => '¿Cómo estuvo tu viaje?';
//   @override
//   String get wouldYouLikeToAddTip => '¿Le gustaría agregar la propina?';
//   @override
//   String get addMoreTip => 'Agregar más consejo';
//   @override
//   String get addMore => 'Añadir más';
//   @override
//   String get addReviews => 'Agregar reseñas';
//   @override
//   String get writeYourComments => 'Escribe tus reseñas ....';
//   @override
//   String get continueD => 'Continuar';
//   @override
//   String get aboutDriver => 'Acerca del conductor';
//   @override
//   String get rideHistory => 'Historial de viaje';
//   @override
//   String get emergencyContacts => 'Contactos de emergencia';
//   @override
//   String get logOut => 'Cerrar sesión';
//   @override
//   String get areYouSureYouWantToLogoutThisApp =>
//       '¿Estás seguro de que quieres iniciar sesión en esta aplicación?';
//   @override
//   String get whatWouldYouLikeToGo => '¿A dónde te gustaría ir?';
//   @override
//   String get enterYourDestination => 'Ingrese su destino';
//   @override
//   String get currentLocation => 'Ubicación actual';
//   @override
//   String get destinationLocation => 'Ubicación de destino';
//   @override
//   String get chooseOnMap => 'Elija en el mapa';
//   @override
//   String get profile => 'Perfil';
//   @override
//   String get privacyPolicy => 'política de privacidad';
//   @override
//   String get helpSupport => 'Servicio de asistencia';
//   @override
//   String get termsConditions => 'Términos y condiciones';
//   @override
//   String get aboutUs => 'Sobre nosotros';
//   @override
//   String get lookingForNearbyDrivers => 'Buscando conductores cercanos';
//   @override
//   String get weAreLookingForNearDriversAcceptsYourRide =>
//       'Estamos buscando conductores cercanos para \ nacepts su viaje';
//   @override
//   String get get => 'Conseguir';
//   @override
//   String get rides => 'Paseos';
//   @override
//   String get people => 'Gente';
//   @override
//   String get done => 'Hecho';
//   @override
//   String get availableOffers => 'Ofertas disponibles';
//   @override
//   String get off => 'APAGADO';
//   @override
//   String get sendOTP => 'Enviar OTP';
//   @override
//   String get carModel => 'Modelo de auto';
//   @override
//   String get sos => 'LLAMADA DE SOCORRO';
//   @override
//   String get driverReview => 'Revisión del conductor';
//   @override
//   String get signInUsingYourMobileNumber =>
//       'Inicie sesión usando su número \ nmobile';
//   @override
//   String get otp => 'OTP';
//   @override
//   String get newRideRequested => 'Nuevo viaje solicitado';
//   @override
//   String get accepted => 'Aceptado';
//   @override
//   String get arriving => 'Que llega';
//   @override
//   String get arrived => 'Llegó';
//   @override
//   String get inProgress => 'En curso';
//   @override
//   String get cancelled => 'Cancelado';
//   @override
//   String get completed => 'Terminado';
//   @override
//   String get pleaseEnableLocationPermission => 'Activar permiso de ubicación';
//   @override
//   String get pending => 'Pendiente';
//   @override
//   String get failed => 'Fallido';
//   @override
//   String get paid => 'Pagado';
//   @override
//   String get male => 'Masculino';
//   @override
//   String get female => 'Femenino';
//   @override
//   String get other => 'Otro';
//   @override
//   String get deleteAccount => 'Borrar cuenta';
//   @override
//   String get account => 'Cuenta';
//   @override
//   String get areYouSureYouWantPleaseReadAffect =>
//       '¿Estás seguro de que quieres eliminar tu cuenta? Lea cómo afectará la eliminación de la cuenta.';
//   @override
//   String get deletingAccountEmail =>
//       'Eliminar su cuenta elimina la información personal de nuestra base de datos. Su correo electrónico se reserva permanentemente y el mismo correo electrónico no puede reutilizarse para registrar una nueva cuenta';
//   @override
//   String get areYouSureYouWantDeleteAccount =>
//       '¿Estás seguro de que quieres eliminar la cuenta?';
//   @override
//   String get yourInternetIsNotWorking => 'Tu Internet no funciona';
//   @override
//   String get allow => 'Permitir';
//   @override
//   String get mostReliableMightyRiderApp =>
//       'Aplicación Mighty Rider más confiable';
//   @override
//   String get toEnjoyYourRideExperiencePleaseAllowPermissions =>
//       'Para disfrutar de su experiencia de viaje \ nlease nos permita los siguientes permisos';
//   @override
//   String get txtURLEmpty => 'URL está vacía';
//   @override
//   String get lblFollowUs => 'Síganos';
//   @override
//   String get duration => 'Duración';
//   @override
//   String get paymentVia => 'Pago a través de';
//   @override
//   String get demoMsg => 'El rol de probador no se permite realizar esta acción';
//   @override
//   String get findPlace => 'Encontrar un lugar...';
//   @override
//   String get pleaseWait => 'Espere por favor';
//   @override
//   String get selectPlace => 'Seleccionar lugar';
//   @override
//   String get placeNotInArea => 'Coloque no en el área';
//   @override
//   String get youCannotChangePhoneNumber =>
//       'No puedes cambiar el número de teléfono';
//   @override
//   String get complainList => 'Lista de quejas';
//   @override
//   String get writeMsg => 'Escribe un mensaje';
//   @override
//   String get pleaseEnterMsg => 'Por favor ingrese el mensaje';
//   @override
//   String get viewAll => 'Ver todo';
//   @override
//   String get pleaseSelectRating => 'Seleccione la calificación';
//   @override
//   String get moneyDebit => 'Débito de dinero';
//   @override
//   String get pleaseAcceptTermsOfServicePrivacyPolicy =>
//       'Acepte los términos de la política de servicio y privacidad';
//   @override
//   String get rememberMe => 'Acuérdate de mí';
//   @override
//   String get iAgreeToThe => 'Estoy de acuerdo con la';
//   @override
//   String get driverInformation => 'Información del conductor';
//   @override
//   String get nameFieldIsRequired => 'Se requiere un campo de nombre';
//   @override
//   String get phoneNumberIsRequired => 'Se requiere número de teléfono';
//   @override
//   String get enterName => 'Ingrese su nombre';
//   @override
//   String get enterContactNumber => 'Ingrese el número de contacto';
//   @override
//   String get invoice => 'Factura';
//   @override
//   String get customerName => 'Nombre del cliente';
//   @override
//   String get sourceLocation => 'Ubicación de origen';
//   @override
//   String get invoiceNo => 'Factura no';
//   @override
//   String get invoiceDate => 'Fecha de la factura';
//   @override
//   String get orderedDate => 'Fecha ordenada';
//   @override
//   String get lblCarNumberPlate => 'Matrícula de coche';
//   @override
//   String get lblRide => 'Conducir';
//   @override
//   String get lblRideInformation => 'Información de viaje';
//   @override
//   String get lblWhereAreYou => '¿Dónde estás?';
//   @override
//   String get lblDropOff => 'Dejar';
//   @override
//   String get lblDistance => 'Distancia:';
//   @override
//   String get lblSomeoneElse => 'Alguien más';
//   @override
//   String get lblYou => 'Tú';
//   @override
//   String get lblWhoRidingMsg =>
//       'Confirme al jinete y asegúrese de que la información del viaje';
//   @override
//   String get lblNext => 'Próximo';
//   @override
//   String get lblLessWalletAmount =>
//       'Nota: tiene un equilibrio insuficiente en su billetera. Agregue la cantidad de lo contrario, debe pagar en efectivo.';
//   @override
//   String get lblPayWhenEnds => 'Pagar cuando termina el viaje';
//   @override
//   String get maximum => 'Máximo';
//   @override
//   String get required => 'requerido';
//   @override
//   String get minimum => 'Mínimo';
//   @override
//   String get withDraw => 'Retirar';
//   @override
//   String get withdrawHistory => 'Retirar el historial';
//   @override
//   String get approved => 'Aprobado';
//   @override
//   String get requested => 'Solicitado';
//   @override
//   String get minimumFare => 'Tarifa mínima';
//   @override
//   String get cancelRide => 'Cancelar Ride';
//   @override
//   String get cancelledReason => 'Razón cancelada';
//   @override
//   String get selectReason => 'Razón de selección';
//   @override
//   String get writeReasonHere => 'Escribe la razón aquí ...';
//   @override
//   String get driverGoingWrongDirection => 'Conductor yendo mal dirección';
//   @override
//   String get pickUpTimeTakingTooLong => 'El tiempo de recogida tarda demasiado';
//   @override
//   String get driverAskedMeToCancel => 'El conductor me pidió que cancelara';
//   @override
//   String get others => 'Otros';
//   @override
//   String get baseFare => 'Tarifa base';
//   @override
//   String get perDistance => 'Por distancia';
//   @override
//   String get perMinDrive => 'Por minuto';
//   @override
//   String get perMinWait => 'Por minuto espera';
//   @override
//   String get min => 'mínimo';
//   @override
//   String get unsupportedPlateForm => 'Plataforma no compatible';
//   @override
//   String get invoiceCapital => 'FACTURA';
//   @override
//   String get description => 'Descripción';
//   @override
//   String get price => 'Precio';
//   @override
//   String get gallery => 'Galería';
//   @override
//   String get camera => 'Cámara';
//   @override
//   String get bankInfoUpdated =>
//       'Actualización de información bancaria correctamente';
//   @override
//   String get bankInfo => 'Información bancaria';
//   @override
//   String get bankName => 'Nombre del banco';
//   @override
//   String get bankCode => 'Codigo bancario';
//   @override
//   String get accountHolderName => 'nombre del titular de la cuenta';
//   @override
//   String get accountNumber => 'Número de cuenta';
//   @override
//   String get updateBankDetail => 'Actualizar detalles del banco';
//   @override
//   String get addBankDetail => 'Agregar detalles del banco';
//   @override
//   String get locationNotAvailable => 'Ubicación no disponible';
//   @override
//   String get servicesNotFound => 'Servicios no encontrados';
//   @override
//   String get paymentFailed => 'Pago fallido';
//   @override
//   String get checkConsoleForError => 'Verifique la consola en busca de error';
//   @override
//   String get transactionFailed => 'Transacción fallida';
//   @override
//   String get transactionSuccessful => 'Transacción exitosa';
//   @override
//   String get payWithCard => 'Pagar con tarjeta';
//   @override
//   String get success => 'Éxito';
//   @override
//   String get skip => 'Saltar';
//   @override
//   String get declined => 'Rechazado';
//   @override
//   String get validateOtp => 'Validar OTP';
//   @override
//   String get otpCodeHasBeenSentTo => 'El código OTP ha sido enviado a';
//   @override
//   String get pleaseEnterOtp =>
//       'Ingrese OTP a continuación para verificar su número de teléfono móvil.';
//   @override
//   String get selectSources => 'Seleccionar fuentes';
//   @override
//   String get whoWillBeSeated => '¿Quién estará sentado?';
//   @override
//   String get via => 'A través de';
//   @override
//   String get status => 'Estado';
//   @override
//   String get riderInformation => 'Información del jinete';
//   @override
//   String get minutePrice => 'Precio minucioso';
//   @override
//   String get waitingTimePrice => 'Precio de tiempo de espera';
//   @override
//   String get additionalFees => 'Cuotas adicionales';
//   @override
//   String get settings => 'Ajustes';
//   @override
//   String get welcome => 'Bienvenido,';
//   @override
//   String get signContinue => 'Iniciar sesión para continuar';
//   @override
//   String get passwordLength =>
//       'La longitud de la contraseña al menos debe ser 8';
//   @override
//   String get bothPasswordNotMatch => 'Ambas contraseñas deben coincidir';
//   @override
//   String get missingBankDetail =>
//       'Faltando datos bancarios. Complete su perfil al monto del retiro';
//   @override
//   String get close => 'Cerca';
//   @override
//   String get copied => '¡Copiado!';
// }

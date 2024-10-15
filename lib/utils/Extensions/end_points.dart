class EndPoints {
  static final BASE_URL = 'https://palmtree.sadualshar.com/api/';
  // static final BASE_URL = 'http://192.168.1.5:8000/api/';
  // Auth
  static final userLogin = 'login';
  static final companyLogin = 'login';
  // orders
  static final allOrders = 'orders';
  static final allAuthOrders = 'company/all-orders-for-company';

  static final pendingAndDelivereedOrdersCount = 'user/delivered-orders-count';
  static final pendingAndDelivereedOrders = 'user/delivered-orders';

  static final pendingAndDelivereedOrdersCompany = 'orders-count';

  static final acceptOrder = '/orders';
  static refuseOrder(int id) => 'orders/$id/refuse';
  static changeStatus(int id) => 'orders/$id/change-status';

  static final latestChossenOrder = "latest-chosen-order";
  //static final pendingnOrders = "user/filtered-orders";
  static final pendingnOrders = "/pending-orders";
  static final pendingnWaitedOrders = "user/wait-approve-orders";

  //company
  //search
  static final search = 'orders/search/';

  //notificatios
  static final allNotificatios = 'notifications?rows';
  //profile and addresses
  static final myProfile = 'my-profile';
  static profile(int id) => 'companies/$id/profile';
  //firebase
  static final firebaseDeviceToken = 'firebase-device-token';
  //tracking
  static final RECORD_LOCATION_URI = 'set-tracking';
  //statues
  static final statuses = "get-status";
}
// user/wait-approve-orders

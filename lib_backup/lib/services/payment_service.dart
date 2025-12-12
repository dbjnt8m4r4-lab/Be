import 'package:in_app_purchase/in_app_purchase.dart';

class PaymentService {
  static final PaymentService _instance = PaymentService._internal();
  factory PaymentService() => _instance;
  PaymentService._internal();

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  Stream<List<PurchaseDetails>> get purchaseStream => _inAppPurchase.purchaseStream;

  Future<bool> initialize() async {
    return _inAppPurchase.isAvailable();
  }

  Future<ProductDetails> getSubscriptionProduct() async {
    const Set<String> kIds = {'annual_subscription'};
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(kIds);

    if (response.notFoundIDs.isNotEmpty) {
      throw Exception('Product not found');
    }

    return response.productDetails.first;
  }

  Future<void> purchaseSubscription(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> restorePurchases() async {
    await _inAppPurchase.restorePurchases();
  }

  Future<bool> verifyPurchase(PurchaseDetails purchase) async {
    // Implement server-side verification here
    return purchase.status == PurchaseStatus.purchased;
  }

  Future<void> completePurchase(PurchaseDetails purchase) async {
    await _inAppPurchase.completePurchase(purchase);
  }
}
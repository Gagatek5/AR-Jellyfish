//
//   PurchaseManager.swift
//  AR-Jellyfish
//
//  Created by Tom on 01/02/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

typealias CompletionHandler = (_ success: Bool) -> ()

import Foundation
import StoreKit

class PurchaseManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    static let instance = PurchaseManager()
    
    let IAP_REMOVE_ADS = "Do.This.App.AR.Jellyfishs.ad"
   
    var productsRequest: SKProductsRequest!
    var products = [SKProduct]()
    var transactionComplete: CompletionHandler?
    
    func fetchProducts() {
        let productIds = NSSet(object: IAP_REMOVE_ADS) as! Set<String>
        productsRequest = SKProductsRequest(productIdentifiers: productIds)
        productsRequest.delegate = self
        productsRequest.start()
        print("t")
        print(productsRequest)
        print(IAP_REMOVE_ADS)
        print(products.count)
        
    }
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.products.count)
        
        if response.products.count > 0  {
            print(response.products.debugDescription)
            products = response.products
        }
        
    }
    func purchaseRemoveAds(onComplete: @escaping CompletionHandler) {

        if SKPaymentQueue.canMakePayments() && products.count > 0 {
            transactionComplete = onComplete
            let removeAdsProduct = products[0]
            let payment = SKPayment(product: removeAdsProduct)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        } else {
            onComplete(false)
        }
    }
    
    func restorePurchases(onComplete: @escaping CompletionHandler) {
        if SKPaymentQueue.canMakePayments() {
            transactionComplete = onComplete
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().restoreCompletedTransactions()
        } else {
            onComplete(false)
        }
        
    }
    

    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                if transaction.payment.productIdentifier == IAP_REMOVE_ADS {
                    UserDefaults.standard.set(true, forKey: IAP_REMOVE_ADS)
                    transactionComplete?(true)
                }
                break
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                transactionComplete?(false)
                break
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                if transaction.payment.productIdentifier == IAP_REMOVE_ADS {
                    UserDefaults.standard.set(true, forKey: IAP_REMOVE_ADS)
                }
                transactionComplete?(true)
            default:
                transactionComplete?(false)
                break
            }
        }
    }
}


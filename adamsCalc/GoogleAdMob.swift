//
//  GoogleAdMob.swift
//  adamsCalc
//
//  Created by Adam Reed on 6/24/21.
//

import SwiftUI
import GoogleMobileAds
import UIKit

final private class BannerVC: UIViewControllerRepresentable  {
    
    
    var testBannerAdId = "ca-app-pub-3940256099942544/2934735716"

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeBanner)

        let viewController = UIViewController()
        view.adUnitID = testBannerAdId
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct Banner:View{
    var body: some View{
        HStack(alignment: .center) {
            BannerVC().frame(minWidth: 320, maxWidth: .infinity, minHeight: 45, maxHeight: 50, alignment: .center)
        }
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner()
    }
}

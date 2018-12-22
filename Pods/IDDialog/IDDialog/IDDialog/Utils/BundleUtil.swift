

import UIKit

class BundleUtil {
    
    static func getCurrentBundle() -> Bundle{
        let podBundle = Bundle(for: IDDialog.self)
        let bundleURL = podBundle.url(forResource: "IDDialog", withExtension: "bundle")
        if bundleURL != nil {
            let bundle = Bundle(url: bundleURL!)!
            return bundle
        }else{
            return Bundle.main
        }
    }

}

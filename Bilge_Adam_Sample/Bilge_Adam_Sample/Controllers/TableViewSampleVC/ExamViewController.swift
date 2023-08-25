//
//  ExamViewController.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 21.08.2023.
//

import UIKit

enum DaireTipi: Int {
    case yuzmetrekare = 1500
    case yuzellimetrekare = 2000
    case ikiyuzmetrekare = 2500

    var aidatMiktari: Int {
        switch self {
        case .yuzmetrekare:
            return 1500
        case .yuzellimetrekare:
            return 2000
        case .ikiyuzmetrekare:
            return 2500
        }
    }
}


struct Daire {
    var tip: DaireTipi
    var numara: Int
}

class ExamViewController: UIViewController {

    let daireler: [Daire] = [
        Daire(tip: .yuzmetrekare, numara: 1),
        Daire(tip: .yuzmetrekare, numara: 2),
        Daire(tip: .yuzmetrekare, numara: 3),
        Daire(tip: .yuzmetrekare, numara: 4),
        Daire(tip: .yuzellimetrekare, numara: 5),
        Daire(tip: .yuzellimetrekare, numara: 6),
        Daire(tip: .yuzellimetrekare, numara: 7),
        Daire(tip: .ikiyuzmetrekare, numara: 8),
        Daire(tip: .ikiyuzmetrekare, numara: 9),
        Daire(tip: .ikiyuzmetrekare, numara: 10)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(daireTipiAidatAylik(daireTipi: .ikiyuzmetrekare))
        print(toplamAidatlariHesapla(daireler: daireler))
    }
 
    
    

    

    func daireTipiAidatAylik(daireTipi: DaireTipi) -> String {
        var dairelerStr = String()
        let secilenDaireler = daireler.filter { daire in
            daire.tip == daireTipi
        }

        secilenDaireler.forEach { daire in
            dairelerStr = dairelerStr + "\(daire.numara), "
        }

        let toplamAidat = secilenDaireler.count * Int(daireTipi.rawValue)

        return "\(dairelerStr)numaralı \(secilenDaireler.count) adet daireden aylık toplam \(toplamAidat)₺ aidat alınmaktadır."
    }

    func toplamAidatlariHesapla(daireler: [Daire]) -> String {
        var toplamAylik = Int()

        daireler.forEach { daire in
            toplamAylik = toplamAylik + daire.tip.aidatMiktari
        }
        let toplamYillik = toplamAylik * 12

        return "\(daireler.count) adet daireden aylık: \(toplamAylik)₺, yıllık: \(toplamYillik)₺ aidat alınmaktadır."
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

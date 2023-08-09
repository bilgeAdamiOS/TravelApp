//
//  VC1.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 1.08.2023.
//

import UIKit

class TableViewDetailVC: UIViewController {

    var name:String?
    
    private lazy var button:UIButton = {
        let b = UIButton()
        b.setTitle("Show Alert", for: .normal)
        b.backgroundColor = .black
        b.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupViews()
        
    }
    
    @objc func showAlert(){
        
        
        //let viewController = UIApplication.shared.windows.first?.rootViewController as! MainTabbarController
        let currency = SliderSampleVC()
        
        
        self.navigationController?.pushViewController(currency, animated: true)
        
    }
    
    
    private func setupViews(){
        self.view.backgroundColor = .blue
        self.view.addSubview(button)
        setupLayout()
    }
    
    private func setupLayout(){
        button.snp.makeConstraints( { button in
            button.bottom.equalToSuperview().offset(-100)
            button.leading.equalToSuperview().offset(16)
            button.trailing.equalToSuperview().offset(-16)
            button.height.equalTo(50)
        })
    }

}

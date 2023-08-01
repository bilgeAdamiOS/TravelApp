//
//  Segmented-SwitchVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 1.08.2023.
//

import UIKit
import SnapKit
import TinyConstraints


class Segmented_SwitchVC: UIViewController {
    
    private lazy var toggle:UISwitch = {
        let s = UISwitch()
        
        s.isOn = false
        s.onTintColor = .green
        s.addTarget(self, action: #selector(toggled), for: .valueChanged)
        return s
    }()
    
    private lazy var button:UIButton = {
        let b = UIButton()
        b.setTitle("Tap Here", for: .normal)
        b.backgroundColor = .blue
        b.isEnabled = false
        b.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return b
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews(){
        
        self.view.backgroundColor = .white
        self.view.addSubviews(toggle,button)
        
        setupLayout()
    }
    
    @objc func buttonTapped(){
        print("button aktif"  )
    }
    
    @objc func toggled(sender:UISwitch) {
        
        if sender.isOn {
            
            button.isEnabled = true
//            self.view.backgroundColor = .white
        }else {
            button.isEnabled = false
//            self.view.backgroundColor = .black
        }
    }
    
    private func setupLayout(){
        
        toggle.snp.makeConstraints({ toggle in
            toggle.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            toggle.trailing.equalToSuperview().offset(-16)
        })
        
        button.snp.makeConstraints({ button in
            button.bottom.equalToSuperview().offset(-50)
            button.leading.equalToSuperview().offset(16)
            button.trailing.equalToSuperview().offset(-16)
            button.height.equalTo(50)
        })
    }

}

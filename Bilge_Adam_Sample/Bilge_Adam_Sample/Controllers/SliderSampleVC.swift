//
//  SliderSampleVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 31.07.2023.
//

import UIKit
import SnapKit

class SliderSampleVC: UIViewController {
    
    var stepValue:Float = 2
    
    
    
    private lazy var lblTitle:UILabel = {
        let l = UILabel()
        l.text = "Buraya Tıkla"
        l.isUserInteractionEnabled = true
        return l
    }()
    
    private lazy var slider:UISlider = {
        let slider = UISlider()
        slider.minimumValue = 12
        slider.maximumValue = 24
        slider.value = 0.0
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        slider.tintColor = .green
        slider.thumbTintColor = .blue
        slider.maximumTrackTintColor = .yellow
        return slider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        setupViews()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(tapToGesture))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToGesture))
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(tapToGesture))
        swipeGesture.direction = .up
        
        self.lblTitle.addGestureRecognizer(swipeGesture)
    }
    
    @objc func tapToGesture(sender:UISwipeGestureRecognizer){
        
        self.present(LoginVC(), animated: true)
        
    }
    
    @objc func sliderValueChanged(sender:UISlider) {
       
        let newValue = CGFloat(sender.value)
        
        self.lblTitle.font = UIFont(name: "Poppins-Medium", size: newValue)
        let rounded = round(sender.value / stepValue) * stepValue
        
        slider.setValue(rounded, animated: false)
        print(sender.value)
       
    }
    
    
    private func setupViews(){
        self.view.addSubviews(lblTitle,slider)
        setupLayout()
    }

    private func setupLayout(){
        
        lblTitle.snp.makeConstraints({ label in
            label.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            label.leading.equalToSuperview().offset(16)
            label.trailing.equalToSuperview().offset(-16)
            label.height.equalTo(50)
        })
        
        slider.snp.makeConstraints({ slider in
            slider.top.equalTo(lblTitle.snp.bottom).offset(30)
            slider.leading.equalToSuperview().offset(16)
            slider.trailing.equalToSuperview().offset(-16)
        })
    }
    
    
}



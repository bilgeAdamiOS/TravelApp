//
//  CarLoginVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 3.08.2023.
//

import UIKit


class ContactVC: UIViewController {

    
    var chars = ["A","B","C","D"]
    
    var array = ["Ahmet","Ali","Arzu","Aydın","Bekir","Batu","Buse","Cem","Canan"]
    
    var arr = [[String]]()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: -- NavBar Appearance
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let titleLabel = UILabel()
        titleLabel.text = "Ortalanmış Başlık"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        navigationItem.titleView = titleLabel

        //self.title = "Trabzonspor"
        
//        self.navigationController?.navigationBar.scrollEdgeAppearance = app
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = .red
    

        
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filterAndSort()
        self.title = "Contact"
        self.view.backgroundColor = .systemBlue
        
        
        
//
//        let firstRightButton = UIBarButtonItem(title: "Sağa Git", style: .plain, target: self, action: #selector(btnRightButton))
//
//        let secondRightButton = UIBarButtonItem(image: UIImage(systemName: "apple.logo"), style: .done, target: self, action: #selector(btnSecondRightTapped))

        
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward.circle.fill"), style: .done, target: self, action: #selector(btnLeftTapped))
        
//        self.navigationItem.rightBarButtonItems = [firstRightButton,secondRightButton]
        self.navigationItem.leftBarButtonItems = [leftButton]
       
        
    }
    
    @objc func btnLeftTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnSecondRightTapped(){
        print("İkinci butona basıldı.")
    }
    
    @objc func btnRightButton(){
        
        let vc = SliderSampleVC()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func filterAndSort(){
        
        chars.enumerated().forEach({ index,char in
            
            let filtered = array.filter({ $0.hasPrefix(char) }).sorted(by: { $0<$1})
            
            if filtered.count > 0 {
                arr.append(filtered)
            }else {
                chars.remove(at: index)
            }
            
        })
        
        print(arr)
        print(chars)
        
    }
    
    private func addNew(name:String){
        
        array.append(name)
    }
    


}

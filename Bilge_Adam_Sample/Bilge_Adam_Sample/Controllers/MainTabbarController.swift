//
//  MainTabbarController.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 1.08.2023.
//

import UIKit

class MainTabbarController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        UINavigationBar.appearance().prefersLargeTitles = true
        self.title = "Deneme"
        
        let appearance = UITabBar.appearance()

        
        //appearance.unselectedItemTintColor = .blue
        
        appearance.tintColor = .white
        appearance.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3023334023)
        
        
        let vc1 = AlertVC()
        let img = UIImage(systemName: "house")
        let selectedImg = UIImage(systemName: "house.fill")
        vc1.tabBarItem = UITabBarItem(title: "", image: img, selectedImage: selectedImg)
        
        
        let vc2 = TableViewDetailVC()
        let img2 = UIImage(systemName: "star")
        let selected2 = UIImage(systemName: "star.fill")
        vc2.tabBarItem = UITabBarItem(title: "", image: img2, selectedImage: selected2)
        
        
        let vc3 = TableViewSample()
        let img3 = UIImage(systemName: "cart")
        let selected3 = UIImage(systemName: "cart.fill")
        vc3.tabBarItem = UITabBarItem(title: "", image: img3, selectedImage: selected3)
       
        
        let vc4 = PickerVC()
        let img4 = UIImage(systemName: "person")
        let selected4 = UIImage(systemName: "person.fill")
        vc4.tabBarItem = UITabBarItem(title: "", image: img4, selectedImage: selected4)
        
        
        
        self.viewControllers = [vc1,vc2,vc3,vc4]
        
    }
    

}

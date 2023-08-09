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

        
        let appearance = UITabBar.appearance()
        self.navigationController?.isNavigationBarHidden = true
        //appearance.unselectedItemTintColor = .blue

        appearance.tintColor = .white
        appearance.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        
        
        let vc1 = AlertVC()
        let nav1 = UINavigationController(rootViewController: vc1)
        let img = UIImage(systemName: "house")
        let selectedImg = UIImage(systemName: "house.fill")
        vc1.tabBarItem = UITabBarItem(title: "", image: img, selectedImage: selectedImg)
        
        
        let vc2 = TableViewDetailVC()
        let nav2 = UINavigationController(rootViewController: vc2)
        let img2 = UIImage(systemName: "star")
        let selected2 = UIImage(systemName: "star.fill")
        vc2.tabBarItem = UITabBarItem(title: "", image: img2, selectedImage: selected2)
        
        
        let vc3 = TableViewSample()
        let nav3 = UINavigationController(rootViewController: vc3)
        let img3 = UIImage(systemName: "cart")
        let selected3 = UIImage(systemName: "cart.fill")
        vc3.tabBarItem = UITabBarItem(title: "", image: img3, selectedImage: selected3)
       
        
        let vc4 = PickerVC()
        let nav4 = UINavigationController(rootViewController: vc4)
        let img4 = UIImage(systemName: "person")
        let selected4 = UIImage(systemName: "person.fill")
        vc4.tabBarItem = UITabBarItem(title: "", image: img4, selectedImage: selected4)
        
        //self.viewControllers = [vc1,vc2,vc3,vc4]
        self.viewControllers = [nav1,nav2,nav3,nav4]
        
    }
    

}

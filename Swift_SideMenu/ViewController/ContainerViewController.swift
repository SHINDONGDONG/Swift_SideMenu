//
//  ViewController.swift
//  Swift_SideMenu
//
//  Created by 申民鐡 on 2022/02/03.
//

import UIKit

class ContainerViewController: UIViewController {

    //home,menu 컨트롤러를 자식으로 두어야함
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        addChildVC()
    }
    
    private func addChildVC() {
        //menu
        //자식으로 menuVC를 추가시킨다.
        addChild(menuVC)
        view.addSubview(menuVC.view )
        menuVC.didMove(toParent: self)
        
        //home
        //navigator를 루트컨트롤러 homeVC로 지정해두었다.
        let navVC = UINavigationController(rootViewController: homeVC)
        //navVC를 자식으로 만들어준다.
        addChild(navVC)
        //view에 추가시킨다 navVCview를
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
    }


}


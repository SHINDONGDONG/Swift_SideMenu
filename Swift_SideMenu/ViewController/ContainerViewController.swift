//
//  ViewController.swift
//  Swift_SideMenu
//
//  Created by 申民鐡 on 2022/02/03.
//

import UIKit

class ContainerViewController: UIViewController {
    
    //enum으로 열린메뉴 닫힌메뉴를 선언한다
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    

    //home,menu 컨트롤러를 자식으로 두어야함
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    var navVC: UINavigationController?
    
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
        homeVC.delegate = self
        //navigator를 루트컨트롤러 homeVC로 지정해두었다.
        let navVC = UINavigationController(rootViewController: homeVC)
        //navVC를 자식으로 만들어준다.
        addChild(navVC)
        //view에 추가시킨다 navVCview를
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }


}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        //스위치문으로 enum 애들을 나열해줌.
        switch menuState {
        case .closed:
            //open 해줌       //duration 0.5
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                
                //uiview 애니메이션이 위의 옵션으로움 직이며 실제로 homeVC의 viewfram이 사라지면서 메뉴바가 생긴다.
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 150
                
                //completion 실행이된다면
            } completion: { [weak self] done in
                if done {
                    //menuState를 opened로 바꾸어준다.
                    self?.menuState = .opened
                }
            }
            
        case .opened:
            //closed 해줌       //duration 0.5
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                
                //navVC view 프레임에 0을 대입해주어 다시 닫히게 만든다.
                self.navVC?.view.frame.origin.x = 0
                
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                }
            }
        }
        
        
        
    }
    
    
}

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
    lazy var infoVC = InfoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        addChildVC()
    }
    
    private func addChildVC() {
        //menu
        //자식으로 menuVC를 추가시킨다.
        menuVC.delegate = self
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
        toggleMenu(completion: nil)
    }
    func toggleMenu(completion: (()-> Void)?) {
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
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        toggleMenu (completion: nil)
            switch menuItem {
            case .home:
                self.returnToHome()
            case .info:
                self.addInfo()
//                let vc = InfoViewController()
//                self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            case .appRating:
                break
            case .shareApp:
                break
            case .settings:
                break
            }
        }
    
    
    func addInfo() {
        let vc = infoVC
  
        homeVC.addChild(vc)
        //homevc 위에 vc의 view를 깔아준다.
        homeVC.view.addSubview(vc.view)
        //vc의 fram은 view.frame과 같게 만든다.
        vc.view.frame = view.frame
        //!!!!!!!!!!!!!toParent로 하면 Controller는 homevc위에서 view만 올려주게되어서
        //타이틀이 homeVC로됨 완전히 view를 넘기려면 위의 모든 homeVC는 빼버림 로함
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
        
//        addChild(vc)
//        //homevc 위에 vc의 view를 깔아준다.
//        view.addSubview(vc.view)
//        //vc의 fram은 view.frame과 같게 만든다.
//        vc.view.frame = view.frame
//        //!!!!!!!!!!!!!toParent로 하면 Controller는 homevc위에서 view만 올려주게되어서
//        //타이틀이 homeVC로됨 완전히 view를 넘기려면 위의 모든 homeVC는 빼버림 로함
//        vc.didMove(toParent: self)
    }
    
    func returnToHome() {
        infoVC.view.removeFromSuperview()
        infoVC.didMove(toParent: nil)
        homeVC.title = "HOME"
    }
}

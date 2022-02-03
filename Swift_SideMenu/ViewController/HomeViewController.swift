//
//  HomeViewController.swift
//  Swift_SideMenu
//
//  Created by 申民鐡 on 2022/02/03.
//

import UIKit
//홈에서 클릭하면 실제로 menuviewcontroller에서 일어날일들을 델리게이트로 선언해준다.
protocol HomeViewControllerDelegate: AnyObject {
   func didTapMenuButton()
}

class HomeViewController: UIViewController {
    
    //delegate를 선언하여 메모리누수 방지
    weak var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "HOME"

        //navigation 버튼을 만들어준다                           //UIImage를 불러오은ㄴ데 systemName으로 아이콘을 불러올 수 있다.
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapMenuButton))
    }
    
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }


}

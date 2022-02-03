//
//  MenuViewController.swift
//  Swift_SideMenu
//
//  Created by 申民鐡 on 2022/02/03.
//

import UIKit

class MenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //menu들을 열거한다
    enum MenuOptions: String, CaseIterable {
        case home = "Home"
        case info = "Information"
        case appRating = "App Rating"
        case shareApp = "Share App"
        case settings = "Settings"
    }
    
    //메뉴들을 테이블뷰에 넣어준다.
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    }
    
    //subview가 실행될 때마다 갱신
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top,
                                 width: view.bounds.size.width,
                                 height: view.bounds.size.height)
    }
    
    //누르면 강조 표시를 해제한다.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //eunm을 불러올땐 .allCases로 불러오면됨ㄴ다
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        return cell
    }
}

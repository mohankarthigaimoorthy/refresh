//
//  ViewController.swift
//  refresh
//
//  Created by Imcrinox Mac on 12/12/1444 AH.
//



import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var index = 0
    let cellIdentifer = "NewCellIdentifier"
    
    let favoriteEmoji = ["🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆"]
    let newFavoriteEmoji = ["🏃🏃🏃🏃🏃", "💩💩💩💩💩", "👸👸👸👸👸", "🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆" ]
    var emojiData = [String]()
    var tableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    var navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 375, height: 64))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        
        emojiData = favoriteEmoji
        let emojiTableViews = tableView
        
        emojiTableViews?.backgroundColor = UIColor.cyan
//        UIColor(red:0.092, green:0.096, blue:0.116, alpha:1)
        emojiTableViews?.dataSource = self
        emojiTableViews?.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        
        tableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(ViewController.didRoadEmoji), for: .valueChanged)
        
        self.refreshControl.backgroundColor = UIColor(red:0.113, green:0.113, blue:0.145, alpha:1)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.refreshControl.attributedTitle = NSAttributedString(string: "Last updated on \(Date())", attributes: attributes)
        self.refreshControl.tintColor = UIColor.white
        
        self.title = "emoji"
        self.navBar.barStyle = UIBarStyle.black
        
        emojiTableViews?.rowHeight = UITableView.automaticDimension
        emojiTableViews?.estimatedRowHeight = 60.0
        emojiTableViews?.tableFooterView = UIView(frame: CGRect.zero)
        emojiTableViews?.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        
        self.view.addSubview(emojiTableViews!)
        self.view.addSubview(navBar)
    }
    
    //UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer)! as UITableViewCell
        cell.textLabel!.text = self.emojiData[indexPath.row]
        cell.textLabel!.textAlignment = NSTextAlignment.center
        cell.textLabel!.font = UIFont.systemFont(ofSize: 50)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        return cell
    }
    
    
    //RoadEmoji
    
    @objc func didRoadEmoji() {
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + 3 ) {
            self.emojiData = [self.newFavoriteEmoji,self.favoriteEmoji][self.index]
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.index = (self.index + 1) % 2
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }


}


//
//  ViewController.swift
//  AnimationAssigment
//
//  Created by Carlos Camacho on 2020-05-23.
//  Copyright © 2020 Carlos Camacho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var navBar: UIView!

    @IBOutlet weak var plusButton: UIButton!
    
    
    let oreoBtn = UIButton.init(type: .custom)
    let pizzaBtn = UIButton.init(type: .custom)
    let popTartBtn = UIButton.init(type: .custom)
    let popsicleBtn = UIButton.init(type: .custom)
    let ramenBtn = UIButton.init(type: .custom)
    
    var tableView: UITableView!
    var stackView: UIStackView!
    
    
    var snacks = [String]()
    var state: State = .closed
    
    var isOpen : Bool{return state == .opened }
    enum State{
        case opened,closed
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view()
        layout()
    }

    func layout(){
        let heightImg = CGFloat.init(100)
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            self.stackView.bottomAnchor.constraint(equalTo: self.navBar.bottomAnchor, constant: -5),
            self.stackView.leadingAnchor.constraint(equalTo: self.navBar.leadingAnchor, constant: 5),
            self.stackView.trailingAnchor.constraint(equalTo: self.plusButton.leadingAnchor, constant: -5),
            self.stackView.heightAnchor.constraint(lessThanOrEqualTo: self.navBar.heightAnchor, multiplier: 0.8),
            self.oreoBtn.heightAnchor.constraint(lessThanOrEqualToConstant: heightImg),
            self.pizzaBtn.heightAnchor.constraint(lessThanOrEqualToConstant: heightImg),
            self.popTartBtn.heightAnchor.constraint(lessThanOrEqualToConstant: heightImg),
            self.popsicleBtn.heightAnchor.constraint(lessThanOrEqualToConstant: heightImg),
            self.ramenBtn.heightAnchor.constraint(lessThanOrEqualToConstant: heightImg),
            
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.navBar.bottomAnchor, constant: 5),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            
            ])
    }
    func view(){
        self.oreoBtn.setImage(UIImage.init(named:"oreos"), for: .normal)
        self.oreoBtn.tag = 0
        self.pizzaBtn.setImage(UIImage.init(named:"pizza_pockets"), for: .normal)
        self.pizzaBtn.tag = 1
        self.popTartBtn.setImage(UIImage.init(named:"pop_tarts"), for: .normal)
        self.popTartBtn.tag = 2
        self.popsicleBtn.setImage(UIImage.init(named:"popsicle"), for: .normal)
        self.popsicleBtn.tag = 3
        self.ramenBtn.setImage(UIImage.init(named:"ramen"), for: .normal)
        self.ramenBtn.tag = 4
        
        
        
        self.oreoBtn.addTarget(self, action: #selector(self.SnackClicked), for: .touchUpInside)
        self.pizzaBtn.addTarget(self, action: #selector(self.SnackClicked), for: .touchUpInside)
        self.popTartBtn.addTarget(self, action: #selector(self.SnackClicked), for: .touchUpInside)
        self.popsicleBtn.addTarget(self, action: #selector(self.SnackClicked), for: .touchUpInside)
        self.ramenBtn.addTarget(self, action: #selector(self.SnackClicked), for: .touchUpInside)
        
        self.stackView = UIStackView.init(arrangedSubviews:[oreoBtn,pizzaBtn,popTartBtn,popsicleBtn,ramenBtn])
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .horizontal
        self.stackView.distribution = .fillEqually
        self.stackView.spacing = 5
        self.stackView.isHidden = true
        self.navBar.addSubview(stackView)
        
        self.tableView = UITableView.init()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        
    }
    
    @objc func SnackClicked(_ sender: UIButton){
        switch sender.tag{
            case 0:
                snacks.append("Oreo")
            case 1:
                snacks.append("Pizza")
            case 2:
                snacks.append("Pop tarts")
            case 3:
                snacks.append("Popsicle")
            case 4:
                snacks.append("Ramen")
        default:
                break
        }
        tableView.insertRows(at: [IndexPath.init(row: snacks.count - 1,section: 0)], with: .automatic)
    }
    
    
    @IBAction func plusBtnClicked(_ sender: Any) {
        if state == .opened{
            state = .closed
        }else{
            state = .opened
        }
       
        if self.isOpen == true{
            self.navBar.frame = .init(x: 0, y: 0, width: self.navBar.frame.width, height: 200)
        }else{
            self.navBar.frame = .init(x: 0, y: 0, width: self.navBar.frame.width, height: 88)
        }
        
       
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {self.view.layoutIfNeeded()
            self.plusButton.transform = CGAffineTransform.init(rotationAngle: self.isOpen ? .pi/4 : 0)
            self.stackView.isHidden = !self.isOpen
        })
    }
    
    
    

    
}

extension ViewController: UITableViewDelegate{
    func numberOfSection(in tableView: UITableView)-> Int{
        return 1
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.snacks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.snacks[indexPath.row]
        return cell
    }
    
    
}

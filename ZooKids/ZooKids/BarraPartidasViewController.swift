//
//  BarraPartidasViewController.swift
//  ZooKids
//
//  Created by Jefferson on 24/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit

class BarraPartidasViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate  {

   

    var teams = [String]()
    var arrayFecha = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        teams = [ "Partida #1", "Partida #2", "Partida #3"]
        arrayFecha = [ "1/1/2018", "2/1/2018", "3/1/2018"]
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return teams.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
       
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TableviewCell1
     
        cell.numeroPartida.text = teams[indexPath.row]
        cell.fecha.text = arrayFecha[indexPath.row]
        
        return cell
    }
}

//
//  BarraPartidasViewController.swift
//  ZooKids
//
//  Created by Jefferson on 24/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit

class BarraPartidasViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate  {

    var partidas = [Partida]()
    static var cantAciertos: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //partidas.count
        partidas = partidas.reverse()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        
        return partidas.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
       
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TableviewCell1
     
        /*cell.numeroPartida.text = teams[indexPath.row]
        cell.fecha.text = arrayFecha[indexPath.row]*/
        cell.numeroPartida.text = "Partida #"+String(indexPath.row+1)
        let fecha = partidas[indexPath.row].fecha
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        let dd = calendar.component(.Day, fromDate: fecha)
        let mm = calendar.component(.Month, fromDate: fecha)
        let yy = calendar.component(.Year, fromDate: fecha)
        let fechaString = String(dd)+" / "+String(mm)+" / "+String(yy)
        //print("fecha = ",dd," / ",mm," / ",yy)
        cell.fecha.text = fechaString
        BarraPartidasViewController.cantAciertos = 0.0
        let nAciertos = partidas[indexPath.row].num_aciertos
        let total = nAciertos + partidas[indexPath.row].num_fallos
        BarraPartidasViewController.cantAciertos = (Double(nAciertos) / Double(total))*10
        
        
        return cell
    }
}

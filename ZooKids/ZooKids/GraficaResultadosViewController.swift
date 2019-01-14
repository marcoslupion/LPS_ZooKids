//
//  GraficaResultadosViewController.swift
//  ZooKids
//
//  Created by Jefferson on 8/1/19.
//  Copyright © 2019 ual. All rights reserved.
//

import UIKit
import Charts

class GraficaResultadosViewController: UIViewController {

    @IBOutlet weak var subtituloAciertos: UILabel!
    
    var aciertos: Int16 = 0
    var fallos: Int16 = 0
    
    
    @IBOutlet var pieView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let months = ["Aciertos", "Fallos"]
        let unitsSold = [Double(aciertos), Double(fallos)]
        
        setChart(months, values: unitsSold)
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: " ")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        
        pieView.data = pieChartData
        pieView.descriptionText = " "
        
        
        var colors: [UIColor] = []
        
        let color2 = UIColor(red: 255/255, green: 206/255, blue: 241/255, alpha: 1)
        let color1 = UIColor(red: 143/255, green: 214/255, blue: 128/255, alpha: 1)
            
        colors.append(color1)
        colors.append(color2)
            
    
        let colorAgujero = UIColor(red: 255/255, green: 240/255, blue: 201/255, alpha: 1)
        pieView.holeColor = colorAgujero
      
    
        pieChartDataSet.colors = colors
        
        pieView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: ChartEasingOption.EaseOutBack)
   
        
        
        
        
    }
}

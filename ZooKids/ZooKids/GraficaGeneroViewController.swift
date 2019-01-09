//
//  GraficaGeneroViewController.swift
//  ZooKids
//
//  Created by Jefferson on 8/1/19.
//  Copyright © 2019 ual. All rights reserved.
//

import UIKit
import Charts
class GraficaGeneroViewController: UIViewController,ChartViewDelegate {

    
    @IBOutlet var barChartView: BarChartView!
      
    let months = ["Aciertos", "Fallos"]
    let unitsSold = [8.0, 5.0]
    let unitsBought = [5.0, 7.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setChartBarGroupDataSet(months, values: unitsSold, values2: unitsBought, sortIndex: 1)
        
    }
    
    func setChartBarGroupDataSet(dataPoints: [String], values: [Double], values2: [Double],sortIndex:Int) {
        
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries2: [BarChartDataEntry] = []
        
        
        for i in 0..<dataPoints.count {
            
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        
        for i in 0..<dataPoints.count {
            
            let dataEntry = BarChartDataEntry(value: values2[i], xIndex: i)
            dataEntries2.append(dataEntry)
        }
        
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Acieros")
        let chartDataSet2 = BarChartDataSet(yVals: dataEntries2, label: "Fallos")
        
        chartDataSet2.colors =  [UIColor(red: 255/255, green: 206/255, blue: 241/255, alpha: 1)]
        
        chartDataSet.colors =  [UIColor(red: 143/255, green: 214/255, blue: 128/255, alpha: 1)]
        
        
        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet2]
        
        let data = BarChartData(xVals: dataPoints, dataSets: dataSets)
        
        barChartView.data = data
        
        barChartView.descriptionText = " "
        
        
        barChartView.rightAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawAxisLineEnabled = false
        barChartView.rightAxis.drawLabelsEnabled = false
        
        
        
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
        
        
    }
    
    
    

}
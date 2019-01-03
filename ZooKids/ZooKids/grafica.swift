//
//  grafica.swift
//  ZooKids
//
//  Created by Jefferson on 3/1/19.
//  Copyright © 2019 ual. All rights reserved.
//

import UIKit
import Charts



class grafica: UIViewController {

    @IBOutlet weak var nombre: UILabel!
    @IBOutlet var pieView: PieChartView!
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let months = ["Aciertos", "Fallos"]
        let unitsSold = [4.0, 5.0]
        
        setChart(months, values: unitsSold)
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        
        pieView.data = pieChartData
        
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
        
       // let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
      //  let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
       // pieView.data = lineChartData
        
    }
    
    


}


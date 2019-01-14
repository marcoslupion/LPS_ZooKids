//
//  graficaResumen.swift
//  ZooKids
//
//  Created by Jefferson on 4/1/19.
//  Copyright © 2019 ual. All rights reserved.
//

import UIKit
import Charts

class graficaResumen: UIViewController {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet weak var subtituloAciertos: UILabel!
    var numAciertos:Int16 = 0
    var numFallos:Int16 = 0
    
    
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
        let unitsSold = [Double(numAciertos), Double(numFallos)]
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
        
        pieView.animate(xAxisDuration: 5.5, yAxisDuration: 5.5, easingOption: ChartEasingOption.EaseOutBack)
        
       
        var colors: [UIColor] = []
        
        let color2 = UIColor(red: 255/255, green: 206/255, blue: 241/255, alpha: 1)
        let color1 = UIColor(red: 143/255, green: 214/255, blue: 128/255, alpha: 1)
        
        colors.append(color1)
        colors.append(color2)
        
        
        let colorAgujero = UIColor(red: 255/255, green: 240/255, blue: 201/255, alpha: 1)
        pieView.holeColor = colorAgujero
        
        
        pieChartDataSet.colors = colors
        
      
        
    }
}

//
//  GraficaFallosTotalesViewController.swift
//  ZooKids
//
//  Created by Jefferson on 8/1/19.
//  Copyright © 2019 ual. All rights reserved.
//

import UIKit
import Charts


class GraficaFallosTotalesViewController: UIViewController {
    @IBOutlet var pieView: PieChartView!
    
    var tipoAnimalMap = Dictionary<String,Int16>()
    
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

        let tipoAnimal = [String](tipoAnimalMap.keys)
        let errores = [Int16]((tipoAnimalMap.values))
        
        var tipoAnimalFinal = [String]()
        var erroresFinal = [Double]()
        var contador = 0
        for err in errores{
            if (err > 0){
                tipoAnimalFinal.append(tipoAnimal[contador])
                erroresFinal.append(Double(err))
            }
            
            contador+=1
        }
        setChart(tipoAnimalFinal, values: erroresFinal)
        
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
        
        //let color2 = UIColor(red: 255/255, green: 206/255, blue: 241/255, alpha: 1)
        //let color1 = UIColor(red: 143/255, green: 214/255, blue: 128/255, alpha: 1)
        
        let color1 = UIColor.magentaColor()
        let color2 = UIColor.greenColor()
        let color3 = UIColor.redColor()
        let color4 = UIColor.blueColor()
        let color5 = UIColor.purpleColor()
        let color6 = UIColor.cyanColor()
        let color7 = UIColor.yellowColor()
        
        colors.append(color1)
        colors.append(color2)
        colors.append(color3)
        colors.append(color4)
        colors.append(color5)
        colors.append(color6)
        colors.append(color7)
        
        
        let colorAgujero = UIColor(red: 255/255, green: 240/255, blue: 201/255, alpha: 1)
        pieView.holeColor = colorAgujero
        
        pieChartDataSet.colors = colors
        
        pieView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: ChartEasingOption.EaseOutBack)        
    }

}

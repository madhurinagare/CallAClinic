//
//  ViewController.swift
//  CallAClinic
//
//  Created by Madhuri Nagare  on 7/28/21.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var TemperatureChart: LineChartView!
    
    @IBOutlet weak var temperaturelabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let temperature = [97.2, 96.6, 96, 97.1, 96.9, 96.5, 96.5, 97, 98, 96.2, 97, 96.4, 98, 97.2, 98, 97.2]
        graphlinechart(datarray: temperature)
    }


    func graphlinechart(datarray: [Double]) {
        //make chart's width and height = width of the screen
        TemperatureChart.frame = CGRect(x: 0, y: 0,
                                width: self.view.frame.size.width-60,
                                height: self.view.frame.size.width/3)
        //decide the center of the chart
        TemperatureChart.center.x = self.view.center.x
        TemperatureChart.center.y = temperaturelabel.frame.origin.y + 200
            //self.view.center.y
        
        //if chart data is not available
        TemperatureChart.noDataText = "No data available yet!"
        TemperatureChart.noDataTextColor = UIColor.black
        
        //initialize an array for the chart data
        var entries = [ChartDataEntry]()
        
        //add values in dataarray to the entries in the ChartDataEntry format
        for i in 0..<datarray.count{
            let value = ChartDataEntry(x: Double(i), y: Double(datarray[i]))
            entries.append(value)
        }
        //attach a label and create a new object
        let dataset = LineChartDataSet(entries: entries, label: "Temperature")
        
        dataset.colors = ChartColorTemplates.material()
        
        //make a variable/ object to add to lintplot?
        let data = LineChartData(dataSet: dataset)
        
        TemperatureChart.data = data
        
        //TemperatureChart.chartDescription?.text = "Temperature"
        
        //animation
        //TemperatureChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .linear)
    }
}


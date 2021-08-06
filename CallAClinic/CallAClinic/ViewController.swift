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
                                width: self.view.frame.size.width-40,
                                height: self.view.frame.size.width/3)
        //decide the center of the chart
        TemperatureChart.center.x = self.view.center.x-14
        TemperatureChart.center.y = temperaturelabel.frame.origin.y+TemperatureChart.frame.size.height/2+temperaturelabel.frame.size.height-20
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
        
        //make a variable/ object to add to lintplot?
        let data = LineChartData(dataSet: dataset)
        

        TemperatureChart.data = data
        
        //change line color for the plot
        //dataset.colors = ChartColorTemplates.material()
        dataset.colors = [UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1)]
        dataset.lineWidth = 2.0
        
        // bg color of the graph
        TemperatureChart.backgroundColor = UIColor(red: 69/255, green: 224/255, blue: 255/255, alpha: 0.2)
      
        //x Axis
        //move labels to  the btm
        TemperatureChart.xAxis.labelPosition = .bottom
        //setting font size and type
        TemperatureChart.xAxis.labelFont=UIFont(name: "Arial", size: 14)!
 
        //left y axis format
        self.TemperatureChart.leftAxis.labelFont=UIFont(name: "Arial", size: 14)!
        //remove right y-axis labels
        self.TemperatureChart.rightAxis.drawLabelsEnabled = false
 
        //marker changes
        dataset.setCircleColor(UIColor.blue)
        dataset.valueFont=UIFont(name: "Arial", size: 12)!
        dataset.circleRadius = 6.0
        
        //change font size and stype for the legend
        //let legend = TemperatureChart.legend
        //legend.font = UIFont(name: "Verdana", size: 12)!
        //removing legend
        self.TemperatureChart.legend.enabled = false

        
        //animation
        //TemperatureChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .linear)
        TemperatureChart.leftAxis.drawGridLinesEnabled = false

        TemperatureChart.extraBottomOffset = 10
        TemperatureChart.extraTopOffset = 26
        //TemperatureChart.extraLeftOffset = 20
        TemperatureChart.extraRightOffset = 20
        TemperatureChart.fitScreen()
        //TemperatureChart.chartDescription?.text = "Temperature"

    }
}


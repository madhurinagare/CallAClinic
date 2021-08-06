//
//  ViewController.swift
//  CallAClinic
//
//  Created by Madhuri Nagare  on 7/28/21.
//

import UIKit
import Charts

class ViewController: UIViewController {
    @IBOutlet weak var welcomeMsg: UILabel!

    @IBOutlet weak var TemperatureChart: LineChartView!
    @IBOutlet weak var WeightChart: LineChartView!
    @IBOutlet weak var temperaturelabel: UILabel!
    @IBOutlet weak var wightlabel: UILabel!
    
    @IBOutlet weak var AddWeightButton: UIButton!
    @IBOutlet weak var weightText: UITextField!
      
    @IBOutlet weak var clinicMsgLabel: UILabel!
    @IBOutlet weak var clinicMsgText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //button round corners and boarder
        //AddWeightButton.layer.cornerRadius = 4
        AddWeightButton.layer.borderWidth = 1
        // Do any additional setup after loading the view.
        let temperature = [97.2, 96.6, 96, 97.1, 96.9, 96.5, 96.5, 97, 98, 96.2, 97, 96.4, 98, 97.2, 98, 97.2]
        let weightvalues = [63.6, 63.4, 63, 63.4, 62.6, 63, 63.6, 63, 63.3, 63.3, 63, 63, 63.3, 63.9, 62.8, 62.8]
        graphlinechart(datarray: temperature)
        weightgraphlinechart(weightdatarray: weightvalues)
        
        clinicMsgLabel.frame.origin.x = TemperatureChart.frame.origin.x
        clinicMsgLabel.frame.origin.y = weightText.frame.origin.y + weightText.frame.size.height+40
        clinicMsgLabel.frame.size.height = 40
        
        clinicMsgLabel.frame.size.width = self.view.frame.size.width-35+14
        clinicMsgText.frame.origin.x = TemperatureChart.frame.origin.x
        clinicMsgText.frame.origin.y = clinicMsgLabel.frame.origin.y + clinicMsgLabel.frame.size.height
        clinicMsgText.frame.size.width = self.view.frame.size.width-35+14
       //add height constraint once you add buttons for tabs
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateUI),
            name: UIResponder.keyboardDidShowNotification, object: nil)
            updateUI()
        
    }
    @objc func updateUI() {

            let bullet = "•  "
            
            var strings = [String]()
            strings.append("Call 911 for an emergency.")
            strings.append("Call clinic if your temperature is above 104 °F.")
            strings.append("Vaccinatation appointments are available. Call in for scheduling.")
            strings.append("Mask is mandatory to visit the clinic!")
            strings = strings.map { return bullet + $0 }
            
            var attributes = [NSAttributedString.Key: Any]()
            attributes[.font] = UIFont(name: "Arial", size: 24)!
                //UIFont.preferredFont(forTextStyle: .body)
            attributes[.foregroundColor] = UIColor.black
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
            attributes[.paragraphStyle] = paragraphStyle

            let string = strings.joined(separator: "\n\n")
        clinicMsgText.attributedText = NSAttributedString(string: string, attributes: attributes)
        }

    @IBAction func addWeightTouch(_ sender: Any) {
        weightText.resignFirstResponder() //to close the numeric keyboard
        
        var weightvalues = [63.6, 63.4, 63, 63.4, 62.6, 63, 63.6, 63, 63.3, 63.3, 63, 63, 63.3, 63.9, 62.8, 62.8]
      
        if let newWeight = Double(weightText.text!) {
            weightvalues.append(newWeight)
            weightgraphlinechart(weightdatarray: weightvalues)
        } else {
            print("Not a valid number: \(weightText.text!)")
        }
        weightText.text?.removeAll()

    }
        
    func graphlinechart(datarray: [Double]) {
        //make chart's width and height = width of the screen
        TemperatureChart.frame = CGRect(x: 0, y: 0,
                                width: self.view.frame.size.width-40,
                                height: self.view.frame.size.width/3)
        //decide the center of the chart
        TemperatureChart.center.x = self.view.center.x
        TemperatureChart.frame.origin.y = self.view.frame.origin.y + welcomeMsg.frame.size.height+50

        temperaturelabel.frame.origin.x = TemperatureChart.frame.origin.x+50
        temperaturelabel.frame.origin.y = TemperatureChart.frame.origin.y+10

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
    
    func weightgraphlinechart(weightdatarray: [Double]) {
        //make chart's width and height = width of the screen
        WeightChart.frame = CGRect(x: 0, y: 0,
                                width: self.view.frame.size.width-40,
                                height: self.view.frame.size.width/3)
        //decide the center of the chart
        WeightChart.center.x = self.view.center.x
        WeightChart.center.y = TemperatureChart.center.y + TemperatureChart.frame.size.height + 20
      
        //locating other labels and buttons aronf this frame
        wightlabel.frame.origin.x = temperaturelabel.frame.origin.x
        wightlabel.frame.origin.y = WeightChart.frame.origin.y+10
        // bg color of the graph
        WeightChart.backgroundColor = UIColor(red: 69/255, green: 224/255, blue: 255/255, alpha: 0.2)
        
        AddWeightButton.frame.origin.y = 10+WeightChart.frame.origin.y+WeightChart.frame.size.height
        AddWeightButton.frame.origin.x=self.view.frame.size.width - AddWeightButton.frame.size.width-35+14

        weightText.frame.origin.y = 10+WeightChart.frame.origin.y+WeightChart.frame.size.height
        weightText.frame.origin.x = AddWeightButton.frame.origin.x - weightText.frame.size.width - 20
        

        //if chart data is not available
        WeightChart.noDataText = "No data available yet!"
        WeightChart.noDataTextColor = UIColor.black
        
        //initialize an array for the chart data
        var entries = [ChartDataEntry]()
        
        //add values in dataarray to the entries in the ChartDataEntry format
        for i in 0..<weightdatarray.count{
            let value = ChartDataEntry(x: Double(i), y: Double(weightdatarray[i]))
            entries.append(value)
        }
        //attach a label and create a new object
        let dataset = LineChartDataSet(entries: entries, label: "Weight")
        
        //make a variable/ object to add to lintplot?
        let data = LineChartData(dataSet: dataset)
        

        WeightChart.data = data
        
        //change line color for the plot
        //dataset.colors = ChartColorTemplates.material()
        dataset.colors = [UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1)]
        dataset.lineWidth = 2.0
        
        // bg color of the graph
        WeightChart.backgroundColor = UIColor(red: 69/255, green: 224/255, blue: 255/255, alpha: 0.2)
      
        //x Axis
        //move labels to  the btm
        WeightChart.xAxis.labelPosition = .bottom
        //setting font size and type
        WeightChart.xAxis.labelFont=UIFont(name: "Arial", size: 14)!
 
        //left y axis format
        self.WeightChart.leftAxis.labelFont=UIFont(name: "Arial", size: 14)!
        //remove right y-axis labels
        self.WeightChart.rightAxis.drawLabelsEnabled = false
 
        //marker changes
        dataset.setCircleColor(UIColor.green)
        dataset.valueFont=UIFont(name: "Arial", size: 12)!
        dataset.circleRadius = 6.0
        
        //change font size and stype for the legend
        //let legend = TemperatureChart.legend
        //legend.font = UIFont(name: "Verdana", size: 12)!
        //removing legend
        self.WeightChart.legend.enabled = false

        
        //animation
        //WeightChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .linear)
        WeightChart.leftAxis.drawGridLinesEnabled = false

        WeightChart.extraBottomOffset = 10
        WeightChart.extraTopOffset = 26
        //WeightChart.extraLeftOffset = 20
        WeightChart.extraRightOffset = 20
        WeightChart.fitScreen()
        //TemperatureChart.chartDescription?.text = "Temperature"
        
    }
   
}


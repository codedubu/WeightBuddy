//
//  CalculatorViewController.swift
//  WeightBuddy
//
//  Created by River McCaine on 2/9/21.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: - Properties
    
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    var system: String = "Imperial"
    
    // MARK: - Lifecycle Methods
    override func loadView() {
        super.loadView()
        addAllSubViews()
        setupAllConstraints()
        setUpCalculateButton()
        setUpSystemButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.4117647059, blue: 0.4784313725, alpha: 1)
    }
    
    // MARK: - Helper Methods
    func setupAllConstraints() {
        setUpLabelStackView()
        setUpTextFieldStackView()
        setUpLabelAndTextFieldStackView()
        constrainResultsLabel()
        constrainCalculateButton()
        constrainSwitcherButton()
        constrainSystemTypeLabel()
    }
    
    func addAllSubViews() {
        self.view.addSubview(systemTypeLabel)
        self.view.addSubview(bmiResultLabel)
        self.view.addSubview(weightTextField)
        self.view.addSubview(heightTextField)
        self.view.addSubview(weightLabel)
        self.view.addSubview(heightLabel)
        self.view.addSubview(labelStackView)
        self.view.addSubview(textFieldStackView)
        self.view.addSubview(labelsAndTextFieldsStackView)
        self.view.addSubview(calculateButton)
        self.view.addSubview(systemSwitcherButton)
    }
    
    // MARK: - Stack Views
    func setUpLabelStackView(){
        labelStackView.addArrangedSubview(heightLabel)
        labelStackView.addArrangedSubview(weightLabel)
    }
    
    func setUpTextFieldStackView(){
        textFieldStackView.addArrangedSubview(heightTextField)
        textFieldStackView.addArrangedSubview(weightTextField)
    }
    
    func setUpLabelAndTextFieldStackView(){
        labelsAndTextFieldsStackView.addArrangedSubview(labelStackView)
        labelsAndTextFieldsStackView.addArrangedSubview(textFieldStackView)
        labelsAndTextFieldsStackView.anchor(top: bmiResultLabel.bottomAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, paddingTop: 16, paddingBottom: 0, paddingLeft: 10, paddingRight: 10)

    }
    
    // MARK: - Constraints
    func constrainSystemTypeLabel() {
        systemTypeLabel.anchor(top: safeArea.topAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, paddingTop: 48, paddingBottom: 0, paddingLeft: 10, paddingRight: 10)
    }
    
    func constrainResultsLabel() {
        bmiResultLabel.anchor(top: systemTypeLabel.bottomAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, paddingTop: 88, paddingBottom: 0, paddingLeft: 10, paddingRight: 10)
    }
    
    func constrainSwitcherButton() {
        systemSwitcherButton.anchor(top: labelsAndTextFieldsStackView.bottomAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, paddingTop: 300, paddingBottom: 0, paddingLeft: 118, paddingRight: 118)
    }
    
    func constrainCalculateButton() {
        calculateButton.anchor(top: systemSwitcherButton.bottomAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, paddingTop: 48, paddingBottom: 0, paddingLeft: 88, paddingRight: 88)
        
    }
    
    func setUpSystemButton() {
        systemSwitcherButton.addTarget(self, action: #selector(systemButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Buttons
    @objc func systemButtonTapped(sender: UIButton) {
        if sender.titleLabel?.text == "Switch to Metric" {
            heightLabel.text = "Meters"
            weightLabel.text = "Kilograms"
            systemSwitcherButton.setTitle("Switch to Imperial", for: .normal)
            heightTextField.text = ""
            weightTextField.text = ""
            systemTypeLabel.text = "Current Unit System: Metric"
            system = "Metric"
        } else {
            heightLabel.text = "In Inches"
            weightLabel.text = "Pounds"
            systemSwitcherButton.setTitle("Switch to Metric", for: .normal)
            heightTextField.text = ""
            weightTextField.text = ""
            systemTypeLabel.text = "Current Unit System: Imperial"
            system = "Imperial"
        }
    }
    
    func setUpCalculateButton() {
        calculateButton.addTarget(self, action: #selector(calculateBMIButtonTapped), for: .touchUpInside)
    }
    
    @objc func calculateBMIButtonTapped() {
        guard let weight = weightTextField.text, !weight.isEmpty,
              let height = heightTextField.text, !height.isEmpty else { return }
        
        let weightAsDouble = Double(weight) ?? 0
        let heightAsDouble = Double(height) ?? 0
        
        var finalBMI = 0.0
        
        if system == "Imperial" {
            
            finalBMI = (weightAsDouble / (heightAsDouble * heightAsDouble)) * 703
        } else if system == "Metric" {
            finalBMI = weightAsDouble / (heightAsDouble * heightAsDouble)
        }
        
        
        bmiResultLabel.text = "BMI: \(String(format: "%.1f", finalBMI))"

    }
    
    // MARK: - Views
    let systemTypeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Current Unit System: Imperial"
        label.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.3921568627, blue: 0, alpha: 1)
        label.textColor = #colorLiteral(red: 0.9725490196, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        label.layer.cornerRadius = 16.8
        label.font = label.font.withSize(25)
        label.layer.masksToBounds = true
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    let bmiResultLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your measurements to see your BMI!"
        label.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.3921568627, blue: 0, alpha: 1)
        label.layer.cornerRadius = 10.8
        label.layer.masksToBounds = true
        label.contentMode = .center
        label.textAlignment = .center
        return label
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height in inches: "
        label.contentMode = .center
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Weight in lbs: "
        label.contentMode = .center
        return label
    }()
    
    let heightTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter height here...")
        return textField
    }()
    
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter weight here...")
        return textField
    }()
    
    let calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate!", for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.6509803922, blue: 0.168627451, alpha: 1)
        print(button.frame.height)
        button.layer.cornerRadius = 17.8
        button.layer.masksToBounds = true
        button.setTitleColor(#colorLiteral(red: 0.9725490196, green: 0.9450980392, blue: 0.9450980392, alpha: 1), for: .normal)
   
        return button
    }()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let labelsAndTextFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        stackView.layer.cornerRadius = 4.8
        stackView.layer.masksToBounds = true
        
        
        return stackView
    }()
    
    let systemSwitcherButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Switch Unit Systems", for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.6509803922, blue: 0.168627451, alpha: 1)
        button.layer.cornerRadius = 17.8
        button.layer.masksToBounds = true
        button.setTitleColor(#colorLiteral(red: 0.9725490196, green: 0.9450980392, blue: 0.9450980392, alpha: 1), for: .normal)
        
        return button
    }()
}

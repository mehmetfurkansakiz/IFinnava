//
//  TableViewCell.swift
//  IFinnava
//
//  Created by furkan sakız on 25.07.2024.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    
    private let fromCurrencyCodeLabel = UILabel()
    private let fromCurrencyNameLabel = UILabel()
    private let toCurrencyCodeLabel = UILabel()
    private let toCurrencyNameLabel = UILabel()
    private let exchangeRateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        fromCurrencyCodeLabel.font = UIFont.systemFont(ofSize: 14)
        fromCurrencyCodeLabel.textColor = .gray
        
        fromCurrencyNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        fromCurrencyNameLabel.textColor = .black
        
        toCurrencyCodeLabel.font = UIFont.systemFont(ofSize: 14)
        toCurrencyCodeLabel.textColor = .gray
        
        toCurrencyNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        toCurrencyNameLabel.textColor = .black
        
        exchangeRateLabel.font = UIFont.systemFont(ofSize: 18)
        exchangeRateLabel.textColor = UIColor(red: 0.0, green: 0.6, blue: 0.0, alpha: 1.0) // Slightly darker green
        
        contentView.addSubview(fromCurrencyCodeLabel)
        contentView.addSubview(fromCurrencyNameLabel)
        contentView.addSubview(toCurrencyCodeLabel)
        contentView.addSubview(toCurrencyNameLabel)
        contentView.addSubview(exchangeRateLabel)
        
        fromCurrencyCodeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
        }
        
        fromCurrencyNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(fromCurrencyCodeLabel)
            make.top.equalTo(fromCurrencyCodeLabel.snp.bottom).offset(5)
        }
        
        toCurrencyCodeLabel.snp.makeConstraints { make in
            make.leading.equalTo(fromCurrencyNameLabel.snp.trailing).offset(20)
            make.top.equalTo(fromCurrencyCodeLabel)
        }
        
        toCurrencyNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(toCurrencyCodeLabel)
            make.top.equalTo(toCurrencyCodeLabel.snp.bottom).offset(5)
        }
        
        exchangeRateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
        
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
            make.height.equalTo(100) // Adjust height as needed
        }
    }
    
    func configure(with currency: Currency) {
        fromCurrencyCodeLabel.text = currency.fromCurrencyCode
        fromCurrencyNameLabel.text = currency.fromCurrencyName
        toCurrencyCodeLabel.text = currency.toCurrencyCode
        toCurrencyNameLabel.text = currency.toCurrencyName
        exchangeRateLabel.text = String(format: "%.2f", currency.exchangeRate ?? 0.0)
    }
}

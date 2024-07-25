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

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    private func setupViews() {
        fromCurrencyCodeLabel.font = UIFont.systemFont(ofSize: 12)
        fromCurrencyCodeLabel.textColor = .gray
        
        fromCurrencyNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        fromCurrencyNameLabel.textColor = .black
        
        toCurrencyCodeLabel.font = UIFont.systemFont(ofSize: 12)
        toCurrencyCodeLabel.textColor = .gray
        
        toCurrencyNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        toCurrencyNameLabel.textColor = .black
        
        exchangeRateLabel.font = UIFont.systemFont(ofSize: 14)
        exchangeRateLabel.textColor = .green
        
        contentView.addSubview(fromCurrencyCodeLabel)
        contentView.addSubview(fromCurrencyNameLabel)
        contentView.addSubview(toCurrencyCodeLabel)
        contentView.addSubview(toCurrencyNameLabel)
        contentView.addSubview(exchangeRateLabel)
        
        fromCurrencyCodeLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
        }
        
        fromCurrencyNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(fromCurrencyCodeLabel)
            make.top.equalTo(fromCurrencyCodeLabel.snp.bottom).offset(5)
        }
        
        toCurrencyCodeLabel.snp.makeConstraints { make in
            make.leading.equalTo(fromCurrencyNameLabel.snp.trailing).offset(20)
            make.centerY.equalTo(fromCurrencyCodeLabel)
        }
        
        toCurrencyNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(toCurrencyCodeLabel)
            make.top.equalTo(toCurrencyCodeLabel.snp.bottom).offset(5)
        }
        
        exchangeRateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with currency: Currency) {
        fromCurrencyCodeLabel.text = currency.fromCurrencyCode
        fromCurrencyNameLabel.text = currency.fromCurrencyName
        toCurrencyCodeLabel.text = currency.toCurrencyCode
        toCurrencyNameLabel.text = currency.toCurrencyName
        exchangeRateLabel.text = String(currency.exchangeRate ?? 0.0)
    }

}

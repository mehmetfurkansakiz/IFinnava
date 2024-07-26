//
//  HomeViewController.swift
//  IFinnava
//
//  Created by furkan sakız on 25.07.2024.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    private let titleLabel =  UILabel()
    private let tableView =  UITableView()
    private let viewModel = CurrencyViewModel()
    private var currencies: [Currency] = []
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupTableView()
        bindViewModel()
        viewModel.getCurrencies()
    }

    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        view.backgroundColor = .white
        
        // Title Label
        titleLabel.text = "IFinnava Currency"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
    }
    
    private func setupTableView() {
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: "CurrencyCell")
        tableView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.currencyList
            .subscribe(onNext: { [weak self] list in
                self?.currencies = list
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyTableViewCell
        let currency = currencies[indexPath.row]
        cell.configure(with: currency)
        return cell
    }
}

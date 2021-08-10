//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 25.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSSettingsViewController: UIViewController {
    
    private enum SettingsType: CaseIterable {
        case switcher
        case color
    }

    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        return view
    }()
    
    private let presenter: RSSettingsPresenting
    
    init(_ presenter: RSSettingsPresenting = RSSettingsPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not this time, buddy")
    }
}

// MARK: - UIViewController interface

extension RSSettingsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

// MARK: - Private interface

private extension RSSettingsViewController {

    func setupAppearance() {
        navigationItem.title = presenter.settingsTitle
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.bind(to: view)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
}

// MARK: - UITableViewDataSource

extension RSSettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SettingsType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SettingsType.allCases[indexPath.row] {
        case .color:
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: UITableViewCell.reuseIdentifier)
            cell.textLabel?.text = presenter.colorRowTitle
            cell.detailTextLabel?.text = presenter.selectedColorString
            cell.accessoryType = .disclosureIndicator
            return cell
        case .switcher:
            let cell = UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.reuseIdentifier)
            cell.textLabel?.text = presenter.animationRowTitle
            let switcher = UISwitch()
            switcher.isOn = presenter.shouldAnimateStory
            switcher.addTarget(self, action: #selector(switchDrawing(_:)), for: .valueChanged)
            cell.accessoryView = switcher
            return cell
        }
    }
    
    @objc func switchDrawing(_ sender: UISwitch) {
        FortyTwo.shared.toggleAnimation(isOn: sender.isOn)
    }
}

extension RSSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch SettingsType.allCases[indexPath.row] {
        case .color:
            cell.detailTextLabel?.textColor = presenter.selectedColor
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch SettingsType.allCases[indexPath.row] {
        case .color:
            let controller = RSColorSettingsViewController(presenter)
            navigationController?.pushViewController(controller, animated: true)
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

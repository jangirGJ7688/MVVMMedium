//
//  PlaceListController.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 02/08/2024.
//

import UIKit

class PlaceListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var viewModel: PlaceListVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        setUpUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareView(viewModel: PlaceListVM) {
        self.viewModel = viewModel
        observeEvents()
    }
    
    private func setUpUI() {
        titleLabel.text = viewModel.title
    }
    
    private func prepareTableView() {
        tableView.dataSource = self
        PlaceTableCell.registerWithTable(tableView)
    }
    
    private func observeEvents() {
        viewModel.placeSelected = { [weak self] place in
            DispatchQueue.main.async {
                self?.navigateToPlaceDetailScreenWithPlace(place)
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: Routing
extension PlaceListController {
    
    private func navigateToPlaceDetailScreenWithPlace(_ place: PlaceModel) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "PlaceDetailController") as! PlaceDetailController
        let placeViewVM = PlaceDetailVM(place: place)
        controller.prepareView(viewModel: placeViewVM)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

// MARK: UITableViewDataSource
extension PlaceListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableCell.reuseIdentifier, for: indexPath) as! PlaceTableCell
        cell.prepareCell(viewModel: viewModel.cellViewModel(indexPath: indexPath))
        return cell
    }
    
}

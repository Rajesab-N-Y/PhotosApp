//
//  TableViewController.swift
//  PhotosApp
//
//  Created by Rajesab N Y on 27/05/23.
//
import UIKit

class TableViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var viewModel = TableViewModel()
    
    private var isRefreshing: Bool = false
    private var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        // Create a custom refresh control
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    private func fetchData() {
        viewModel.fetchData { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc private func refreshData() {
        if !isRefreshing {
            isRefreshing = true
            viewModel.cleanData()
            tableView.reloadData()
            showLoadingIndicator()
            viewModel.fetchData { [weak self] _ in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.hideLoadingIndicator()
                }
            }
        }
    }
    
    private func showLoadingIndicator() {
        refreshControl.beginRefreshing()
        tableView.setContentOffset(CGPoint(x: 0, y: -refreshControl.frame.size.height), animated: true)
    }
    
    private func hideLoadingIndicator() {
        refreshControl.endRefreshing()
        isRefreshing = false
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let item = viewModel.data[indexPath.row]
        cell.configure(with: item, width: tableView.bounds.width, checkBoxData: viewModel.getCheckBoxData(id: item.download_url ?? ""), checkBoxActionObserver: self)
        return cell
    }
}

extension TableViewController: CheckBoxActionObserver {
    func chechBoxAction(isChecked: Bool, imageDetails: ImageDetails) {
        if let id = imageDetails.id {
            viewModel.setCheckBoxData(id: id, isChecked: isChecked)
        }
        if isChecked {
            showDescriptionDialog(for: imageDetails)
        } else {
            showAlert()
        }
    }
    
    private func showDescriptionDialog(for imageDetails: ImageDetails) {
        let message = "Image Id: \(imageDetails.id ?? "")\nAuthor: \(imageDetails.author ?? "")"
        let alertController = UIAlertController(title: "Description", message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Alert", message: "Checkbox is disabled.", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
}
extension TableViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let tableViewHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - tableViewHeight {
            fetchData()
        }
    }
}


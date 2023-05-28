//
//  TableViewModel.swift
//  PhotosApp
//
//  Created by Rajesab N Y on 27/05/23.
//

import UIKit

class TableViewModel {
    private var items: [ImageDetails] = []
    private var currentPage: Int = 1
    private let pageSize: Int = 20 // pagination limit
    private var isLoading = false
    
    var itemCount: Int {
        return items.count
    }
    
    var data: [ImageDetails] {
        return items
    }
    
    // Method to get data from server
    func fetchData(completion: @escaping (Bool) -> Void) {
        guard !isLoading else { return }
        isLoading = true
        
        let urlString = "https://picsum.photos/v2/list?page=\(currentPage)&limit=\(pageSize)"
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let itemList = try decoder.decode([ImageDetails].self, from: data)
                self?.items.append(contentsOf: itemList)
                self?.currentPage += 1
                self?.isLoading = false
                completion(true)
            } catch {
                self?.isLoading = false
                completion(false)
            }
        }.resume()
    }
    
    func getItem(at index: Int) -> ImageDetails? {
        guard index >= 0 && index < items.count else {
            return nil
        }
        return items[index]
    }
}




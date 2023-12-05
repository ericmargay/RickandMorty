//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Eric Margay on 02/12/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var currentPage: Int = 1
        var queryPaginate: [String: String] = ["page": "1"]

        lazy var urlSession = URLSession.shared

        lazy var client: Client = {
            return Client(session: self.urlSession, baseUrl: "https://rickandmortyapi.com")
        }()

        lazy var restClient: RESTClient<PaginatedResponse<Character>> = {
            return RESTClient<PaginatedResponse<Character>>(client: self.client)
        }()

        var characters: [Character]? {
            didSet {
                tableView.reloadData()
            }
        }

        var backgroundColors: [UIColor] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        fetchData()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Update content inset and scroll indicator inset
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }





        private func fetchData() {
            restClient.show("/api/character/", queryParams: queryPaginate) { response in
                self.characters = response.results
                self.setBackgroundColorsForNewData()
                self.fetchAdditionalPages(response.info.next) // Fetch additional pages
            }
        }

        private func fetchAdditionalPages(_ nextPage: String?) {
            guard let nextPage = nextPage else { return }

            let queryParams = extractQueryParams(from: nextPage)
            restClient.show("/api/character/", queryParams: queryParams) { response in
                self.characters?.append(contentsOf: response.results)
                self.setBackgroundColorsForNewData()
                self.fetchAdditionalPages(response.info.next)
            }
        }

        private func extractQueryParams(from urlString: String) -> [String: String] {
            guard let url = URL(string: urlString),
                  let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                  let queryItems = components.queryItems else {
                return [:]
            }

            var queryParams: [String: String] = [:]
            for queryItem in queryItems {
                queryParams[queryItem.name] = queryItem.value
            }

            return queryParams
        }

        private func setBackgroundColorForCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
            guard let charactersCount = characters?.count else { return }

            // Calculate the set index based on the row index
            let setIndex = indexPath.row / charactersCount

            // Use the set index to get the corresponding color
            let colorIndex = setIndex % backgroundColors.count
            let color = backgroundColors[colorIndex]

            cell.backgroundColor = color
        }

    private func setBackgroundColorsForNewData() {
        guard let charactersCount = characters?.count else { return }

        // Generate random colors for the new data
        backgroundColors = (0..<charactersCount).map { index in
            if index == 0 {
                // Set the first color to black
                return .black
            } else {
                return UIColor(
                    red: CGFloat(drand48()),
                    green: CGFloat(drand48()),
                    blue: CGFloat(drand48()),
                    alpha: 1.0
                )
            }
        }

        tableView.reloadData()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (characters?.count ?? 0) * 10 // Increase the number of rows to repeat the sets
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell

        if let character = characters?[indexPath.row % (characters?.count ?? 1)] {
            cell.nameLabel.text = character.name
            cell.speciesLabel.text = character.species
        }

        setBackgroundColorForCell(cell, at: indexPath)

        return cell
    }
}

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let characters = characters else { return }
        let needsFetch = indexPaths.contains { $0.row >= characters.count * 9 }

        if needsFetch {
            restClient.show("/api/character/", queryParams: queryPaginate) { response in
                self.characters?.append(contentsOf: response.results)
                self.setBackgroundColorsForNewData()
            }
            queryPaginate = ["page": "\(currentPage += 1)"]
        }
    }
}

//
//  TrackListViewController.swift
//  AudioPlayer
//
//  Created by Кирилл Заборский on 06.09.2021.
//

import UIKit
import Alamofire

class SearchMusicViewController: UITableViewController {
    
    var networkService = NetworkService()
    private var timer: Timer?
    var tracks = AudioClass.shared.playList
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackName", for: indexPath)
        
        let track = tracks[indexPath.row]
        cell.textLabel?.text = "\(track.trackName)\n\(String(describing: track.artistName))"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image =  #imageLiteral(resourceName: "image")
        print(track)
        return cell
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let trackDetailVC = segue.destination as! TrackDetailsViewController
        trackDetailVC.track = tracks[indexPath.row]
    }
    
}

extension SearchMusicViewController: UISearchBarDelegate {
    func  searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)  {
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkService.fetchTracks(searchText: searchText) { [weak self] (searchResults) in
                self?.tracks = searchResults?.results ?? []
                self?.tableView.reloadData()
            }
        })
    }
}

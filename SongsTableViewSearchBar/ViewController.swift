

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var song = Song.loveSongs
    @IBOutlet var songSearch: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        songSearch.delegate = self
    }
    
    var songSeach:[Song] {
        get{
            guard let searchSongString = searchSongString else {
                return song
            }
            guard searchSongString != "" else {
                return song
            }
            
            if let scoptTitles = songSearch.scopeButtonTitles {
                let currentScopeIndex = songSearch.selectedScopeButtonIndex
                
                switch scoptTitles[currentScopeIndex]{
                case "Songs":
                    return song.filter({$0.name.contains(searchSongString)})
                case "Artist":
                    return
                        song.filter({$0.artist.contains(searchSongString)})
                default:
                    return song
                }
            }
            return song
        }
    }
 
    
    var searchSongString:String? = nil {
        didSet {
            self.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songSeach.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "songCell"){
       let info = songSeach[indexPath.row]
        cell.textLabel?.text = info.name
        cell.detailTextLabel?.text = info.artist
        
        return cell
    }
    }

  
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchSongString = searchBar.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }


}


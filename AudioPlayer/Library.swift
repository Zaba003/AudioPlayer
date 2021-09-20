//
//  Library.swift
//  AudioPlayer
//
//  Created by Кирилл Заборский on 12.09.2021.
//

import SwiftUI
import URLImage
import URLImageStore

struct Library: View {
    
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var showingAlert = false
    @State private var track: SearchViewModel.Cell!
    
    var tabBarDelegate: MainTabBarControllerDelegate?
    
    var body: some View {
        NavigationView {
            VStack() {
                GeometryReader { geometry in
                    HStack() {
                        Button(action: {
                            self.track = self.tracks[0]
                            self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                        }, label: {
                            Image(systemName: "play.fill")
                                .accentColor(Color.init(#colorLiteral(red: 0.9921568627, green: 0.1764705882, blue: 0.3333333333, alpha: 1)))
                                .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 50)
                                .background(Color.init(#colorLiteral(red: 0.9531342387, green: 0.9490900636, blue: 0.9562709928, alpha: 1)))
                                .cornerRadius(10)
                        })
                        Spacer()
                        Button(action: {
                            self.tracks = UserDefaults.standard.savedTracks()
                        }, label: {
                            Image(systemName: "arrow.2.circlepath")
                                .accentColor(Color.init(#colorLiteral(red: 0.9921568627, green: 0.1764705882, blue: 0.3333333333, alpha: 1)))
                                .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 50)
                                .background(Color.init(#colorLiteral(red: 0.9531342387, green: 0.9490900636, blue: 0.9562709928, alpha: 1)))
                                .cornerRadius(10)
                        })
                    }
                }.padding().frame(height: 70)
                
                List() {
                    ForEach(tracks) { track in
                        LibraryCell(cell: track).gesture(
                            LongPressGesture()
                                .onEnded { _ in
                                    print("Pressed!")
                                    self.track = track
                                    self.showingAlert = true
                                }
                                .simultaneously(with: TapGesture()
                                                    .onEnded { _ in
                                                        //                                        let keyWindow = UIApplication.shared.connectedScenes.filter({
                                                        //                                            $0.activationState == .foregroundActive
                                                        //                                        }).map({$0 as? UIWindowScene}).compactMap({
                                                        //                                            $0
                                                        //                                            }).first?.windows.filter({$0.isKeyWindow}).first
                                                        let keyWindow = UIApplication.shared.connectedScenes
                                                            .filter({$0.activationState == .foregroundActive})
                                                            .map({$0 as? UIWindowScene})
                                                            .compactMap({$0})
                                                            .first?.windows
                                                            .filter({$0.isKeyWindow}).first
                                                        let tabBarVC = keyWindow?.rootViewController as? MainTabBarController
                                                        tabBarVC?.trackDetailView.delegate = self
                                                        
                                                        
                                                        self.track = track
                                                        self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                                                    }))
                    }
                    .onDelete(perform: delete)
                    
                }.padding()
                
            }.actionSheet(isPresented: $showingAlert, content: {
                ActionSheet(title: Text("Are you sure you want to delete this track?"), buttons: [.destructive(Text("Delete"), action: {
                    print("Deleting: \(self.track.trackName)")
                    self.delete(track: self.track)
                }), .cancel()
                ])
            })
            .navigationBarTitle("Library")
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
    func delete(track: SearchViewModel.Cell) {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return }
        tracks.remove(at: myIndex)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
}

struct LibraryCell: View {
    
    var cell: SearchViewModel.Cell
    let urlImageService = URLImageService(fileStore: URLImageFileStore(),
                                          inMemoryStore: URLImageInMemoryStore())
    var body: some View {
        HStack {
            URLImage(URL(string: cell.iconUrlString ?? "")!) {image in image
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(2)
            }.environment(\.urlImageService, urlImageService)
            VStack(alignment: .leading) {
                Text("\(cell.trackName)")
                Text("\(cell.artistName)")
            }
        }
        
    }
    
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}

extension Library: TrackMovingDelegate {
    
    func moveBackForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        if myIndex - 1 == -1 {
            nextTrack = tracks[tracks.count - 1]
        } else {
            nextTrack = tracks[myIndex - 1]
        }
        self.track = nextTrack
        return nextTrack
    }
    
    func moveForvardForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        if myIndex + 1 == tracks.count {
            nextTrack = tracks[0]
        } else {
            nextTrack = tracks[myIndex + 1]
        }
        self.track = nextTrack
        return nextTrack
    }
}

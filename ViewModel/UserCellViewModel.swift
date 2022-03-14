//
//  UserCellViewModel.swift
//  FindAR
//
//  Created by Dev Patel on 2/10/22.
//

import Foundation
import Combine

class UserCellViewModel: ObservableObject, Identifiable{
    @Published var userRepo=UserRepository()
    @Published var user: User
    
    var id:String = ""
    private var cancellable = Set<AnyCancellable>()
    var ifCompletedIcon: String = ""
    
    init(user: User){
        self.user=user
        
        $user
            .compactMap{user in
                user.id
            }
        .assign(to: \.id, on: self)
        .store(in: &cancellable)
    }
    static func newTask() -> UserCellViewModel {
      UserCellViewModel(user: User( userName: "", email: ""))
    }
    

}

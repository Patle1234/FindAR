//
//  UserListViewModel.swift
//  FindAR
//
//  Created by Dev Patel on 2/10/22.
//

import Foundation
import Combine

class UserListViewModel: ObservableObject{//list of all of the tasks on the screen
    @Published var UserCellViewModels = [UserCellViewModel]()
    @Published var userRepository=UserRepository()

    private var cancellable = Set<AnyCancellable>()
    
    init(){
        userRepository.$users
            .map{users in//adding our tasks to TCVM
            users.map{user in
                UserCellViewModel(user:user)
            }
        }
         .assign(to: \.UserCellViewModels,on:self)
        .store(in: &cancellable)
        
//        print("herelookie")
//        print(UserCellViewModels.count)
    }
    
    
    func addUser(user: User){//adds a task to the ViewModel
        print("in?")
        userRepository.addUser(user)
        let userVM = UserCellViewModel(user: user)
        self.UserCellViewModels.append(userVM)
    }
    
    
//    func updateUser(user: User){
//        userRepository.updateUser(user)
//    }
//
    func deleteUser(user: User){
        userRepository.deleteUser(user)
        let userVM = UserCellViewModel(user: user)
        self.UserCellViewModels.removeAll{$0.id==userVM.id}
    }
//
//    func deleteFriend(currentUser: User,otherUser:User){
//        let userVM = UserCellViewModel(user: otherUser)
//        let currentUserVM = UserCellViewModel(user: currentUser)
//
//        userVM.user.friends.removeAll{$0==currentUserVM.user.userName}
//        userRepository.updateUser(userVM.user)
//
//        currentUserVM.user.friends.removeAll{$0==userVM.user.userName}
//        userRepository.updateUser(currentUserVM.user)
//    }
}

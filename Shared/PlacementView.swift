////
////  PlacementView.swift
////  FindAR
////
////  Created by Dev Patel on 2/24/22.
////
//
//import SwiftUI
//
//struct PlacementView: View{
//    @EnvironmentObject var placementSettings: PlacementSettings
//    var body: some View{
//        HStack{
//            Spacer()
//            PlacementButton(systemButtonIcon: "xmark.circle.fill", action: {
//                print("Cancel Placement Of Object")
//                self.placementSettings.selectedModel=nil
//            })
//            Spacer()
//
//            PlacementButton(systemButtonIcon: "checkmark.circle.fill", action: {
//                print("Confirm Placement Of Object")
//                self.placementSettings.confirmedModel=self.placementSettings.selectedModel
//                self.placementSettings.selectedModel=nil
//            })
//            Spacer()
//
//        }
//        .padding(.bottom,30)
//    }
//}
//
//
//struct PlacementButton : View{
//    var systemButtonIcon: String
//    let action: () -> Void
//    
//    var body: some View{
//        Button(action: {
//            self.action()
//        }, label: {
//            Image(systemName: systemButtonIcon)
//                .font(.system(size:50,weight: .light,design: .default))
//                .buttonStyle(PlainButtonStyle())
//        })
//            .frame(width: 75, height: 75)
//        
//    }
//    
//}

//
//  profileView.swift
//  Tori pages
//
//  Created by Leon Singleton on 5/26/24.
//

import SwiftUI
import AppIntents
import PhotosUI
import UIKit
import SwiftData

struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    var onImagePicked: ((UIImage) -> Void)?
    
    @Environment(\.modelContext) var modelContext
    @Query var userProfile: [Profile]
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct ProfileView: View {
    @State var selected = 1
    @State private var selectedImage: UIImage?
    @State private var showSheet: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showImagePicker = false
    @Binding var selectedTab: Int
    
    @Environment(\.modelContext) var modelContext
    @Query var userProfile: [Profile]
    
    init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
        UISegmentedControl.appearance().selectedSegmentTintColor = .accent
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UISegmentedControl.appearance().backgroundColor = UIColor(.white.opacity(0.1))
    }
    
    var body: some View {
        GeometryReader { geoProx in
            VStack {
                //Top half
                ZStack {
                    Image("ProfileBackground")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea(.all)
                        .frame(width: geoProx.size.width, height: geoProx.size.height * 0.25)
                        .offset(y: -geoProx.size.height * 0.15)
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                // Handle Settings
                            } label: {
                                Image(systemName: "gearshape.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            .padding(.trailing)
                        }
                        HStack{
                            Button {
                                showSheet = true
                            } label: {
                                if let selectedImage = selectedImage {
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: geoProx.size.width * 0.2, height: geoProx.size.width * 0.2)
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                        .shadow(radius: 5)
                                } else if let imageData = userProfile.first?.profilePicture, let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: geoProx.size.width * 0.2, height: geoProx.size.width * 0.2)
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                        .shadow(radius: 5)
                                } else {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: geoProx.size.width * 0.2, height: geoProx.size.width * 0.2)
                                        .overlay(
                                            Text("\(userProfile.first?.firstName.prefix(1) ?? " ")\(userProfile.first?.lastName.prefix(1) ?? " ")")
                                                .font(.title2)
                                                .fontWeight(.bold))
                                        .foregroundColor(.gray)
                                }
                            }
                            .actionSheet(isPresented: $showSheet, content: {
                                ActionSheet(title: Text("") , buttons: [
                                    .default(Text("Select from Gallery")) {
                                        sourceType = .photoLibrary
                                        showImagePicker = true
                                    },
                                    //                                    .default(Text("Camera")) {
                                    //                                        sourceType = .camera
                                    //                                        showImagePicker = true
                                    //                                    },
                                        .cancel()
                                ])
                            })
                            .sheet(isPresented: $showImagePicker) {
                                ImagePicker(sourceType: sourceType, selectedImage: $selectedImage)
                                .ignoresSafeArea()
                            }
                            .padding(.leading)
                            HStack {
                                Text("\(userProfile.first?.firstName ?? " ") \(userProfile.first?.lastName.prefix(1) ?? " ").")
                            }
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .padding(.leading, 15)
                            .foregroundStyle(.white)
                            Spacer()
                            
                        }
                        .padding(.bottom, geoProx.size.height*0.02)
                        Picker(selection: $selected, label: Text("")) {
                            Text("Visited").tag(1)
                            Text("Favorites").tag(2)
                            //                            Text("Favorites").tag(3)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .foregroundStyle(.white)
                        .padding(.leading)
                        .padding(.trailing)
                        
                    }
                }
                //Bottom half
                ZStack {
                    Color(CustomColor.grayBG)
                    ScrollView{
                        VStack{
                            Spacer()
                            if selected == 1 {
                                VisitedView(selectedTab: $selectedTab, geoProx: geoProx)
                            }
                            else if selected == 2 {
                                MustTryView(selectedTab: $selectedTab, geoProx: geoProx)
                            }
                            //                            else {
                            //                                FavoritesView(geoProx: geoProx)
                            //                            }
                        }
                        Spacer()
                        
                    }
                }
            }
            .onChange(of: selectedImage) {
                if let imageData = selectedImage?.jpegData(compressionQuality: 0.8) {
                    if let profile = userProfile.first {
                        profile.profilePicture = imageData
                        do {
                            try modelContext.save()
                            print("Successfully saved Image")
                        } catch {
                            print("Failed to save image data: \(error)")
                        }
                    }
                }
            }
        }
    }
}



//#Preview {
//    ProfileView()
//}

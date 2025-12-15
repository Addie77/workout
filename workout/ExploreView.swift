//
//  ExploreView.swift
//  workout
//
//  Created by user0862 on 2025/12/5.
//

import SwiftUI
import UniformTypeIdentifiers

struct ExploreView: View {
    @State private var searchText = ""
    @State private var selectedSegment = 0
    @State private var showingCreateExerciseView = false
    @EnvironmentObject var customExerciseManager: CustomExerciseManager
    @State private var showingExporter = false
    @State private var documentToExport: ExerciseDocument?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("搜尋動作...", text: $searchText)
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // Segmented Control
                    Picker("Filter", selection: $selectedSegment) {
                        Text("官方動作庫").tag(0)
                        Text("我的自訂").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    if selectedSegment == 0 {
                        // Category Grid
                        Text("按部位分類")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            NavigationLink(destination: ExerciseListView(categoryName: "胸部")) {
                                CategoryCard(imageName: "chest-banner", categoryName: "胸部")
                            }
                            NavigationLink(destination: ExerciseListView(categoryName: "背部")) {
                                CategoryCard(imageName: "back-banner", categoryName: "背部")
                            }
                            NavigationLink(destination: ExerciseListView(categoryName: "腿部")) {
                                CategoryCard(imageName: "legs-banner", categoryName: "腿部")
                            }
                            NavigationLink(destination: ExerciseListView(categoryName: "手臂")) {
                                CategoryCard(imageName: "arms-banner", categoryName: "手臂")
                            }
                            NavigationLink(destination: ExerciseListView(categoryName: "其他")) {
                                CategoryCard(imageName: "body-banner", categoryName: "其他")
                            }
                            NavigationLink(destination: ExerciseListView(categoryName: "核心")) {
                                CategoryCard(imageName: "core-banner", categoryName: "核心")
                            }
                            ZStack (alignment: .bottom){
                                NavigationLink(destination: ExerciseListView(categoryName: "器材")) {
                                    CategoryCard(imageName:"Dumbbells",categoryName: "器材")
                                        .colorMultiply(Color(.systemGray4))
                                }
                                Text("器材")
                                    .padding()
                            }
                            
                        }
                        .padding(.horizontal)
                    } else {
                        // Custom Exercises List
                        if customExerciseManager.customExercises.isEmpty {
                            VStack {
                                Spacer()
                                Text("您尚未建立任何自訂動作。")
                                    .foregroundColor(.secondary)
                                    .padding()
                                Spacer()
                            }
                        } else {
                            VStack {
                                ForEach(customExerciseManager.customExercises.map { $0.category }.unique(), id: \.self) { category in
                                    Section(header:
                                                Text(category)
                                        .font(.headline)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 8)
                                        .background(Color(UIColor.systemGroupedBackground))
                                    ) {
                                        ForEach(customExerciseManager.customExercises.filter { $0.category == category }) { exercise in
                                            NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                                                ExerciseRow(exercise: exercise)
                                            }
                                            Divider()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Spacer() // Add a spacer to push content to the top
                } // End of VStack
                .navigationTitle("探索")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        if selectedSegment == 1 {
                            // EditButton() // EditButton doesn't work with VStack
                            Button(action: {
                                documentToExport = ExerciseDocument(exercises: customExerciseManager.customExercises)
                                showingExporter = true
                            }) {
                                Image(systemName: "square.and.arrow.up")
                            }
                        }
                        
                        Button(action: {
                            showingCreateExerciseView = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                    }
                }
                .sheet(isPresented: $showingCreateExerciseView) {
                    CreateExerciseView()
                }
                .fileExporter(isPresented: $showingExporter, document: documentToExport, contentType: .json) { result in
                    switch result {
                    case .success(let url):
                        print("Saved to \(url)")
                    case .failure(let error):
                        print("Failed to save: \(error.localizedDescription)")
                    }
                }
            }
                }
            }
        
                private func deleteCustomExercise(at offsets: IndexSet, in category: String) {
            let exercisesInCategory = customExerciseManager.customExercises.filter { $0.category == category }
            let exercisesToDelete = offsets.map { exercisesInCategory[$0] }
            let idsToDelete = Set(exercisesToDelete.map { $0.id })
            customExerciseManager.deleteExercises(ids: idsToDelete)
        }
    }
    
    struct CategoryCard: View {
        let imageName: String
        let categoryName: String
        
        var body: some View {
            VStack {
                Spacer()
                Text(categoryName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
            }
            .frame(height: 120)
            .frame(maxWidth: .infinity)
            .background(
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .clipped()
            .cornerRadius(20)
        }
    }
    
    struct ExploreView_Previews: PreviewProvider {
        static var previews: some View {
            ExploreView()
                .environmentObject(CustomExerciseManager())
        }
    }


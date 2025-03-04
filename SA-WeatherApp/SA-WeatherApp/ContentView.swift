//
//  ContentView.swift
//  SA-WeatherApp
//
//  Created by Tejas on 2025-03-01.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var model: TodoModel?
    
    func getAllTodoList() async throws {
        let model = try await APIManagerWrapper.sharedInstance.getTodoList()
        await MainActor.run {
            self.model = model
        }
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                ForEach(viewModel.model?.todos ?? [], id: \.id) { todo in
                    //                GeometryReader { geoReader in
                    HStack(spacing: 20) {
                        
                        Image(systemName: "globe")
                        
                        VStack(alignment: .leading) {
                            Text(todo.todo ?? "NA")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                            if let completed = todo.completed {
                                Text("Completed: \(completed ? "true" : "false")")
                                    .font(.subheadline)
                                    .foregroundColor(todo.completed ?? false ? .green : .red)
                            }
                            Spacer()
                        }
                    }
                    //                    .fixedSize(horizontal: true, vertical: false)
                    //                    .frame(width: geoReader.size.width, height: 80)
                    .padding([.top, .bottom], 10)
                    //                }
                }
            }
            .navigationTitle("Extreme Todos")
            .padding()
        }
        .task {
            do {
                try await viewModel.getAllTodoList()
            } catch {
                
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

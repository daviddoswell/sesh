import SwiftUI

struct SessionListView: View {
  
  // MARK: - PROPERTIES
  @Environment(\.dismiss) var dismiss
  @ObservedObject var viewModel: SessionViewModel
  
  // MARK: - BODY
  var body: some View {
    NavigationView {
      ZStack {
        Color.colorBlue
          .ignoresSafeArea()
        
        if viewModel.isLoading {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .scaleEffect(2)
        } else {
          if viewModel.sessions.isEmpty {
            emptyStateView
          } else {
            sessionListView
          }
        }
      } //: ZSTACK
      .navigationTitle("Sessions")
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          backButton
        }
      } //: TOOLBAR
    } //: NAVIGATION VIEW
    .navigationViewStyle(StackNavigationViewStyle())
  }
  
  // MARK: - FUNCTIONS
  
  private var backButton: some View {
    Button(action: {
      dismiss()
    }) {
      Image(systemName: "chevron.left")
        .foregroundColor(.white)
        .imageScale(.large)
    } //: BUTTON
  }
  
  // MARK: - EMPTY STATE
  private var emptyStateView: some View {
    VStack {
      Spacer()
      Image(systemName: "heart.circle.fill")
        .resizable()
        .scaledToFit()
        .foregroundStyle(.white)
        .padding()
      Text("No sessions yet")
        .font(.system(size: 30.0, weight: .heavy, design: .rounded))
        .foregroundColor(.white)
        .padding(.bottom, 150)
      
      Button(action: {
        dismiss()
      }) {
        HStack {
          Image(systemName: "clock.circle.fill")
            .imageScale(.large)
            .foregroundStyle(Color.colorBlue)
            .padding(.leading, 20)
          Text("Take a Minute")
            .foregroundStyle(Color.colorBlue)
            .font(.system(.title3, design: .rounded))
            .fontWeight(.bold)
            .padding(.trailing, 20)
        } //: HSTACK
        .padding()
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 2)
      } //: BUTTON
      .controlSize(.large)
      .padding(.horizontal, 40)
      
      Spacer()
    } //: VSTACK
    .background(Color.colorBlue)
  }
  
  // MARK: - SESSION LIST VIEW
  private var sessionListView: some View {
    List {
      ForEach(viewModel.sessions) { session in
        HStack {
          VStack(alignment: .leading) {
            Text(session.title)
              .font(.system(size: 20.0, weight: .heavy, design: .rounded))
              .foregroundColor(.white)
            Text(session.description)
              .font(.system(size: 15.0, weight: .heavy, design: .rounded))
              .foregroundColor(.white)
          } //: VSTACK
          Spacer()
          Text(session.date.formatted(.dateTime.month().day().year().hour().minute()))
            .font(.system(size: 15.0, weight: .heavy, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.white)
        } //: HSTACK
        .listRowBackground(Color.colorBlue)
      } //: FOR EACH
      .listRowSeparator(.hidden)
    } //: LIST
    .listStyle(PlainListStyle())
  }
}

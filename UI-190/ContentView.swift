//
//  ContentView.swift
//  UI-190
//
//  Created by にゃんにゃん丸 on 2021/05/16.
//

import SwiftUI

struct ContentView: View {
    @State var selected = "paper"
    init() {
        #if os(iOS)
        UITabBar.appearance().isHidden = true
        #endif
        
    }
    //paperplane.circle.fill
    //lock.doc.fill
    //dot.arrowtriangles.up.right.down.left.circle
    //megaphone.fill
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ZStack(alignment: getDivice() == .iPhone ? .bottom : .leading){
            
            #if os(iOS)
            
            TabView(selection:$selected){
                
                
                Color.red
                    .tag("paper")
                    .ignoresSafeArea(.all, edges: .all)
                
                Color.green
                    .tag("lock")
                    .ignoresSafeArea(.all, edges: .all)
                
                
                Color.purple
                    .tag("dot")
                    .ignoresSafeArea(.all, edges: .all)
                
                
                Color.pink
                    .tag("mega")
                    .ignoresSafeArea(.all, edges: .all)
                
                
                
            }
            
            #else
            
            ZStack{
                
                switch selected{
                
                case "paper" : Color.red
                case "lock" : Color.blue
                case "dot" : Color.yellow
                case "mega" : Color.green
                    
                    
                default : Color.clear
                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            #endif
            
            
            if self.getDivice() == .iPad || self.getDivice() == .macOS{
                
                
                VStack(spacing:0){
                    
                    
                    InsideTabButton(selected: $selected)
                    
                    Spacer()
                }
                .background(scheme == .dark ? Color.black : Color.white)
                
            }
            
            
            else{
                
                HStack{
                    
                    InsideTabButton(selected: $selected)
                    
                }
                .frame(maxWidth: .infinity,alignment: .leading)
               
                .background(scheme == .dark ? Color.black : Color.white)
                
              
                
            }
            
            
                
                
                
                
                
                
            
           
            
            
        
            
        }
        .ignoresSafeArea(.all, edges: getDivice() == .iPhone ? .bottom : .all)
        .frame(width: getDivice() == .iPad || getDivice() == .iPhone ? nil : getRect().width / 1.6, height:  getDivice() == .iPad || getDivice() == .iPhone ? nil : getRect().height - 150)
        
        

    }
}

struct InsideTabButton : View {
    @Binding var selected : String
    var body: some View{
        
        
        Group{
            
            TabButton(title: "paper", image: "paperplane.circle.fill", selected: $selected)
                .padding(.top,getDivice() == .iPhone ? 0 : 35)
                .padding(.bottom,getDivice() == .iPhone ? 0 : 15)
            
            TabButton(title: "lock", image: "lock.doc.fill", selected: $selected)
            
            TabButton(title: "dot", image: "dot.arrowtriangles.up.right.down.left.circle", selected: $selected)
            
            TabButton(title: "mega", image: "megaphone.fill", selected: $selected)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TabButton : View {
    var title : String
    var image : String
    @Binding var selected : String
    var body: some View{
        
        Button(action: {
            
            withAnimation(.easeInOut){
                
                selected = title
            }
            
        }, label: {
            VStack(spacing:20){
                
             Image(systemName: image)
                .font(.system(size:getDivice() == .iPhone ? 20 : 25, weight: .bold))
                .foregroundColor(selected == title ? .white : .primary)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(selected == title ? .white : .primary)
                    
                
                
            }
            .frame(width: self.getDivice() == .iPhone ? (self.getRect().width - 75) / 3.3 : 100, height: 55 + self.getSafeArea())
            .background(Color.purple.offset(x:selected == title ? 0 : getDivice() == .iPhone ? 0 : -100, y: selected == title ? 0 : getDivice() == .iPhone ? 100 : 0))
        })
        .buttonStyle(PlainButtonStyle())
    }
}

extension View{
    
    
    func getRect()->CGRect{
        #if os(iOS)
        
        return UIScreen.main.bounds
        
        #else
        NSScreen.main!.visibleFrame
        
        #endif
        
    }
    
    func getSafeArea()->CGFloat{
        
        #if os(iOS)
        
        return  UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 10
        
        #else
        return 10
        
        #endif
    }
    
    func getDivice()->device{
        
        #if os(iOS)
        if UIDevice.current.model.contains("iPad"){
            
            
            return .iPad
        }
        
        else{
            
            return .iPhone
        }
        
        
        #else
        
        return .macOS
        
        #endif
        
    }
}

enum device{
    
    case iPhone
    case iPad
    case macOS
    
    
}

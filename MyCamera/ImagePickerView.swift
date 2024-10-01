//
//  ImagePickerView.swift
//  MyCamera
//
//  Created by apple on 2024/09/28.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    //    var body: some View {
    //        Text()
    //    }
    //UIImagePickerController(写真撮影)が表示されているかを管理
    @Binding var isShowSheet: Bool
    //撮影した写真を格納する変数
    @Binding var captureImage: UIImage?
    
    //Coordinatorでコントローラのdelegateを管理
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        //ImagePickerView型の定数を用意
        let parent: ImagePickerView
        
        //イニシャライザ
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        //撮影が終わった時に呼ばれるdelegateメソッド、必ず必要
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            //撮影した写真をcaptureImageに保存
            if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                parent.captureImage = originalImage
            }
            //sheetを閉じる
            parent.isShowSheet.toggle()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShowSheet.toggle()
        }
    }
    
    //Coordinatorを生成、SwiftUIによって自動的に呼び出し
    func makeCoordinator() -> Coordinator {
        //Coodinatorクラスのインスタンスを生成
        Coordinator(parent: self)
    }
    
    //Viewを生成する時に実行
    func makeUIViewController(context: Context) -> UIImagePickerController {
        // UIImagePickerControllerのインスタンスを生成
        let myImagePickerController = UIImagePickerController()
        //sourceTypeにcameraを設定
        myImagePickerController.sourceType = .camera
        //delegate設定
        myImagePickerController.delegate = context.coordinator
        //UIImagePickerControllerを返す
        return myImagePickerController
    }
    
    //Viewが更新された時に実行
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        //処理なし
    }
}

//#Preview {
//    ImagePickerView()
//}

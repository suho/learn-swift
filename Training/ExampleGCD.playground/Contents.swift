// : Playground - noun: a place where people can play

import UIKit

var str = "Hello, Grand Central Dispatch"

// Cách tạo một serial queues trong Swift

let mySerialQueue = dispatch_queue_create("mySerialQueue", DISPATCH_QUEUE_SERIAL)




// Cách tạo một concurrent queues trong Swift

let myConcurrent = dispatch_queue_create("myConcurrent", DISPATCH_QUEUE_CONCURRENT)

// Các queue có sẵn trong hệ thống

let myMainQueue = dispatch_get_main_queue()





let myGlobalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)

// Ví dụ tạo 1 tiến trình xử lý ở background sau đó cập nhật kết quả lên giao diện ở main thread

let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
dispatch_async(queue) {
    // do some task
    
    dispatch_async(dispatch_get_main_queue(), {
        // update some UI
        
    })
}

dispatch_resume(queue)

// Ví dụ về dispatch_after

let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, 1 * Int64(NSEC_PER_SEC))
dispatch_after(dispatchTime, dispatch_get_main_queue()) {
    // do something
}


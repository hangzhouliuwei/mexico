//
//  Untitled.swift
//  LoanPlus
//
//  Created by hao on 2024/12/4.
//

//var getDeviceData() -> [String:Any] [
    var data = [
        "storage": [//（ 单位Byte字节）
          "internal_storage_usable": "25675030528", //可用存储大小
          "internal_storage_total": "63865737216",  //总存储大小
          "ram_total_size": "3940270080",  //总内存大小
          "ram_usable_size": "1250131968" //内存可用大小
        ],
        "battery_status": [
          "battery_pct": 91,  //剩余电量（百分比）
          "battery_level": 380,//当前电量
          "is_usb_charge": 0,//是否USB充电(1:yes,0:no)
          "battery_max": 1000,//最大电量
          "is_ac_charge": 1,//是否交流充电(1:yes,0:no)
          "is_charging": 1   //是否正在充电(1:yes,0:no)
        ],
        "hardware": [
          "release": "15.5", //系统版本
          "brand": "iPhone", //设备名牌
          "model": "iPhone XS Max",//设备型号
          "device_height": 896,//分辨率高
          "device_width": 414,//分辨率宽
          "physical_size": "375*667",//格式变成375*667，变成1倍的
          "production_date": 1579095807000,//手机出厂时间戳
        ],
        "file_data": [
          //待补充 todo
        ],
        "other_data": [
          "dbm": 0,//手机信号强弱
          "simulator": 0,//是否为模拟器
          "root_jailbreak": 0 //是否越狱
        ],
        "build_id": 91,  //build_id（165）
        "build_name": 0, //build_name（1.6.5    ）
        "general_data": [
          "time_zone_id": "GMT+7",//时区的 ID
          "is_using_proxy_port": 0,//是否使用代理 0、1
          "is_using_vpn": 0,//是否使用vpn 0、1
          "network_operator_name": "Carrier",//移动通信运营商 ?? todo
          "idfv": "CB51F38F-3D83-47A8-8D56-C47E50FC04F6",//idfv
          "language": "en",//语言
          "network_type": "WIFI",//网络类型，全大写（风控要求） 2G、3G、4G、5G、WIFI、OTHER、NONE
          "phone_type": 1,//指示设备电话类型的常量1 手机;2 平板
          "ip": "192.168.0.15",//外网ip
          "idfa": "0716267A-2A2E-4ED7-AB81-66E206E511A2"//idfa
        ],
        "network":[
          "configured_wifi":[  //历史链接
            [
              "bssid":"68:d7:9a:7a:7e:4b",
              "mac":"68:d7:9a:7a:7e:4b",
              "name":"Shu_Xing_2G",
              "ssid":"Shu_Xing_2G"
            ]
          ],
          //保存的wifi数量
          "wifi_count":"1",
          //当前连接的wifi信息（如果没有，传空对象）
          "current_wifi":[
            "bssid":"68:d7:9a:7a:7e:4b",
            "mac":"68:d7:9a:7a:7e:4b",
            "name":"Shu_Xing_2G",
            "ssid":"CC583E99-6597-4A3C-9348-31C7AC880825"
          ]
        ]
    ] as [String : Any]
//]



//
//  EquipmentData.swift
//  workout
//
//  Created by Gemini on 2025/12/15.
//

import Foundation

struct EquipmentData {
    static let allEquipment: [Exercise] = [
        Exercise(
            name: "跑步機 (Treadmill)",
            img: "Treadmill",
            videoURL: nil,
            description: "有氧運動器材，可調整速度與坡度。",
            muscleGroups: "下肢肌群、心肺功能",
            instructions: "操作： 雙腳先跨站在跑帶兩側的固定板上，將「安全夾」夾在衣服上。按下 Start，待跑帶開始轉動後，再踩上去開始走或跑。",
            commonMistakes: "注意： 身體保持直立，視線看前方，不要一直低頭看儀表板。",
            category: "器材"
        ),
        Exercise(
            name: "橢圓機 (Elliptical Trainer)",
            img: "Elliptical Trainer",
            videoURL: nil,
            description: "低衝擊的有氧器材，模擬跑步動作。",
            muscleGroups: "全身肌群、心肺功能",
            instructions: "操作： 腳掌完全平貼在踏板上，雙手握住擺動手把。利用大腿與臀部的力量踩踏，手部輔助推拉。",
            commonMistakes: "注意： 膝蓋保持微彎，不要鎖死；腳跟不要離地。",
            category: "器材"
        ),
        Exercise(
            name: "飛輪/健身車 (Stationary Bike)",
            img: "Stationary Bike",
            videoURL: nil,
            description: "模擬騎腳踏車的運動器材。",
            muscleGroups: "股四頭肌、腿後肌群、小腿",
            instructions: "操作： 調整座椅高度，當腳踩到最低點時，膝蓋應保持微彎（約 25-30 度）。",
            commonMistakes: "注意： 背部挺直，不要過度聳肩。",
            category: "器材"
        ),
        Exercise(
            name: "划船機 (Rowing Machine)",
            img: "Rowing Machine",
            videoURL: nil,
            description: "模擬划船動作，鍛鍊全身耐力。",
            muscleGroups: "背部、腿部、手臂、核心",
            instructions: "操作： 綁好腳部固定帶。動作順序為：蹬腿 → 身體後傾 → 手拉握把至腹部。回程順序相反：手伸直 → 身體回正 → 屈膝回原位。",
            commonMistakes: "注意： 發力主要靠腿，而不是單純靠手拉。",
            category: "器材"
        ),
        Exercise(
            name: "登階機 (Stair Climber)",
            img: "Stair Climber",
            videoURL: nil,
            description: "模擬爬樓梯的運動器材。",
            muscleGroups: "臀大肌、股四頭肌、小腿",
            instructions: "操作： 像爬樓梯一樣，保持勻速踩踏。",
            commonMistakes: "注意： 身體不要過度前趴在扶手上，盡量靠臀部與大腿發力。",
            category: "器材"
        ),
        Exercise(
            name: "啞鈴 (Dumbbells)",
            img: "Dumbbells",
            videoURL: nil,
            description: "自由重量器材，可用於多種訓練。",
            muscleGroups: "全身各部位",
            instructions: "操作： 雙手握緊啞鈴中心。根據不同動作（如二頭彎舉、肩推），保持手腕中立，不要過度彎曲。",
            commonMistakes: "注意： 這是自由重量，核心肌群（腹部）必須全程收緊以維持身體穩定。",
            category: "器材"
        ),
        Exercise(
            name: "槓鈴 (Barbells)",
            img: "Barbells",
            videoURL: nil,
            description: "自由重量器材，適合大重量複合動作。",
            muscleGroups: "全身各部位",
            instructions: "操作： 雙手握距通常略寬於肩（視動作而定）。起槓時確保重心平穩。",
            commonMistakes: "注意： 槓鈴動作（如深蹲、硬舉）技術性高，新手建議先請教練或有人在旁輔助。",
            category: "器材"
        ),
        Exercise(
            name: "壺鈴 (Kettlebells)",
            img: "Kettlebells",
            videoURL: nil,
            description: "重心偏離把手的自由重量器材。",
            muscleGroups: "全身爆發力、核心",
            instructions: "操作： 常見動作為「盪壺 (Swing)」。雙腳開立，利用髖關節（屁股）前後推動的力量將壺鈴盪起，而非用手舉起。",
            commonMistakes: "注意： 腰背必須挺直，不可彎腰駝背。",
            category: "器材"
        ),
        Exercise(
            name: "臥推椅 (Weight Bench)",
            img: "Weight Bench",
            videoURL: nil,
            description: "用於躺姿或坐姿訓練的輔助長椅。",
            muscleGroups: "輔助器材",
            instructions: "操作： 調整椅背角度（平躺、上斜、下斜）。躺下時，頭、背、臀部緊貼椅面，雙腳踩實地面。",
            commonMistakes: "注意： 這是輔助器材，確認卡準已鎖死再躺下。",
            category: "器材"
        ),
        Exercise(
            name: "史密斯機器 (Smith Machine)",
            img: "Smith Machine",
            videoURL: nil,
            description: "固定軌道的槓鈴訓練器材。",
            muscleGroups: "全身各部位",
            instructions: "操作： 調整槓鈴高度。鑽入槓下扛起後，旋轉手腕將掛鉤轉開以解鎖。動作完成後，反向旋轉手腕將掛鉤掛回。",
            commonMistakes: "注意： 使用前請先確認左右兩側的「安全護擋」已設定在適當高度，以防力竭時壓傷。",
            category: "器材"
        ),
        Exercise(
            name: "深蹲架 / 力量架 (Power Rack)",
            img: "Power Rack  Squat Rack",
            videoURL: nil,
            description: "提供安全保護的槓鈴訓練架。",
            muscleGroups: "輔助器材",
            instructions: "操作： 將「J型鉤」（放槓鈴的鉤子）調至肩膀高度。設定兩側長條形的「安全護槓」至深蹲最低點略低的位置。",
            commonMistakes: "注意： 護槓是你的保命符，務必設定。",
            category: "器材"
        ),
        Exercise(
            name: "龍門架 / 纜繩機 (Cable Crossover)",
            img: "Cable Crossover Machine",
            videoURL: nil,
            description: "多功能的纜繩訓練機。",
            muscleGroups: "全身各部位",
            instructions: "操作： 調整滑輪高度（高、中、低位）。選擇合適的把手（繩索、直桿）。調整插銷重量。",
            commonMistakes: "注意： 身體保持穩定，動作過程中不要跟著纜繩前後搖晃。",
            category: "器材"
        ),
        Exercise(
            name: "坐姿胸推機 (Chest Press Machine)",
            img: "Chest Press Machine",
            videoURL: nil,
            description: "固定軌道的胸部推舉訓練機。",
            muscleGroups: "胸大肌、三頭肌、三角肌前束",
            instructions: "操作： 調整座椅，使兩側握把的高度位於胸線中段（乳頭連線）。挺胸，將握把向前推。",
            commonMistakes: "注意： 手肘不要完全鎖死，推出去時肩胛骨要貼在椅背上。",
            category: "器材"
        ),
        Exercise(
            name: "滑輪下拉機 (Lat Pulldown Machine)",
            img: "LatPulldownMachine",
            videoURL: nil,
            description: "鍛鍊背部寬度的訓練機。",
            muscleGroups: "背闊肌、二頭肌",
            instructions: "操作： 調整腿部擋墊壓住大腿。雙手寬握橫桿，稍微後傾，將橫桿拉至上胸/鎖骨位置。",
            commonMistakes: "注意： 是用背部力量下拉，而不是用手硬拉。不要拉到脖子後方。",
            category: "器材"
        ),
        Exercise(
            name: "坐姿划船機 (Seated Row Machine)",
            img: "Seated Row Machine",
            videoURL: nil,
            description: "鍛鍊背部厚度的訓練機。",
            muscleGroups: "背闊肌、菱形肌、斜方肌",
            instructions: "操作： 調整胸墊位置，使手拉握把時手肘微彎。動作時將手肘向後拉，夾緊肩胛骨。",
            commonMistakes: "注意： 身體不要過度前後擺盪，專注在背部收縮。",
            category: "器材"
        ),
        Exercise(
            name: "肩推機 (Shoulder Press Machine)",
            img: "Shoulder Press Machine",
            videoURL: nil,
            description: "固定軌道的肩部推舉訓練機。",
            muscleGroups: "三角肌、三頭肌",
            instructions: "操作： 調整座椅，使握把位於肩膀高度。雙手握住，向上推舉過頭。",
            commonMistakes: "注意： 手腕保持垂直，不要向後折。",
            category: "器材"
        ),
        Exercise(
            name: "腿推機 (Leg Press Machine)",
            img: "LegPressMachine",
            videoURL: nil,
            description: "腿部推舉訓練機，適合大重量訓練。",
            muscleGroups: "股四頭肌、臀大肌",
            instructions: "操作： 背部緊貼椅背，雙腳打開與肩同寬踩在踏板上。解開安全鎖，屈膝下放，再用力蹬出。",
            commonMistakes: "注意： 絕對不要將膝蓋完全伸直鎖死，這非常危險，膝蓋應保持微彎。",
            category: "器材"
        ),
        Exercise(
            name: "腿屈伸機 (Leg Extension Machine)",
            img: "LegExtensionMachine",
            videoURL: nil,
            description: "孤立鍛鍊股四頭肌的器械。",
            muscleGroups: "股四頭肌",
            instructions: "操作： 調整椅背，使膝蓋旋轉軸對準機器的軸心。圓筒墊應靠在腳踝上方。用力將小腿向上踢直。",
            commonMistakes: "注意： 這是單關節運動，重量不宜過重，以免傷膝蓋。",
            category: "器材"
        ),
        Exercise(
            name: "腿後勾機 (Leg Curl Machine)",
            img: "LegCurlMachine",
            videoURL: nil,
            description: "孤立鍛鍊腿後肌群的器械。",
            muscleGroups: "腿後肌群",
            instructions: "操作： (若是趴姿) 膝蓋對準軸心，圓筒墊靠在腳踝阿基里斯腱處。將小腿向臀部方向勾起。",
            commonMistakes: "注意： 臀部不要翹起離開墊子。",
            category: "器材"
        ),
        Exercise(
            name: "蝴蝶機 (Pec Fly)",
            img: "RearDeltMachine",
            videoURL: nil,
            description: "鍛鍊胸肌中縫與外側的器械。",
            muscleGroups: "胸大肌",
            instructions: "操作： 調整手臂擋板位置。坐正，雙手前臂貼在擋板上（或握把手），利用胸肌力量將雙手向中間夾攏。",
            commonMistakes: "注意： 手肘保持微彎，不要聳肩。",
            category: "器材"
        ),
        Exercise(
            name: "引體向上 / 雙槓撐體架",
            img: "PullUp",
            videoURL: nil,
            description: "利用自身體重進行訓練的複合器械。",
            muscleGroups: "背部、胸部、手臂",
            instructions: "操作：\n    * 引體向上： 雙手抓槓，利用背部力量將下巴拉過橫桿。\n    * 雙槓撐體： 雙手撐槓，身體下沉至手肘90度，再撐起。",
            commonMistakes: "注意： 若做不起來，許多健身房有「輔助型」機台，可跪在踏板上減輕體重。",
            category: "器材"
        ),
        Exercise(
            name: "羅馬椅 (Roman Chair)",
            img: "RomanChair",
            videoURL: nil,
            description: "鍛鍊下背與核心的器械。",
            muscleGroups: "下背、臀大肌、腿後肌群",
            instructions: "操作： 靠墊應卡在髖骨（骨盆）下方，讓上半身可以自由下彎。雙手抱胸，下彎後用下背力量挺起身體。",
            commonMistakes: "注意： 挺起到身體成一直線即可，不要過度後仰。",
            category: "器材"
        ),
        Exercise(
            name: "腹部訓練機 (Abdominal Machine)",
            img: "AbdominalMachine",
            videoURL: nil,
            description: "增加阻力的腹肌訓練器械。",
            muscleGroups: "腹直肌",
            instructions: "操作： 雙手握住上方握把，胸部頂住軟墊。利用腹肌力量「捲曲」身體向前彎。",
            commonMistakes: "注意： 不要用手拉，要想像把肚臍往內縮。",
            category: "器材"
        ),
        Exercise(
            name: "腿部外展/內收機",
            img: "AdductionMachine",
            videoURL: nil,
            description: "鍛鍊大腿內外側肌群的器械。",
            muscleGroups: "臀中肌、大腿內收肌",
            instructions: "操作：\n    * 外展（練臀）： 擋墊在膝蓋外側，雙腿用力向外打開。\n    * 內收（練大腿內側）： 擋墊在膝蓋內側，雙腿用力向內夾。",
            commonMistakes: "注意： 動作過程要慢，控制回放的速度。",
            category: "器材"
        ),
        Exercise(
            name: "TRX 懸吊訓練繩",
            img: "TRX",
            videoURL: nil,
            description: "利用懸吊不穩定性進行全身訓練。",
            muscleGroups: "全身、核心",
            instructions: "操作： 手握繩索，身體傾斜。利用自身體重進行推、拉、蹲等動作。",
            commonMistakes: "注意： 繩索必須隨時保持緊繃狀態，不能鬆垮。",
            category: "器材"
        )
    ]
}

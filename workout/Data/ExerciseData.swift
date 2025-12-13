//
//  ExerciseData.swift
//  workout
//
//  Created by user0862 on 2025/12/6.
//

import Foundation

struct ExerciseData {
    static let allExercises: [Exercise] = [
        Exercise(
            name: "深蹲 (Squats)",
            img: "exercise-detail-banner", // 列表中沒有單純的 "Squat.jpg"，暫時保留預設圖
            sets: 3,
            reps: "10 次",
            videoURL: URL(string: "https://www.youtube.com/watch?v=2J9zsFwhF2Q"),
            description: "",
            muscleGroups: "股四頭肌、臀大肌",
            instructions: "1. 雙腳與肩同寬，腳尖微朝外。\n2. 抬頭挺胸，核心收緊，背部打直。\n3. 臀部像坐椅子一樣向後推，同時下蹲，直到大腿與地面平行。\n4. 過程中保持膝蓋與腳尖方向一致。\n5. 用臀腿力量發力，站回起始位置。",
            commonMistakes: "1. 膝蓋內夾：在下蹲或站起時，膝蓋向內靠攏，這會對膝關節造成過大壓力。\n2. 駝背或過度拱背：背部沒有保持打直，容易導致下背部受傷。\n3. 下蹲深度不足：沒有蹲到大腿與地面平行的位置，會減少對臀腿肌群的刺激。\n4. 腳跟離地：重心過於前傾，導致腳跟抬起，動作不穩定。",
            category: "腿部"
        ),
        Exercise(
            name: "伏地挺身 (Pushups)",
            img: "Push-ups",
            sets: 3,
            reps: "8 次",
            videoURL: URL(string: "https://www.youtube.com/watch?v=gIrS4_UW5Fg"),
            description: "",
            muscleGroups: "胸肌、三頭肌、三角肌前束",
            instructions: "1. 雙手略寬於肩，撐在地面。\n2. 身體呈一直線，從頭到腳跟。\n3. 核心收緊，慢慢彎曲手肘，身體下降至胸部接近地面。\n4. 保持身體穩定，用胸部和手臂的力量推回起始位置。",
            commonMistakes: "1. 塌腰或翹臀：核心沒有收緊，導致身體無法呈一直線，下背壓力過大。\n2. 手肘過度外展：手肘在下降時過於向外張開，容易對肩關節造成壓力。\n3. 動作幅度不足：身體沒有下降到足夠低的位置，減少了對胸肌的鍛鍊效果。\n4. 速度過快：動作沒有控制，利用慣性完成，降低了肌肉的張力時間。",
            category: "胸部"
        ),
        Exercise(
            name: "啞鈴划船 (Dumbbell Row)",
            img: "Dumbbell rows",
            sets: 3,
            reps: "10 次 (每側)",
            videoURL: URL(string: "https://www.youtube.com/watch?v=mwyC_CLTHwE"),
            description: "",
            muscleGroups: "背闊肌、二頭肌、三角肌後束",
            instructions: "1. 單膝跪在長凳上，另一隻腳穩定踩地。\n2. 同側手支撐在長凳上，背部打直與地面平行。\n3. 另一手持啞鈴，自然下垂。\n4. 用背部力量將啞鈴往身體側邊拉起，直到上臂與背部平行。\n5. 緩慢下放，感受背部肌肉的伸展。",
            commonMistakes: "1. 用手臂硬拉：過度使用二頭肌的力量，而不是用背部肌肉來啟動動作。\n2. 身體過度晃動：利用身體的慣性來輔助完成動作，降低了對背肌的刺激。\n3. 聳肩：在拉起啞鈴時，肩膀向上聳起，讓斜方肌代償過多。\n4. 背部彎曲：沒有保持背部打直，容易造成下背部受傷。",
            category: "背部"
        ),
        Exercise(
            name: "平板支撐 (Plank)",
            img: "Plank",
            sets: 3,
            reps: "30 秒",
            videoURL: URL(string: "https://www.youtube.com/watch?v=YtFrzTIOkqQ"),
            description: "",
            muscleGroups: "核心肌群",
            instructions: "1. 以前臂和腳尖支撐身體。\n2. 手肘在肩膀正下方。\n3. 身體呈一直線，從頭到腳跟。\n4. 核心、臀部收緊，避免腰部下沉。",
            commonMistakes: "1. 塌腰或翹臀：核心力量不足，無法維持身體呈一直線。\n2. 憋氣：忘記在動作中保持自然呼吸。\n3. 肩膀過度用力：將過多重量壓在肩膀上，而不是由核心來承擔。\n4. 頭部過度下垂或後仰：頸部沒有與脊椎保持在同一條直線上。",
            category: "核心"
        ),
        Exercise(
            name: "硬舉 (Deadlifts)",
            img: "Deadlift",
            sets: 3,
            reps: "8 次",
            videoURL: URL(string: "https://www.youtube.com/watch?v=4rTdWgQbei0"),
            description: "",
            muscleGroups: "腿後肌群、臀大肌、下背",
            instructions: "1. 雙腳與肩同寬，槓鈴置於腳前。\n2. 膝蓋微彎，臀部後推，背部打直，雙手握住槓鈴。\n3. 核心收緊，用臀腿力量將槓鈴向上提起，身體打直。\n4. 緩慢下放槓鈴至地面，保持背部挺直。",
            commonMistakes: "1. 圓背：在提起或下放槓鈴時，背部彎曲，是硬舉中最危險的錯誤。\n2. 槓鈴離身體太遠：槓鈴路徑偏離身體中線，會增加下背的壓力。\n3. 用手臂拉起重量：硬舉主要是腿部和臀部的力量，手臂僅是輔助。\n4. 髖部和膝蓋不同步：站起時，髖部上升速度快於膝蓋，導致動作不協調。",
            category: "腿部"
        ),
        Exercise(
            name: "臥推 (Bench Press)",
            img: "Bench press",
            sets: 4,
            reps: "8 次",
            videoURL: URL(string: "https://www.youtube.com/watch?v=H6hCNnZEfl4"),
            description: "",
            muscleGroups: "胸肌、三頭肌、三角肌前束",
            instructions: "1. 仰臥於臥推椅，雙腳踩實地面。\n2. 雙手握住槓鈴，略寬於肩，手肘在槓鈴正下方。\n3. 核心收緊，將槓鈴緩慢下放至胸部上方，感受胸部伸展。\n4. 用胸部力量將槓鈴推回起始位置。",
            commonMistakes: "1. 半程動作：槓鈴沒有下放到胸部，或推起時手臂沒有完全伸直。\n2. 彈胸：利用槓鈴下放的慣性反彈，對胸骨有風險且降低效果。\n3. 手腕過度翻轉：手腕沒有保持中立，容易受傷。\n4. 臀部離開臥推椅：在推起時臀部抬起，會造成下背壓力。",
            category: "胸部"
        ),
        Exercise(
            name: "引體向上 (Pull-ups)",
            img: "Pull-ups",
            sets: 3,
            reps: "力竭",
            videoURL: URL(string: "https://www.youtube.com/watch?v=71UofCP10lc"),
            description: "",
            muscleGroups: "背闊肌、二頭肌",
            instructions: "1. 雙手正握單槓，略寬於肩。\n2. 身體懸空，核心收緊，啟動背部力量將身體向上拉。\n3. 下巴過槓，感受背部肌肉收縮。\n4. 緩慢下放身體，控制動作。",
            commonMistakes: "1. 身體晃動過大：利用慣性來完成動作，而非背部力量。\n2. 聳肩：過度使用斜方肌，而不是背闊肌。\n3. 動作幅度不足：下巴沒有過槓，或下放時手臂沒有伸直。\n4. 頸部過度前伸：用頭部去靠近單槓，而非用背部力量帶動身體。",
            category: "背部"
        ),
        Exercise(
            name: "肩推 (Overhead Press)",
            img: "Shoulder press",
            sets: 3,
            reps: "10 次",
            videoURL: URL(string: "https://www.youtube.com/watch?v=q4PT0UHyW9Q"),
            description: "",
            muscleGroups: "三角肌、三頭肌",
            instructions: "1. 雙手握住槓鈴或啞鈴，置於鎖骨上方。\n2. 核心收緊，將槓鈴向上推起，直到手臂完全伸直。\n3. 緩慢下放槓鈴至起始位置，控制動作。",
            commonMistakes: "1. 過度挺腰：在推起重量時，下背過度彎曲，對脊椎造成壓力。\n2. 動作幅度不足：手臂沒有完全伸直，或下放時不夠低。\n3. 聳肩：利用斜方肌代償，而非三角肌。\n4. 速度過快：沒有控制離心（下放）過程。",
            category: "手臂"
        ),
        Exercise(
            name: "划船 (Barbell Row)",
            img: "Row",
            sets: 3,
            reps: "10 次",
            videoURL: URL(string: "https://www.youtube.com/watch?v=UKLR1ol0_Nw"),
            description: "",
            muscleGroups: "背闊肌、中背、二頭肌",
            instructions: "1. 雙腳與肩同寬，膝蓋微彎，臀部後推，背部打直。\n2. 雙手握住槓鈴，身體前傾約 45 度。\n3. 用背部力量將槓鈴拉向肚臍，感受背部肌肉收縮。\n4. 緩慢下放槓鈴，控制動作。",
            commonMistakes: "1. 駝背：在動作過程中，背部沒有保持打直，容易受傷。\n2. 利用身體晃動：用身體的擺盪來拉起重量。\n3. 手肘過度向外：手肘應該沿著身體兩側移動。\n4. 過度使用手臂力量：沒有專注於背部肌肉的收縮。",
            category: "背部"
        ),
        
        Exercise(
            name: "前蹲舉 (Front Squats)",
            img: "Front squat",
            sets: 4,
            reps: "6 次",
            videoURL: URL(string: "https://www.youtube.com/watch?v=nmUof3vszxM"),
            description: "",
            muscleGroups: "股四頭肌、核心",
            instructions: "1. 雙手交叉或托住槓鈴，置於鎖骨上方。\n2. 雙腳與肩同寬，腳尖微朝外。\n3. 保持背部挺直，臀部後推下蹲，直到大腿與地面平行。\n4. 用臀腿力量發力，站回起始位置。",
            commonMistakes: "1. 手肘下垂：在下蹲時，手肘沒有保持抬高，容易導致槓鈴滑落。\n2. 駝背：背部沒有保持打直，尤其是上背部。\n3. 膝蓋內夾：與後蹲舉相同，膝蓋在下蹲或站起時內夾。\n4. 腳跟離地：重心過於前傾，導致腳跟抬起。",
            category: "腿部"
        ),
        Exercise(
            name: "上斜臥推 (Incline Press)",
            img: "Incline bench press",
            sets: 4,
            reps: "8 次",
            videoURL: URL(string: "https://www.youtube.com/watch?v=aWzskio2104"),
            description: "",
            muscleGroups: "胸肌、三頭肌、三角肌前束",
            instructions: "1. 調整臥推椅至上斜角度。\n2. 仰臥於臥推椅，雙腳踩實地面。\n3. 雙手握住槓鈴，略寬於肩，將槓鈴下放至上胸。\n4. 用胸部力量將槓鈴推回起始位置。",
            commonMistakes: "1. 角度太大：臥推椅角度過高，會讓三角肌參與過多，減少對胸肌上緣的刺激。\n2. 槓鈴下放位置錯誤：將槓鈴下放到脖子或腹部，而非上胸。\n3. 手腕過度翻轉：與平板臥推相同，手腕沒有保持中立。\n4. 聳肩：在推起重量時，肩膀向上聳起。",
            category: "胸部"
        ),
        Exercise(
            name: "爆發上膊 (Power Cleans)",
            img: "Power clean",
            sets: 3,
            reps: "5 次",
            videoURL: URL(string: "https://www.youtube.com/watch?v=KwYJTpQ_x5A"),
            description: "",
            muscleGroups: "全身協調、爆發力、腿部、背部、肩部",
            instructions: "1. 雙腳與肩同寬，槓鈴置於腳前。\n2. 膝蓋微彎，臀部後推，背部打直，雙手握住槓鈴。\n3. 爆發性地將槓鈴向上拉起，同時身體迅速下蹲，將槓鈴翻至鎖骨上方。\n4. 站起，完成動作。",
            commonMistakes: "1. 過早用手臂拉：在腿部和臀部還沒完全發力前，就用手臂去拉槓鈴。\n2. 翻槓時手肘太慢：在接槓時，手肘沒有快速向前翻，導致接槓不穩。\n3. 槓鈴路徑離身體太遠：與硬舉相同，槓鈴路徑應該貼近身體。\n4. 下蹲接槓不夠深：害怕下蹲，導致接槓位置過高。",
            category: "其他"
        ),
        Exercise(
            name: "羅馬尼亞硬舉 (Romanian Deadlifts)",
            img: "Romanian deadlift",
            sets: 3,
            reps: "10 次",
            videoURL: URL(string: "https://www.youtube.com/watch?v=EHXbjmWqLAg"),
            description: "",
            muscleGroups: "腿後肌群、臀大肌、下背",
            instructions: "1. 雙腳與肩同寬，膝蓋微彎，雙手握住槓鈴。\n2. 保持背部挺直，臀部後推，將槓鈴下放至小腿中部。\n3. 感受腿後肌群的拉伸，用臀部力量將身體拉回起始位置。",
            commonMistakes: "1. 變成深蹲：膝蓋彎曲過多，而不是以髖關節為主導的動作。\n2. 圓背：在下放或拉起時，背部沒有保持打直。\n3. 槓鈴離身體太遠：槓鈴應該沿著腿部下放和拉起。\n4. 過度伸展：在拉起時，身體向後過度挺伸。",
            category: "腿部"
        ),
        Exercise(
            name: "雙槓撐體 (Dips)",
            img: "Parallel bar push-ups", // 使用列表中最接近的圖片
            sets: 3,
            reps: "力竭",
            videoURL: URL(string: "https://www.youtube.com/watch?v=9vKlFeQg3nM"),
            description: "",
            muscleGroups: "三頭肌、胸肌、三角肌前束",
            instructions: "1. 雙手撐在雙槓上，身體懸空。\n2. 核心收緊，慢慢彎曲手肘，身體下放至胸部接近槓面。\n3. 用三頭肌和胸部力量將身體推回起始位置。",
            commonMistakes: "1. 下放太深：身體下放過低，會對肩關節造成過大壓力。\n2. 聳肩：在撐起時，肩膀向上聳起，而非保持下沉。\n3. 身體晃動：利用慣性來完成動作。\n4. 手肘過度外展：手肘應該靠近身體兩側。",
            category: "手臂"
        ),
        Exercise(
            name: "農夫走路 (Farmer's Walk)",
            img: "Farmer_s walk",
            sets: 3,
            reps: "50 公尺",
            videoURL: URL(string: "https://www.youtube.com/watch?v=315xVOcaBUg"),
            description: "",
            muscleGroups: "前臂、核心、斜方肌",
            instructions: "1. 雙手各持一個重啞鈴或壺鈴。\n2. 保持背部挺直，核心收緊，穩定行走指定距離。",
            commonMistakes: "1. 駝背：核心力量不足，無法在行走中維持背部挺直。\n2. 步態不穩：行走時身體過度搖晃。\n3. 聳肩：過度使用斜方肌來提重物，而非讓前臂和握力來承擔。\n4. 呼吸不順暢：忘記在行走中保持自然呼吸。",
            category: "其他"
        ),
        Exercise(
            name: "壺鈴擺盪 (Kettlebell Swings)",
            img: "Kettlebell swing",
            sets: 3,
            reps: "15 次",
            videoURL: URL(string: "https://www.youtube.com/watch?v=t7_N0nQqK6c"),
            description: "",
            muscleGroups: "臀大肌、腿後肌群、核心",
            instructions: "1. 雙腳略寬於肩，膝蓋微彎，臀部後推，雙手握住壺鈴。\n2. 用臀部爆發力將壺鈴向前擺盪至胸前高度。\n3. 壺鈴下落時，臀部後推，順勢擺盪。",
            commonMistakes: "1. 用手臂上舉：這是一個擺盪動作，力量主要來自臀部，而非用手臂將壺鈴舉起。\n2. 變成深蹲：膝蓋彎曲過多，而不是以髖關節鉸鏈（hinge）為主導。\n3. 核心不穩：在擺盪過程中，核心沒有收緊，導致身體不穩定。\n4. 擺盪過高：將壺鈴擺盪超過頭部，會對肩關節造成不必要的壓力。",
            category: "其他"
        )
    ]
    
    static func getExercises(by names: [String]) -> [Exercise] {
        return names.compactMap { name in
            allExercises.first { $0.name == name }
        }
    }
    
    static let beginnerWorkout = Workout(
        name: "新手全身訓練 A",
        description: "5 個動作・約 45 分鐘",
        duration: 45 * 60,
        calories: 320,
        level: "基礎",
        exercises: getExercises(by: ["深蹲 (Squats)", "伏地挺身 (Pushups)", "啞鈴划船 (Dumbbell Row)", "平板支撐 (Plank)"]).map { WorkoutExercise(exercise: $0, sets: $0.sets) }
    )
    
    static let intermediateWorkout = Workout(
        name: "中級肌力訓練 B",
        description: "6 個動作・約 60 分鐘",
        duration: 60 * 60,
        calories: 450,
        level: "中級",
        exercises: getExercises(by: ["硬舉 (Deadlifts)", "臥推 (Bench Press)", "引體向上 (Pull-ups)", "肩推 (Overhead Press)", "划船 (Barbell Row)", "棒式 (Plank)"]).map { WorkoutExercise(exercise: $0, sets: $0.sets) }
    )
    
    static let advancedWorkout = Workout(
        name: "進階高強度訓練 C",
        description: "7 個動作・約 75 分鐘",
        duration: 75 * 60,
        calories: 600,
        level: "進階",
        exercises: getExercises(by: ["前蹲舉 (Front Squats)", "上斜臥推 (Incline Press)", "爆發上膊 (Power Cleans)", "羅馬尼亞硬舉 (Romanian Deadlifts)", "雙槓撐體 (Dips)", "農夫走路 (Farmer's Walk)", "壺鈴擺盪 (Kettlebell Swings)"]).map { WorkoutExercise(exercise: $0, sets: $0.sets) }
    )
}

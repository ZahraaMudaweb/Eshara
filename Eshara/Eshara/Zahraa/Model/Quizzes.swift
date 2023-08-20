//
//  Quizzes.swift
//  Eshara
//
//  Created by Zahraa AlMudaweb on 10/08/2023.
//

import Foundation

struct Question {
        let imgName: String
        let questionText: String
        let options: [String]
        let correctAns: Int
        var wrongAns: Int
        var isAnswered: Bool
}

let familyQ1 = Question(imgName: "أب", questionText: "لمن تُستخدم هذه الإشارة؟", options: ["للأم", "للأخ", "للأب", "للعم"], correctAns: 2, wrongAns: -1, isAnswered: false)
let familyQ2 = Question(imgName: "توأم", questionText: "ماذا تعني هذه الإشارة؟", options: ["طفل", "توأم", "حفيد", "أسرة"], correctAns: 1, wrongAns: -1, isAnswered: false)
let familyQ3 = Question(imgName: "العم", questionText: "لمن تُستخدم هذه الإشارة؟", options: ["العم", "الرجل", "الخال", "الجد"], correctAns: 0, wrongAns: -1, isAnswered: false)
let familyQ4 = Question(imgName: "الخالة", questionText: "ما معنى هذه الإشارة؟", options: ["الأم", "الخال", "الجدة", "الخالة"], correctAns: 3, wrongAns: -1, isAnswered: false)
let familyQ5 = Question(imgName: "أسرة", questionText: "ما معنى هذه الإشارة؟", options: ["تجمع", "أسرة", "طائفة", "مجموعة"], correctAns: 1, wrongAns: -1, isAnswered: false)

let familyQuestions = [familyQ1, familyQ2, familyQ3, familyQ4, familyQ5]

let chatQ1 = Question(imgName: "السلام عليكم", questionText: "متى تُستخدم هذه الإشارة؟", options: ["عند التحية", "عند الوداع", "عند", "لطلب المساعدة", "عند النداء"], correctAns: 1, wrongAns: -1, isAnswered: false)
let chatQ2 = Question(imgName: "كيف حالك؟", questionText: "ما معنى هذه الإشارة؟", options: ["أينك؟", "ما اسمك؟", "كيف حالك؟", "متى ستأتي؟"], correctAns: 2, wrongAns: -1, isAnswered: false)
let chatQ3 = Question(imgName: "أنا بخير", questionText: "ما معنى هذه الإشارة؟", options: ["أنا بخير", "أحسنت", "لا تقلق", "ممتاز"], correctAns: 0, wrongAns: -1, isAnswered: false)
let chatQ4 = Question(imgName: "آسف", questionText: "لماذا تُستخدم هذه الإشارة؟", options: ["للاعتذار", "لطلب المساعدة", "للاستئذان", "للشكر"], correctAns: 0, wrongAns: -1, isAnswered: false)
let chatQ5 = Question(imgName: "لو سمحت", questionText: "ما معنى هذه الإشارة؟", options: ["عذرًا", "أخبرني", "تفضل", "لو سمحت"], correctAns: 3, wrongAns: -1, isAnswered: false)

let chatQuestions = [chatQ1, chatQ2, chatQ3, chatQ4, chatQ5]

let schoolQ1 = Question(imgName: "كيمياء", questionText: "إلى أي المواد ترمز هذه الإشارة؟", options: ["الفيزياء", "الرياضيات", "الكيمياء", "الحاسوب"], correctAns: 2, wrongAns: -1, isAnswered: false)
let schoolQ2 = Question(imgName: "لغة فرنسية", questionText: "إلى أي لغة ترمز هذه الإشارة؟", options: ["الفرنسية", "العربية", "الإنجليزية", "اليابانية"], correctAns: 0, wrongAns: -1, isAnswered: false)
let schoolQ3 = Question(imgName: "امتحان", questionText: "ما معنى هذه الإشارة؟", options: ["بالتوفيق", "امتحان", "صف دراسي", "ممتاز"], correctAns: 1, wrongAns: -1, isAnswered: false)
let schoolQ4 = Question(imgName: "يتعلم", questionText: "ما معنى هذه الإشارة؟", options: ["يقرأ", "يكتب", "يتعلم", "يعلم"], correctAns: 2, wrongAns: -1, isAnswered: false)
let schoolQ5 = Question(imgName: "رياضيات", questionText: "إلى أي مادة تشير هذه الإشارة؟", options: ["اللغة العربية", "الرياضيات", "الفنون", "العلوم"], correctAns: 1, wrongAns: -1, isAnswered: false)

let schoolQuestions = [schoolQ1, schoolQ2, schoolQ3, schoolQ4, schoolQ5]

let hospitalQ1 = Question(imgName: "سعال", questionText: "ما معنى هذه الإشارة؟", options: ["ألم", "حمى", "مريض", "سعال"], correctAns: 3, wrongAns: -1, isAnswered: false)
let hospitalQ2 = Question(imgName: "صيدلية", questionText: "ما معنى هذه الإشارة؟", options: ["صيدلية", "صداع", "زكام", "سرطان"], correctAns: 0, wrongAns: -1, isAnswered: false)
let hospitalQ3 = Question(imgName: "حمى", questionText: "إلى أي الأمراض ترمز هذه الإشارة؟", options: ["زكام", "حمى", "صداع", "حساسية"], correctAns: 1, wrongAns: -1, isAnswered: false)
let hospitalQ4 = Question(imgName: "ضماد", questionText: "ما معنى هذه الإشارة؟", options: ["فحص نظر", "عدوى", "ميزان حرارة", "ضماد"], correctAns: 3, wrongAns: -1, isAnswered: false)
let hospitalQ5 = Question(imgName: "سرطان", questionText: "إلى أي الأمراض ترمز هذه الإشارة؟", options: ["الصداع", "الزكام", "السرطان", "الحمى"], correctAns: 2, wrongAns: -1, isAnswered: false)

let hospitalQuestions = [hospitalQ1, hospitalQ2, hospitalQ3, hospitalQ4, hospitalQ5]


let houseQ1 = Question(imgName: "ديوانية", questionText: "إلى أي المرافق ترمز هذه الإشارة؟", options: ["الديوانية", "غرفة النوم", "المطبخ", "دورة المياه"], correctAns: 0, wrongAns: -1, isAnswered: false)
let houseQ2 = Question(imgName: "تلفاز", questionText: "ما الذي تعنيه هذه الإشارة؟", options: ["بيت", "تلفاز", "حديقة", "ثلاجة"], correctAns: 1, wrongAns: -1, isAnswered: false)
let houseQ3 = Question(imgName: "طاولة", questionText: "إلامَ ترمز هذه الإشارة؟", options: ["كرسي", "طاولة", "باب", "كهرباء"], correctAns: 1, wrongAns: -1, isAnswered: false)
let houseQ4 = Question(imgName: "بيت", questionText: "ما معنى هذه الإشارة؟", options: ["جار", "إضاءة", "بيت", "غرفة"], correctAns: 2, wrongAns: -1, isAnswered: false)
let houseQ5 = Question(imgName: "سرير", questionText: "إلامَ ترمز هذه الإشارة؟", options: ["مطبخ", "مكتب", "ملعب", "سرير"], correctAns: 3, wrongAns: -1, isAnswered: false)

let houseQuestions = [houseQ1, houseQ2, houseQ3, houseQ4, houseQ5]

let animalsQ1 = Question(imgName: "دب", questionText: "إلى أي حيوان ترمز هذه الإشارة؟", options: ["أخطبوط", "محار", "دب", "خروف"], correctAns: 2, wrongAns: -1 , isAnswered: false)
let animalsQ2 = Question(imgName: "بطة", questionText: "إلى أي حيوان ترمز هذه الإشارة؟", options: ["ثور", "بطة", "حيوان", "أرنب"], correctAns: 1, wrongAns: -1 , isAnswered: false)
let animalsQ3 = Question(imgName: "قرد", questionText: "إلى أي حيوان ترمز هذه الإشارة؟", options: ["قرد", "هدهد", "طائر", "تيس"], correctAns: 0, wrongAns: -1 , isAnswered: false)
let animalsQ4 = Question(imgName: "هدهد", questionText: "إلى أي حيوان ترمز هذه الإشارة؟", options: ["الذئب", "الهدهد", "الحصان", "الخروف"], correctAns: 1, wrongAns: -1 , isAnswered: false)
let animalsQ5 = Question(imgName: "طائر", questionText: "إلى أي صنف من الحيوانات ترمز هذه الإشارة؟", options: ["الزواحف", "الحشرات", "الثدييات", "الطيور"], correctAns: 3, wrongAns: -1, isAnswered: false)

let animalsQuestions = [animalsQ1, animalsQ2, animalsQ3, animalsQ4, animalsQ5]

let questionsArray = [familyQuestions, chatQuestions, schoolQuestions, hospitalQuestions, houseQuestions, animalsQuestions]

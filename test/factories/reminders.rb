# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reminder do
    user_id     1
    parent_id   1
    status      ""
    fq_time     { Time.now }
  end

  factory :daily, parent: :reminder do 
    fq_type 'Daily'
  end

  factory :weekly, parent: :reminder do
    fq_type 'Weekly'
    fq_day  3 # 0 -> Sunday, 1 -> Monday, 2 -> Tuesday, 3 -> Wednesday, 4 -> Thrusday, 5 -> Friday, 6 -> Saturday
  end

  factory :monthly, parent: :reminder do
    fq_type "Monthly"
    fq_day  15 # 15th day of Month
  end

  factory :yearly, parent: :reminder do 
    fq_type   'Yearly'
    fq_month  4 # April
    fq_day    20 # 20th day of April
  end
end

FactoryBot.define do
  factory :student do
    first_name { 'MyString' }
    last_name { 'MyString' }
    surname { 'MyString' }
    class_id { 1 }
    school_id { 1 }
  end
end

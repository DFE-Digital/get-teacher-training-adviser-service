FactoryBot.define do
  factory :have_a_degree do
    degree { HaveADegree::OPTIONS[:yes] }
  
    trait :no do
      degree { HaveADegree::OPTIONS[:no] }
    end

    trait :studying do
      degree { HaveADegree::OPTIONS[:studying] }
    end

    trait :equivalent do
      degree { HaveADegree::OPTIONS[:equivalent] }
    end
  end
end


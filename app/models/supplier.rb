class Supplier < ApplicationRecord
    validates :corporate_name, :brand_name, :registration_number, :email, presence: true
    validates :registration_number, uniqueness: true
    validates :registration_number, length: { is: 14 }

    def full_description
        "#{corporate_name} - #{registration_number}"
    end
end

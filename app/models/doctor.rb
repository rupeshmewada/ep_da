class Doctor < ApplicationRecord

    has_many :appointments
    has_many :patients ,through: :appointments


    # def self.search(search)
    #     # Title is for the above case, the OP incorrectly had 'name'
    #     where("name LIKE ? OR specilization LIKE ? ", "%#{search}%", "%#{search}%")
    # end
end

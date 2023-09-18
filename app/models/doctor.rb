class Doctor < ApplicationRecord

    has_many :appointments
    has_many :patients ,through: :appointments

    has_one_attached :image

    def self.search(search)
        # Title is for the above case, the OP incorrectly had 'name'
        where("name LIKE ? OR specilization LIKE ? OR location  LIKE ?  ", "%#{search}%", "%#{search}%","%#{search}%" )
    end
    
    
end

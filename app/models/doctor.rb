class Doctor < ApplicationRecord

    has_many :appointments
    has_many :patients ,through: :appointments

    has_one_attached :image
    # validates :password, presence: true,length: { minimum: 5 }
    validates :password, presence: true
    # def self.search(search)
    #     # Title is for the above case, the OP incorrectly had 'name'
    #     where("name LIKE ? OR specilization LIKE ? OR location  LIKE ?  ", "%#{search}%", "%#{search}%","%#{search}%" )
    # end
    
    
end


class Image < ActiveRecord::Base
	belongs_to :post
	mount_uploader :picture
	
	validates :picture, presence: true
end

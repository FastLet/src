class Post < ActiveRecord::Base
	belongs_to :user
	has_many :images, :dependent=> :destroy
	accepts_nested_attributes_for :images, :reject_if => lambda { |a| a[:picture].blank? }, :allow_destroy => true

end

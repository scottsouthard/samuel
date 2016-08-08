class Post < ApplicationRecord

  has_many :pictures, :dependent => :destroy

  validates :date, presence: true, uniqueness: true
  validates :title, presence: true
  validates :description, presence: true

  has_attached_file :document
  validates_attachment :document, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }

end

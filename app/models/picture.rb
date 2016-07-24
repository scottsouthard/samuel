class Picture < ApplicationRecord
  belongs_to :post
  has_attached_file :image, styles: { large: "900x900>", medium: "300x300>"}, :path => ":rails_root/public/images/:style/:id/:filename", :url  => "/images/:style/:id/:filename"

  do_not_validate_attachment_file_type :image
end

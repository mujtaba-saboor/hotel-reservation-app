class AddAttachmentPhotoToHotels < ActiveRecord::Migration
  def self.up
    change_table :hotels do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :hotels, :photo
  end
end

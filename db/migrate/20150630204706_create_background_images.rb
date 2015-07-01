class CreateBackgroundImages < ActiveRecord::Migration
  def change
    create_table :background_images do |t|
        # add index with a contrived name, due to sqlite index name length limit of 62
        # rails/paperclip want to use 'index_background_images_on_backgroundable_type_and_backgroundable_id'
        # obviously that ain't gonna fit, yo
        t.references :backgroundable, polymorphic: true, index: {name: 'index_background_images_on_polymorphic_backgroundable'}
        
        t.attachment :image
        
        t.timestamps null: false
    end
  end
end

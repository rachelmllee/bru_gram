class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name
      t.string :image_url
      t.text :caption
      t.boolean :public
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

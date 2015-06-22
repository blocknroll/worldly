class CreateEventfulInfos < ActiveRecord::Migration
  def change
    create_table :eventful_infos do |t|

      t.timestamps null: false
    end
  end
end

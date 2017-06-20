class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name, index: true
      t.string :url, index: true, unique: true
      t.string :jobs_url
      t.string :logo
      t.string :yc_class
      t.string :description

      t.timestamps
    end
  end
end

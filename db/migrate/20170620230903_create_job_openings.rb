class CreateJobOpenings < ActiveRecord::Migration[5.1]
  def change
    create_table :job_openings do |t|
      t.string :title
      t.string :location
      t.string :commitment
      t.string :team, index: true
      t.string :description
      t.string :salary
      t.string :url, index: true
      t.references :company

      t.timestamps
    end
  end
end

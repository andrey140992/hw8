class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :report_type
      t.string :report_data

      t.timestamps
    end
  end
end

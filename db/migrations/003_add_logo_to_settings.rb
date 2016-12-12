Sequel.migration do
  change do
    alter_table(:settings) do
      add_column :logo_url, String
    end
  end
end

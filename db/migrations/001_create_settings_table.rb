Sequel.migration do
  change do
    create_table(:settings) do
      primary_key :id
      String :site_name
      String :site_title
      String :site_description
      String :site_keywords
    end
  end
end

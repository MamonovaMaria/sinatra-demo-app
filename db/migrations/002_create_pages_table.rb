Sequel.migration do
  change do
    create_table(:pages) do
      primary_key :id
      String :page_url
      String :page_title
      String :page_description
      String :page_keywords
      String :page_content, :text=>true
      Integer :parent_id
      TrueClass :published, :default=>true
    end
  end
end

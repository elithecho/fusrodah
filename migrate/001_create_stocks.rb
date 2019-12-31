Sequel.migration do
  change do
    create_table :modool do
      primary_key :id
    end
  end
end

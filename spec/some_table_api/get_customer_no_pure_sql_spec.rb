describe 'get customer number using pure SQL setup' do

  before(:all) do
    plsql.execute <<-SQL
      INSERT INTO customers(customer_id, customer_no,customer_valid_flag)
      VALUES (-1, 123456, '1')
    SQL
  end

  it 'returns expected customer number as a numeric value' do
    expect( plsql.some_table_api.get_customer_no(-1) ).to eq 123456
  end

  it 'returns expected customer number as a numeric value through assignment' do
    result = plsql.some_table_api.get_customer_no(-1)
    expect( result ).to eq 123456
  end

end

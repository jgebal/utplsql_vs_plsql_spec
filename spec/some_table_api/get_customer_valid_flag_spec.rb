describe 'get customer valid flag' do

  before(:all) do
    plsql.customers.insert({customer_id: -1, customer_no: 123456, customer_valid_flag: '1' })
  end

  it 'returns expected customer validity flag as a character' do
    expect( plsql.some_table_api.get_customer_valid_flag(-1) ).to eq '1'
  end

  it 'returns expected customer validity flag as a character through assignment' do
    result = plsql.some_table_api.get_customer_valid_flag(-1)
    expect( result ).to eq '1'
  end
end

describe 'get customer valid flag for existing data' do

  before(:all) do
    @tested_customer = plsql.customers.first
  end

  it 'returns expected customer validity flag' do
    expect( plsql.some_table_api.get_customer_valid_flag( @tested_customer[:customer_id] ) ).to eq @tested_customer[:customer_valid_flag]
  end

  it 'returns expected customer validity flag through assignment' do
    result = plsql.some_table_api.get_customer_valid_flag( @tested_customer[:customer_id] )
    expect( result ).to eq @tested_customer[:customer_valid_flag]
  end

  it 'returns expected customer validity flag with type check' do
    result = plsql.some_table_api.get_customer_valid_flag( @tested_customer[:customer_id] )
    expect( result.class ).to eq(String)
    expect( result ).to eq @tested_customer[:customer_valid_flag]
  end

end

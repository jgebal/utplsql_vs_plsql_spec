require_relative '../spec_helper'

describe 'get customer valid flag' do

  before(:all) do
    plsql.customers.insert({customer_id: -1, customer_no: 123456, customer_valid_flag: '1' })
  end

  it 'returns expected customer validity flag as a character' do
    expect( plsql.some_table_api.get_customer_valid_flag(-1) ).to eq '1'
  end

end

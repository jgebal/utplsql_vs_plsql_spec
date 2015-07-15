require_relative '../spec_helper'

describe 'get customer number' do

  before(:all) do
    plsql.customers.insert({customer_id: -1, customer_no: 123456, customer_valid_flag: '1' })
  end

  it 'returns expected customer number as a numeric value' do
    expect( plsql.some_table_api.get_customer_no(-1) ).to eq 123456
  end

end

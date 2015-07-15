require_relative '../spec_helper'

describe 'get customer number' do

  before(:all) do
    plsql.customers.insert({customer_id: -1, customer_no: 123456, customer_valid_flag: '1' })
  end

  it 'returns expected customer number as a numeric value' do
    expect( plsql.some_table_api.get_customer_no(-1) ).to eq 123456
  end

  it 'returns expected customer number as a numeric value through assignment' do
    result = plsql.some_table_api.get_customer_no(-1)
    expect( result ).to eq 123456
  end

end

describe 'get customer number for existing data' do

  before(:all) do
    @tested_customer = plsql.customers.first
  end

  it 'returns expected customer number' do
    expect( plsql.some_table_api.get_customer_no( @tested_customer[:customer_id] ) ).to eq @tested_customer[:customer_no]
  end

  it 'returns expected customer number through assignment' do
    result = plsql.some_table_api.get_customer_no( @tested_customer[:customer_id] )
    expect( result ).to eq @tested_customer[:customer_no]
  end

  it 'returns expected customer number with type check' do
    result = plsql.some_table_api.get_customer_no( @tested_customer[:customer_id] )
    expect( result.class ).to eq(Fixnum)
    expect( result ).to eq @tested_customer[:customer_no]
  end

end

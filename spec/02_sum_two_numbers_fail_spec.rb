require_relative 'spec_helper'

describe 'sum_two_numbers' do

  it 'returns 10 for arguments 5 and 5' do
    expect( plsql.sum_two_numbers_fail(5,5) ).to eq 10
  end

end

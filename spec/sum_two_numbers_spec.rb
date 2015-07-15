require_relative 'spec_helper'

describe 'sum_two_numbers' do

  it 'returns 10 for arguments 5 and 5' do
    expect( plsql.sum_two_numbers(5,5) ).to eq 10
  end

  100.times do |i|
    it "returns #{i+10} for arguments #{i} and 10" do
      expect( plsql.sum_two_numbers_100_times(i,10) ).to eq i+10
    end
  end

end
